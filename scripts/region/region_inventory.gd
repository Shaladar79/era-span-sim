extends RefCounted
class_name RegionInventory

var resources: Dictionary = {}


func reset() -> void:
    resources = {
        "Wood": 0,
        "Stone": 0,
        "Fiber": 0,
        "Flint": 0
    }


func add_resources(harvested_resources: Dictionary) -> void:
    var resource_names: Array = harvested_resources.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var harvested_amount: int = int(harvested_resources.get(resource_name, 0))
        var current_amount: int = int(resources.get(resource_name, 0))

        resources[resource_name] = current_amount + harvested_amount


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
    resources[resource_name] = amount


func get_all_resources() -> Dictionary:
    return resources.duplicate(true)


func print_inventory(population: int) -> void:
    print("")
    print("Settlement Inventory:")

    var resource_names: Array = resources.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        print(resource_name + ": " + str(int(resources.get(resource_name, 0))))

    print("Population: " + str(population))
    print("")
