extends RefCounted
class_name RegionInventory

var resources: Dictionary = {}
var storage_bonus_caps: Dictionary = {}


func reset() -> void:
    resources = {
        "Wood": 0,
        "Stone": 0,
        "Fiber": 0,
        "Flint": 0,
        "Berries": 0,
        "Mushrooms": 0,
        "Reeds": 0,
        "Clay": 0,
        "Fish": 0
    }

    storage_bonus_caps = {}


func add_resources(harvested_resources: Dictionary) -> void:
    var resource_names: Array = harvested_resources.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var harvested_amount: int = int(harvested_resources.get(resource_name, 0))

        add_resource(resource_name, harvested_amount)


func add_resource(resource_name: String, amount: int) -> int:
    if amount <= 0:
        return 0

    var current_amount: int = int(resources.get(resource_name, 0))
    var max_amount: int = get_resource_cap(resource_name)
    var available_space: int = max_amount - current_amount

    if available_space <= 0:
        return 0

    var accepted_amount: int = mini(amount, available_space)

    resources[resource_name] = current_amount + accepted_amount

    if accepted_amount < amount:
        print(
            "Storage full for ",
            resource_name,
            ". Accepted ",
            accepted_amount,
            " of ",
            amount,
            "."
        )

    return accepted_amount


func can_accept_resource(resource_name: String) -> bool:
    var current_amount: int = int(resources.get(resource_name, 0))
    var max_amount: int = get_resource_cap(resource_name)

    return current_amount < max_amount


func can_accept_any_resource(resource_names: Array) -> bool:
    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])

        if can_accept_resource(resource_name):
            return true

    return false


func get_resource_cap(resource_name: String) -> int:
    var base_cap: int = RegionBuildingData.STORAGE_BASE_RESOURCE_CAP
    var bonus_cap: int = int(storage_bonus_caps.get(resource_name, 0))

    return base_cap + bonus_cap


func add_storage_capacity(resource_name: String, amount: int) -> void:
    if resource_name == "":
        return

    if amount <= 0:
        return

    var current_bonus: int = int(storage_bonus_caps.get(resource_name, 0))
    storage_bonus_caps[resource_name] = current_bonus + amount

    if not resources.has(resource_name):
        resources[resource_name] = 0

    print(
        "Storage capacity increased for ",
        resource_name,
        " by ",
        amount,
        ". New cap: ",
        get_resource_cap(resource_name)
    )


func remove_storage_capacity(resource_name: String, amount: int) -> void:
    if resource_name == "":
        return

    if amount <= 0:
        return

    var current_bonus: int = int(storage_bonus_caps.get(resource_name, 0))
    var new_bonus: int = max(0, current_bonus - amount)

    if new_bonus <= 0:
        storage_bonus_caps.erase(resource_name)
    else:
        storage_bonus_caps[resource_name] = new_bonus

    var current_amount: int = int(resources.get(resource_name, 0))
    var new_cap: int = get_resource_cap(resource_name)

    if current_amount > new_cap:
        resources[resource_name] = new_cap
        print(
            "Storage capacity reduced for ",
            resource_name,
            ". Excess was discarded. New amount: ",
            new_cap
        )

    print(
        "Storage capacity reduced for ",
        resource_name,
        " by ",
        amount,
        ". New cap: ",
        get_resource_cap(resource_name)
    )


func get_resource_names_with_amount(minimum_amount: int = 1) -> Array:
    var valid_resources: Array = []
    var resource_names: Array = resources.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var current_amount: int = int(resources.get(resource_name, 0))

        if current_amount >= minimum_amount:
            valid_resources.append(resource_name)

    return valid_resources


func get_selectable_storage_resources() -> Array:
    return get_resource_names_with_amount(1)


func has_cost(cost: Dictionary) -> bool:
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var required_amount: int = int(cost.get(resource_name, 0))
        var current_amount: int = int(resources.get(resource_name, 0))

        if current_amount < required_amount:
            return false

    return true


func spend_cost(cost: Dictionary) -> void:
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var required_amount: int = int(cost.get(resource_name, 0))
        var current_amount: int = int(resources.get(resource_name, 0))

        resources[resource_name] = current_amount - required_amount


func get_amount(resource_name: String) -> int:
    return int(resources.get(resource_name, 0))


func set_amount(resource_name: String, amount: int) -> void:
    resources[resource_name] = clampi(amount, 0, get_resource_cap(resource_name))


func get_all_resources() -> Dictionary:
    return resources.duplicate(true)


func get_all_storage_bonus_caps() -> Dictionary:
    return storage_bonus_caps.duplicate(true)


func print_inventory(population: int) -> void:
    print("")
    print("Settlement Inventory:")

    var resource_names: Array = resources.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var current_amount: int = int(resources.get(resource_name, 0))
        var max_amount: int = get_resource_cap(resource_name)

        print(resource_name + ": " + str(current_amount) + "/" + str(max_amount))

    print("Population: " + str(population))
    print("")
