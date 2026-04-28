extends RefCounted
class_name RegionBuildingData

const AGE_STONE: String = "stone_age"

const CATEGORY_CORE: String = "core"
const CATEGORY_RESIDENCE: String = "residence"
const CATEGORY_LEADERSHIP: String = "leadership"
const CATEGORY_CRAFTING: String = "crafting"
const CATEGORY_STORAGE: String = "storage"
const CATEGORY_RESEARCH: String = "research"

const BUILDING_CAMPFIRE: String = "campfire"

const BUILDINGS: Dictionary = {
    BUILDING_CAMPFIRE: {
        "id": BUILDING_CAMPFIRE,
        "name": "Campfire",
        "description": "A basic fire used for warmth, cooking, and gathering.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_CORE,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 4,
            "Stone": 2
        },
        "movable": false,
        "unlocked": true
    }
}


static func get_building(building_id: String) -> Dictionary:
    if not BUILDINGS.has(building_id):
        return {}

    var building_data: Dictionary = BUILDINGS[building_id]
    return building_data.duplicate(true)


static func get_all_buildings() -> Array:
    var building_list: Array = []
    var building_ids: Array = BUILDINGS.keys()
    building_ids.sort()

    for building_index in range(building_ids.size()):
        var building_id_variant: Variant = building_ids[building_index]
        var building_id: String = str(building_id_variant)

        building_list.append(get_building(building_id))

    return building_list


static func get_unlocked_buildings() -> Array:
    var unlocked_buildings: Array = []
    var all_buildings: Array = get_all_buildings()

    for building_index in range(all_buildings.size()):
        var building_variant: Variant = all_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant

        if bool(building_data.get("unlocked", false)):
            unlocked_buildings.append(building_data)

    return unlocked_buildings


static func get_building_cost(building_id: String) -> Dictionary:
    var building_data: Dictionary = get_building(building_id)

    if building_data.is_empty():
        return {}

    var cost: Dictionary = building_data.get("cost", {})
    return cost.duplicate(true)


static func get_building_width(building_id: String) -> int:
    var building_data: Dictionary = get_building(building_id)

    return int(building_data.get("width", 1))


static func get_building_height(building_id: String) -> int:
    var building_data: Dictionary = get_building(building_id)

    return int(building_data.get("height", 1))


static func is_building_unlocked(building_id: String) -> bool:
    var building_data: Dictionary = get_building(building_id)

    return bool(building_data.get("unlocked", false))
