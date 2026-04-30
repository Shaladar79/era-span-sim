extends RefCounted
class_name RegionItemInventory

var items: Dictionary = {}


func reset() -> void:
    items.clear()


func add_item(
    item_id: String,
    item_name: String,
    amount: int = 1
) -> void:
    if item_id == "":
        return

    if amount <= 0:
        return

    if not items.has(item_id):
        items[item_id] = {
            "id": item_id,
            "name": item_name,
            "amount": 0
        }

    var item_data: Dictionary = items[item_id]
    item_data["amount"] = int(item_data.get("amount", 0)) + amount
    items[item_id] = item_data


func add_items_from_outputs(outputs: Array) -> void:
    for output_index in range(outputs.size()):
        var output_variant: Variant = outputs[output_index]

        if typeof(output_variant) != TYPE_DICTIONARY:
            continue

        var output_data: Dictionary = output_variant
        var output_type: String = str(output_data.get("type", ""))

        if output_type != RegionRecipeData.OUTPUT_TYPE_ITEM:
            continue

        var item_id: String = str(output_data.get("id", ""))
        var item_name: String = str(output_data.get("name", item_id))
        var amount: int = int(output_data.get("amount", 1))

        add_item(
            item_id,
            item_name,
            amount
        )


func remove_item(
    item_id: String,
    amount: int = 1
) -> bool:
    if item_id == "":
        return false

    if amount <= 0:
        return true

    if not items.has(item_id):
        return false

    var item_data: Dictionary = items[item_id]
    var current_amount: int = int(item_data.get("amount", 0))

    if current_amount < amount:
        return false

    current_amount -= amount

    if current_amount <= 0:
        items.erase(item_id)
    else:
        item_data["amount"] = current_amount
        items[item_id] = item_data

    return true


func get_amount(item_id: String) -> int:
    if not items.has(item_id):
        return 0

    var item_data: Dictionary = items[item_id]

    return int(item_data.get("amount", 0))


func has_item(
    item_id: String,
    amount: int = 1
) -> bool:
    return get_amount(item_id) >= amount


func get_item(item_id: String) -> Dictionary:
    if not items.has(item_id):
        return {}

    var item_data: Dictionary = items[item_id]

    return item_data.duplicate(true)


func get_all_items() -> Dictionary:
    return items.duplicate(true)


func get_visible_items() -> Array:
    var visible_items: Array = []
    var item_ids: Array = items.keys()

    item_ids.sort()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var item_data: Dictionary = get_item(item_id)

        if item_data.is_empty():
            continue

        var amount: int = int(item_data.get("amount", 0))

        if amount <= 0:
            continue

        visible_items.append(item_data)

    return visible_items


func print_inventory() -> void:
    print("")
    print("Village Item Inventory:")

    var visible_items: Array = get_visible_items()

    if visible_items.is_empty():
        print("- None")
        print("")
        return

    for item_index in range(visible_items.size()):
        var item_data: Dictionary = visible_items[item_index]
        var item_name: String = str(item_data.get("name", "Unknown Item"))
        var amount: int = int(item_data.get("amount", 0))

        print("- " + item_name + ": " + str(amount))

    print("")
