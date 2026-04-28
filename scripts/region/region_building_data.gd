extends RefCounted
class_name RegionBuildingData

const AGE_STONE: String = "stone_age"

const BUILDING_CAMPFIRE: String = "campfire"
const BUILDING_SHELTER: String = "shelter"
const BUILDING_MAKING_SPOT: String = "making_spot"
const BUILDING_STORAGE_AREA: String = "storage_area"
const BUILDING_THINKERS_SPOT: String = "thinkers_spot"

const CAMPFIRE_BUILD_RADIUS: int = 6

static var runtime_unlocked_buildings: Dictionary = {}


static func reset_runtime_unlocks() -> void:
    runtime_unlocked_buildings = {
        BUILDING_CAMPFIRE: true
    }


static func notify_building_built(building_id: String) -> void:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    if building_id == BUILDING_CAMPFIRE:
        runtime_unlocked_buildings[BUILDING_SHELTER] = true


static func is_building_unlocked(building_id: String) -> bool:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    return bool(runtime_unlocked_buildings.get(building_id, false))


static func get_building(building_id: String) -> Dictionary:
    var buildings: Dictionary = get_all_buildings()

    if not buildings.has(building_id):
        return {}

    var building_data: Dictionary = buildings[building_id].duplicate(true)
    building_data["unlocked"] = is_building_unlocked(building_id)

    return building_data


static func get_unlocked_buildings() -> Array:
    var unlocked_buildings: Array = []
    var buildings: Dictionary = get_all_buildings()
    var building_ids: Array = buildings.keys()

    for building_index in range(building_ids.size()):
        var building_id_variant: Variant = building_ids[building_index]
        var building_id: String = str(building_id_variant)

        if not is_building_unlocked(building_id):
            continue

        var building_data: Dictionary = get_building(building_id)

        if building_data.is_empty():
            continue

        unlocked_buildings.append(building_data)

    return unlocked_buildings


static func get_all_buildings() -> Dictionary:
    return {
        BUILDING_CAMPFIRE: {
            "id": BUILDING_CAMPFIRE,
            "name": "Campfire",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Stone": 2,
                "Wood": 4
            },
            "movable": false,
            "requires_campfire_range": false,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "The center of a Stone Age camp. It gives warmth, comfort, and security, keeping wild animals away. Building a Campfire unlocks Shelter construction nearby."
        },

        BUILDING_SHELTER: {
            "id": BUILDING_SHELTER,
            "name": "Shelter",
            "age": AGE_STONE,
            "width": 3,
            "height": 2,
            "cost": {
                "Wood": 6,
                "Fiber": 2
            },
            "movable": true,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A basic temporary dwelling. It must be built within range of a Campfire."
        },

        BUILDING_MAKING_SPOT: {
            "id": BUILDING_MAKING_SPOT,
            "name": "Making Spot",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Stone": 2,
                "Wood": 2
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A crude work area where simple tools and early crafted objects can be made. It must be built within range of a Campfire."
        },

        BUILDING_STORAGE_AREA: {
            "id": BUILDING_STORAGE_AREA,
            "name": "Storage Area",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Wood": 2,
                "Stone": 1
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A cleared storage area for keeping gathered supplies organized. It must be built within range of a Campfire."
        },

        BUILDING_THINKERS_SPOT: {
            "id": BUILDING_THINKERS_SPOT,
            "name": "Thinker's Spot",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Stone": 3,
                "Wood": 1
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A simple place for early planning, observation, and shared ideas. It must be built within range of a Campfire."
        }
    }
