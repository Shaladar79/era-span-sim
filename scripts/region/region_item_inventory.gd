extends RefCounted
class_name RegionItemInventory

const CATEGORY_TOOL: String = "Tool"
const CATEGORY_WEAPON: String = "Weapon"
const CATEGORY_MEDICINE: String = "Medicine"
const CATEGORY_KIT: String = "Kit"
const CATEGORY_MATERIAL: String = "Material"
const CATEGORY_MISC: String = "Misc"
const CATEGORY_ARMOR: String = "Armor"

const SAVE_KEY_ITEMS: String = "items"

var items: Dictionary = {}


func reset() -> void:
    items.clear()


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_ITEMS: items.duplicate(true)
    }


func load_save_data(save_data: Dictionary) -> void:
    reset()

    if save_data.is_empty():
        return

    var saved_items_variant: Variant = save_data.get(SAVE_KEY_ITEMS, {})

    if typeof(saved_items_variant) != TYPE_DICTIONARY:
        return

    var saved_items: Dictionary = saved_items_variant
    var item_ids: Array = saved_items.keys()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var item_variant: Variant = saved_items.get(item_id, {})

        if item_id == "":
            continue

        if typeof(item_variant) != TYPE_DICTIONARY:
            continue

        var item_data: Dictionary = item_variant.duplicate(true)
        var amount: int = int(item_data.get("amount", 0))

        if amount <= 0:
            continue

        item_data["id"] = str(item_data.get("id", item_id))

        if str(item_data.get("id", "")) == "":
            item_data["id"] = item_id

        item_data["name"] = str(item_data.get("name", item_id))
        item_data["amount"] = amount
        item_data["category"] = str(item_data.get("category", CATEGORY_MISC))
        item_data["description"] = str(item_data.get("description", ""))

        items[item_id] = item_data


func add_item(
    item_id: String,
    item_name: String,
    amount: int = 1,
    category: String = CATEGORY_MISC,
    description: String = "",
    metadata: Dictionary = {}
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

    for metadata_key in metadata.keys():
        var key_string: String = str(metadata_key)

        if key_string == "":
            continue

        if key_string == "id":
            continue

        if key_string == "name":
            continue

        if key_string == "amount":
            continue

        if key_string == "category":
            continue

        if key_string == "description":
            continue

        item_data[key_string] = metadata.get(metadata_key)

    items[item_id] = item_data


func add_item_from_output(output_data: Dictionary) -> void:
    var output_type: String = str(output_data.get("type", ""))

    if output_type != RegionRecipeData.OUTPUT_TYPE_ITEM:
        return

    var item_id: String = str(output_data.get("id", ""))
    var item_name: String = str(output_data.get("name", item_id))
    var amount: int = int(output_data.get("amount", 1))
    var category: String = str(output_data.get("category", CATEGORY_MISC))
    var description: String = str(output_data.get("description", ""))

    var metadata: Dictionary = output_data.duplicate(true)

    add_item(
        item_id,
        item_name,
        amount,
        category,
        description,
        metadata
    )


func add_items_from_outputs(outputs: Array) -> void:
    for output_index in range(outputs.size()):
        var output_variant: Variant = outputs[output_index]

        if typeof(output_variant) != TYPE_DICTIONARY:
            continue

        var output_data: Dictionary = output_variant

        add_item_from_output(output_data)


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


func is_item_belonging_source(item_id: String) -> bool:
    if item_id == "":
        return false

    return StoneAgeBelongingData.is_source_item_a_belonging(item_id)


func get_belonging_id_for_item(item_id: String) -> String:
    if item_id == "":
        return ""

    return StoneAgeBelongingData.get_belonging_id_for_source_item(item_id)


func get_visible_belonging_items() -> Array:
    var belonging_items: Array = []
    var visible_items: Array = get_visible_items()

    for item_index in range(visible_items.size()):
        var item_data: Dictionary = visible_items[item_index]
        var item_id: String = str(item_data.get("id", ""))

        if item_id == "":
            continue

        var belonging_id: String = get_belonging_id_for_item(item_id)

        if belonging_id == "":
            continue

        var belonging_data: Dictionary = StoneAgeBelongingData.get_belonging(belonging_id)

        if belonging_data.is_empty():
            continue

        var display_item: Dictionary = item_data.duplicate(true)
        display_item["belonging_id"] = belonging_id
        display_item["belonging_name"] = StoneAgeBelongingData.get_belonging_name(belonging_id)
        display_item["slot_cost"] = StoneAgeBelongingData.get_belonging_slot_cost(belonging_id)
        display_item["allowed_roles_text"] = StoneAgeBelongingData.get_role_restriction_text(belonging_id)
        display_item["effect_notes"] = str(belonging_data.get("effect_notes", ""))

        belonging_items.append(display_item)

    belonging_items.sort_custom(_sort_belonging_items_by_name)

    return belonging_items


func get_available_belonging_items_for_villager(villager_data: Dictionary) -> Array:
    var available_items: Array = []

    if villager_data.is_empty():
        return available_items

    var villager_role: String = str(
        villager_data.get(
            "role",
            StoneAgeVillagerAssignmentData.get_default_role()
        )
    )

    var max_belongings: int = int(villager_data.get("max_belongings", CoreTuning.BASE_BELONGING_SLOTS))
    var open_slots: int = max_belongings

    if villager_data.has("belongings"):
        var belongings: Array = villager_data.get("belongings", [])

        for belonging_index in range(belongings.size()):
            var belonging_entry: Dictionary = StoneAgeBelongingData.normalize_belonging_entry(
                belongings[belonging_index]
            )

            if belonging_entry.is_empty():
                continue

            open_slots -= max(1, int(belonging_entry.get("slot_cost", 1)))

    open_slots = max(0, open_slots)

    if open_slots <= 0:
        return available_items

    var current_belonging_ids: Array = []
    var current_belongings: Array = villager_data.get("belongings", [])

    for current_index in range(current_belongings.size()):
        var current_belonging: Dictionary = StoneAgeBelongingData.normalize_belonging_entry(
            current_belongings[current_index]
        )

        if current_belonging.is_empty():
            continue

        var current_belonging_id: String = str(current_belonging.get("id", ""))

        if current_belonging_id == "":
            continue

        current_belonging_ids.append(current_belonging_id)

    var belonging_items: Array = get_visible_belonging_items()

    for item_index in range(belonging_items.size()):
        var item_data: Dictionary = belonging_items[item_index]
        var belonging_id: String = str(item_data.get("belonging_id", ""))

        if belonging_id == "":
            continue

        var slot_cost: int = StoneAgeBelongingData.get_belonging_slot_cost(belonging_id)

        if slot_cost > open_slots:
            continue

        if StoneAgeBelongingData.is_unique_belonging(belonging_id):
            if current_belonging_ids.has(belonging_id):
                continue

        if not StoneAgeBelongingData.is_role_allowed_for_belonging(
            belonging_id,
            villager_role
        ):
            continue

        available_items.append(item_data)

    return available_items


func get_item_function(item_id: String) -> String:
    var item_data: Dictionary = get_item(item_id)

    if item_data.is_empty():
        return ""

    return str(item_data.get("item_function", ""))


func get_item_role_tags(item_id: String) -> Array:
    var item_data: Dictionary = get_item(item_id)

    if item_data.is_empty():
        return []

    var role_tags: Variant = item_data.get("role_tags", [])

    if typeof(role_tags) != TYPE_ARRAY:
        return []

    return role_tags.duplicate(true)


func get_item_skill_tags(item_id: String) -> Array:
    var item_data: Dictionary = get_item(item_id)

    if item_data.is_empty():
        return []

    var skill_tags: Variant = item_data.get("skill_tags", [])

    if typeof(skill_tags) != TYPE_ARRAY:
        return []

    return skill_tags.duplicate(true)


func get_item_effect_notes(item_id: String) -> String:
    var item_data: Dictionary = get_item(item_id)

    if item_data.is_empty():
        return ""

    return str(item_data.get("effect_notes", ""))

func get_visible_tool_items() -> Array:
    var tool_items: Array = []
    var visible_items: Array = get_visible_items()

    for item_index in range(visible_items.size()):
        var item_data: Dictionary = visible_items[item_index]
        var item_id: String = str(item_data.get("id", ""))

        if item_id == "":
            continue

        var category: String = str(item_data.get("category", CATEGORY_MISC))
        var item_function: String = str(item_data.get("item_function", ""))

        if category != CATEGORY_TOOL:
            if item_function != StoneAgeTuning.ITEM_FUNCTION_BASIC_TOOL:
                if item_function != StoneAgeTuning.ITEM_FUNCTION_TOOL_BONUS:
                    if item_function != StoneAgeTuning.ITEM_FUNCTION_PREPARATION_TOOL:
                        continue

        var display_item: Dictionary = item_data.duplicate(true)
        display_item["slot_cost"] = max(1, int(display_item.get("slot_cost", 1)))
        display_item["effect_notes"] = str(display_item.get("effect_notes", ""))

        tool_items.append(display_item)

    tool_items.sort_custom(_sort_items_by_category_then_name)

    return tool_items


func get_available_tool_items_for_villager(villager_data: Dictionary) -> Array:
    var available_items: Array = []

    if villager_data.is_empty():
        return available_items

    var open_tool_slots: int = int(villager_data.get("tool_slots", 0))
    var equipped_tools: Array = villager_data.get("tools", [])

    for equipped_index in range(equipped_tools.size()):
        var equipped_tool_variant: Variant = equipped_tools[equipped_index]

        if typeof(equipped_tool_variant) != TYPE_DICTIONARY:
            continue

        var equipped_tool: Dictionary = equipped_tool_variant
        open_tool_slots -= max(1, int(equipped_tool.get("slot_cost", 1)))

    open_tool_slots = max(0, open_tool_slots)

    if open_tool_slots <= 0:
        return available_items

    var villager_role: String = str(
        villager_data.get(
            "role",
            StoneAgeVillagerAssignmentData.get_default_role()
        )
    )

    var role_skills: Array = []

    if villager_role == StoneAgeVillagerAssignmentData.ROLE_GATHERER:
        role_skills = [VillagerManager.SKILL_GATHERING]
    elif villager_role == StoneAgeVillagerAssignmentData.ROLE_CRAFTER:
        role_skills = [VillagerManager.SKILL_CRAFTING]
    elif villager_role == StoneAgeVillagerAssignmentData.ROLE_THINKER:
        role_skills = [VillagerManager.SKILL_THINKING]
    elif villager_role == StoneAgeVillagerAssignmentData.ROLE_FISHER:
        role_skills = [VillagerManager.SKILL_FISHING]
    elif villager_role == StoneAgeVillagerAssignmentData.ROLE_HUNTER:
        role_skills = [
            VillagerManager.SKILL_HUNTING,
            VillagerManager.SKILL_RANGED_WEAPONS,
            VillagerManager.SKILL_EVADE
        ]
    elif villager_role == StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
        role_skills = [
            VillagerManager.SKILL_MELEE_WEAPONS,
            VillagerManager.SKILL_PARRY
        ]

    var current_tool_ids: Array = []

    for current_index in range(equipped_tools.size()):
        var current_tool_variant: Variant = equipped_tools[current_index]

        if typeof(current_tool_variant) != TYPE_DICTIONARY:
            continue

        var current_tool: Dictionary = current_tool_variant
        var current_tool_id: String = str(current_tool.get("id", ""))

        if current_tool_id != "":
            current_tool_ids.append(current_tool_id)

    var tool_items: Array = get_visible_tool_items()

    for item_index in range(tool_items.size()):
        var item_data: Dictionary = tool_items[item_index]
        var item_id: String = str(item_data.get("id", ""))

        if item_id == "":
            continue

        if current_tool_ids.has(item_id):
            continue

        var slot_cost: int = max(1, int(item_data.get("slot_cost", 1)))

        if slot_cost > open_tool_slots:
            continue

        var role_tags: Array = get_item_role_tags(item_id)

        if not role_tags.is_empty():
            if not role_tags.has(villager_role):
                continue

        var skill_tags: Array = get_item_skill_tags(item_id)

        if not skill_tags.is_empty():
            var matches_role_skill: bool = false

            for skill_index in range(role_skills.size()):
                if skill_tags.has(role_skills[skill_index]):
                    matches_role_skill = true
                    break

            if not matches_role_skill:
                continue

        available_items.append(item_data)

    return available_items

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
        var item_function: String = str(item_data.get("item_function", ""))

        var print_text: String = "- [" + category + "] " + item_name + ": " + str(amount)

        if item_function != "":
            print_text += " (" + item_function + ")"

        print(print_text)

    print("")


func _sort_items_by_category_then_name(a: Dictionary, b: Dictionary) -> bool:
    var category_a: String = str(a.get("category", CATEGORY_MISC))
    var category_b: String = str(b.get("category", CATEGORY_MISC))

    if category_a != category_b:
        return category_a < category_b

    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b


func _sort_belonging_items_by_name(a: Dictionary, b: Dictionary) -> bool:
    var name_a: String = str(a.get("belonging_name", a.get("name", "")))
    var name_b: String = str(b.get("belonging_name", b.get("name", "")))

    return name_a < name_b
