extends RefCounted
class_name RegionItemInventory

const CATEGORY_TOOL: String = "Tool"
const CATEGORY_WEAPON: String = "Weapon"
const CATEGORY_MEDICINE: String = "Medicine"
const CATEGORY_KIT: String = "Kit"
const CATEGORY_MATERIAL: String = "Material"
const CATEGORY_MISC: String = "Misc"

var items: Dictionary = {}


func reset() -> void:
    items.clear()


func add_item(
    item_id: String,
    item_name: String,
    amount: int = 1,
    category: String = CATEGORY_MISC,
    description: String = ""
) -> void:
    if item_id == "":
        return

    if amount <= 0:
        return

    if not items.has(item_id):
        items[item_id] = {
            "id": item_id,
            "name": item_name,
            "amount": 0,
            "category": category,
            "description": description
        }

    var item_data: Dictionary = items[item_id]
    item_data["amount"] = int(item_data.get("amount", 0)) + amount
    item_data["name"] = item_name
    item_data["category"] = category
    item_data["description"] = description

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
        var category: String = str(output_data.get("category", CATEGORY_MISC))
        var description: String = str(output_data.get("description", ""))

        add_item(
            item_id,
            item_name,
            amount,
            category,
            description
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

    visible_items.sort_custom(_sort_items_by_category_then_name)

    return visible_items


func get_visible_items_by_category(category: String) -> Array:
    var matching_items: Array = []
    var visible_items: Array = get_visible_items()

    for item_index in range(visible_items.size()):
        var item_data: Dictionary = visible_items[item_index]
        var item_category: String = str(item_data.get("category", CATEGORY_MISC))

        if item_category != category:
            continue

        matching_items.append(item_data)

    return matching_items


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
        var category: String = str(item_data.get("category", CATEGORY_MISC))
        var amount: int = int(item_data.get("amount", 0))

        print("- [" + category + "] " + item_name + ": " + str(amount))

    print("")


func _sort_items_by_category_then_name(a: Dictionary, b: Dictionary) -> bool:
    var category_a: String = str(a.get("category", CATEGORY_MISC))
    var category_b: String = str(b.get("category", CATEGORY_MISC))

    if category_a != category_b:
        return category_a < category_b

    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b
