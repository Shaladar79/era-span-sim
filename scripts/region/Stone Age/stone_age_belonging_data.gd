extends RefCounted
class_name StoneAgeBelongingData

const BELONGING_TORCH: String = "torch"
const BELONGING_CLOTH_SHOES: String = "cloth_shoes"
const BELONGING_WOVEN_POUCH: String = "woven_pouch"
const BELONGING_WARM_WRAP: String = "warm_wrap"
const BELONGING_BONE_CHARM: String = "bone_charm"

const BELONGING_TYPE_LIGHT: String = "light"
const BELONGING_TYPE_SPEED: String = "speed"
const BELONGING_TYPE_STORAGE: String = "storage"
const BELONGING_TYPE_SURVIVAL: String = "survival"
const BELONGING_TYPE_ROLE: String = "role"


static func get_all_belongings() -> Dictionary:
    return {
        BELONGING_TORCH: {
            "id": BELONGING_TORCH,
            "name": "Torch",
            "type": BELONGING_TYPE_LIGHT,
            "slot_cost": 1,
            "unique": true,
            "source_item_id": BELONGING_TORCH,
            "allowed_roles": [],
            "description": "A carried light source. It gives a small mobile protection/light radius.",
            "effect_notes": "Protection/light radius scale 0.25. No fuel cost."
        },

        BELONGING_CLOTH_SHOES: {
            "id": BELONGING_CLOTH_SHOES,
            "name": "Cloth Shoes",
            "type": BELONGING_TYPE_SPEED,
            "slot_cost": 1,
            "unique": true,
            "source_item_id": BELONGING_CLOTH_SHOES,
            "allowed_roles": [],
            "description": "Simple foot wraps that make movement easier over rough ground.",
            "effect_notes": "+5 Speed while equipped."
        },

        BELONGING_WOVEN_POUCH: {
            "id": BELONGING_WOVEN_POUCH,
            "name": "Woven Pouch",
            "type": BELONGING_TYPE_STORAGE,
            "slot_cost": 1,
            "unique": true,
            "source_item_id": BELONGING_WOVEN_POUCH,
            "allowed_roles": [
                StoneAgeVillagerAssignmentData.ROLE_VILLAGER,
            ],
            "description": "A small woven pouch for carrying gathered materials.",
            "effect_notes": "+1 Gathering for harvest speed. This means gathering is 2% faster."
        },

        BELONGING_WARM_WRAP: {
            "id": BELONGING_WARM_WRAP,
            "name": "Warm Wrap",
            "type": BELONGING_TYPE_SURVIVAL,
            "slot_cost": 1,
            "unique": true,
            "source_item_id": BELONGING_WARM_WRAP,
            "allowed_roles": [],
            "description": "A rough wrap that helps protect a villager from exposure.",
            "effect_notes": "Reduces starvation sickness risk by 5%."
        },

        BELONGING_BONE_CHARM: {
            "id": BELONGING_BONE_CHARM,
            "name": "Bone Charm",
            "type": BELONGING_TYPE_ROLE,
            "slot_cost": 1,
            "unique": true,
            "source_item_id": BELONGING_BONE_CHARM,
            "allowed_roles": [
                StoneAgeVillagerAssignmentData.ROLE_THINKER,
                StoneAgeVillagerAssignmentData.ROLE_RITUALIST
            ],
            "description": "A small charm used as an early symbol of belief, luck, or memory.",
            "effect_notes": "+1 Thinking if equipped by a Thinker. +1 Rituals if equipped by a Ritualist. Rituals bonus is placeholder until ritual systems are active."
        }
    }


static func has_belonging(belonging_id: String) -> bool:
    return get_all_belongings().has(belonging_id)


static func get_belonging(belonging_id: String) -> Dictionary:
    var all_belongings: Dictionary = get_all_belongings()

    if not all_belongings.has(belonging_id):
        return {}

    var belonging_data: Dictionary = all_belongings[belonging_id]

    return belonging_data.duplicate(true)


static func get_belonging_name(belonging_id: String) -> String:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return belonging_id.capitalize()

    return str(belonging_data.get("name", belonging_id.capitalize()))


static func get_belonging_slot_cost(belonging_id: String) -> int:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return 1

    return max(1, int(belonging_data.get("slot_cost", 1)))


static func get_belonging_source_item_id(belonging_id: String) -> String:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return ""

    return str(belonging_data.get("source_item_id", ""))


static func get_allowed_roles(belonging_id: String) -> Array:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return []

    var allowed_roles_variant: Variant = belonging_data.get("allowed_roles", [])

    if typeof(allowed_roles_variant) != TYPE_ARRAY:
        return []

    return allowed_roles_variant.duplicate(true)


static func is_unique_belonging(belonging_id: String) -> bool:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return true

    return bool(belonging_data.get("unique", true))


static func is_role_allowed_for_belonging(
    belonging_id: String,
    role_id: String
) -> bool:
    var allowed_roles: Array = get_allowed_roles(belonging_id)

    if allowed_roles.is_empty():
        return true

    return allowed_roles.has(role_id)


static func get_role_restriction_text(belonging_id: String) -> String:
    var allowed_roles: Array = get_allowed_roles(belonging_id)

    if allowed_roles.is_empty():
        return "Any role"

    var role_names: Array = []

    for role_index in range(allowed_roles.size()):
        var role_id: String = str(allowed_roles[role_index])
        role_names.append(StoneAgeVillagerAssignmentData.get_role_display_name(role_id))

    return ", ".join(role_names)


static func get_belonging_id_for_source_item(item_id: String) -> String:
    if item_id == "":
        return ""

    var all_belongings: Dictionary = get_all_belongings()
    var belonging_ids: Array = all_belongings.keys()

    for belonging_index in range(belonging_ids.size()):
        var belonging_id: String = str(belonging_ids[belonging_index])
        var belonging_data: Dictionary = all_belongings[belonging_id]
        var source_item_id: String = str(belonging_data.get("source_item_id", ""))

        if source_item_id == item_id:
            return belonging_id

    return ""


static func is_source_item_a_belonging(item_id: String) -> bool:
    return get_belonging_id_for_source_item(item_id) != ""


static func get_all_belonging_source_item_ids() -> Array:
    var source_item_ids: Array = []
    var all_belongings: Dictionary = get_all_belongings()
    var belonging_ids: Array = all_belongings.keys()

    for belonging_index in range(belonging_ids.size()):
        var belonging_id: String = str(belonging_ids[belonging_index])
        var source_item_id: String = get_belonging_source_item_id(belonging_id)

        if source_item_id == "":
            continue

        if source_item_ids.has(source_item_id):
            continue

        source_item_ids.append(source_item_id)

    return source_item_ids


static func make_belonging_instance(belonging_id: String) -> Dictionary:
    var belonging_data: Dictionary = get_belonging(belonging_id)

    if belonging_data.is_empty():
        return {}

    return {
        "id": str(belonging_data.get("id", belonging_id)),
        "name": str(belonging_data.get("name", belonging_id.capitalize())),
        "type": str(belonging_data.get("type", "belonging")),
        "slot_cost": max(1, int(belonging_data.get("slot_cost", 1))),
        "source_item_id": str(belonging_data.get("source_item_id", "")),
        "allowed_roles": get_allowed_roles(belonging_id),
        "effect_notes": str(belonging_data.get("effect_notes", "")),
        "description": str(belonging_data.get("description", ""))
    }


static func normalize_belonging_entry(belonging_variant: Variant) -> Dictionary:
    if typeof(belonging_variant) == TYPE_STRING:
        return make_belonging_instance(str(belonging_variant))

    if typeof(belonging_variant) != TYPE_DICTIONARY:
        return {}

    var raw_belonging: Dictionary = belonging_variant
    var belonging_id: String = str(raw_belonging.get("id", raw_belonging.get("item_id", "")))

    if belonging_id == "":
        return {}

    var normalized_belonging: Dictionary = make_belonging_instance(belonging_id)

    if normalized_belonging.is_empty():
        normalized_belonging = {
            "id": belonging_id,
            "name": str(raw_belonging.get("name", belonging_id.capitalize())),
            "type": str(raw_belonging.get("type", "belonging")),
            "slot_cost": max(1, int(raw_belonging.get("slot_cost", 1))),
            "source_item_id": str(raw_belonging.get("source_item_id", "")),
            "allowed_roles": [],
            "effect_notes": str(raw_belonging.get("effect_notes", "")),
            "description": str(raw_belonging.get("description", ""))
        }

    return normalized_belonging


static func get_belonging_names_text(belongings: Array) -> String:
    if belongings.is_empty():
        return "None"

    var name_parts: Array = []

    for belonging_index in range(belongings.size()):
        var belonging_data: Dictionary = normalize_belonging_entry(belongings[belonging_index])

        if belonging_data.is_empty():
            continue

        var belonging_name: String = str(belonging_data.get("name", ""))

        if belonging_name == "":
            belonging_name = str(belonging_data.get("id", "Belonging")).capitalize()

        name_parts.append(belonging_name)

    if name_parts.is_empty():
        return "None"

    return ", ".join(name_parts)
