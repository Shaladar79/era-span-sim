extends RefCounted
class_name RegionBuildingData

const AGE_STONE: String = "stone_age"

const BUILDING_CAMPFIRE: String = "campfire"
const BUILDING_SHELTER: String = "shelter"
const BUILDING_CHIEFTAINS_SHELTER: String = "chieftains_shelter"
const BUILDING_MAKING_SPOT: String = "making_spot"
const BUILDING_STONEWORKING_BENCH: String = "stoneworking_bench"
const BUILDING_WOODWORKING_BENCH: String = "woodworking_bench"
const BUILDING_STORAGE_AREA: String = "storage_area"
const BUILDING_THINKERS_SPOT: String = "thinkers_spot"

const CAMPFIRE_BUILD_RADIUS: int = 6

const STORAGE_BASE_RESOURCE_CAP: int = 20
const STORAGE_AREA_CAPACITY: int = 50

const SHELTER_CAPACITY: int = 2

const CHIEFTAINS_SHELTER_REQUIRED_SHELTERS: int = 3
const CHIEFTAINS_SHELTER_CAPACITY: int = 0

const THINKERS_SPOT_RESEARCH_PER_MINUTE: int = 1

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
        runtime_unlocked_buildings[BUILDING_STORAGE_AREA] = true

    if building_id == BUILDING_CHIEFTAINS_SHELTER:
        runtime_unlocked_buildings[BUILDING_MAKING_SPOT] = true
        runtime_unlocked_buildings[BUILDING_THINKERS_SPOT] = true

    if building_id == BUILDING_MAKING_SPOT:
        runtime_unlocked_buildings[BUILDING_STONEWORKING_BENCH] = true
        runtime_unlocked_buildings[BUILDING_WOODWORKING_BENCH] = true


static func notify_shelter_count_changed(shelter_count: int) -> void:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    if shelter_count >= CHIEFTAINS_SHELTER_REQUIRED_SHELTERS:
        runtime_unlocked_buildings[BUILDING_CHIEFTAINS_SHELTER] = true


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


static func get_storage_resource_options() -> Array:
    return [
        "Wood",
        "Stone",
        "Fiber",
        "Flint",
        "Berries",
        "Mushrooms",
        "Reeds",
        "Clay",
        "Fish"
    ]


static func get_all_buildings() -> Dictionary:
    return {
        BUILDING_CAMPFIRE: {
            "id": BUILDING_CAMPFIRE,
            "name": "Campfire",
            "age": AGE_STONE,
            "width": 1,
            "height": 1,
            "cost": {
                "Stone": 2,
                "Wood": 4
            },
            "movable": false,
            "requires_campfire_range": false,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "The center of a Stone Age camp. It gives warmth, comfort, and security, keeping wild animals away. Building a Campfire unlocks Shelter and Storage Area construction nearby."
        },

        BUILDING_SHELTER: {
            "id": BUILDING_SHELTER,
            "name": "Shelter",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 6,
                "Fiber": 2
            },
            "movable": true,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": SHELTER_CAPACITY,
            "description": "A basic temporary dwelling. It shelters 2 normal villagers. It must be built within range of a Campfire. Building 3 Shelters unlocks the Chieftain's Shelter."
        },

        BUILDING_CHIEFTAINS_SHELTER: {
            "id": BUILDING_CHIEFTAINS_SHELTER,
            "name": "Chieftain's Shelter",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Wood": 12,
                "Fiber": 4,
                "Stone": 2
            },
            "movable": true,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": CHIEFTAINS_SHELTER_CAPACITY,
            "houses_chieftain": true,
            "grants_generic_chieftain": true,
            "description": "A larger, more respected shelter used by the village leader. It unlocks after 3 Shelters are built. Building it grants a generic Chieftain for now and unlocks the Making Spot and Thinker's Spot. It houses the Chieftain only."
        },

        BUILDING_MAKING_SPOT: {
            "id": BUILDING_MAKING_SPOT,
            "name": "Making Spot",
            "age": AGE_STONE,
            "width": 1,
            "height": 1,
            "cost": {
                "Stone": 2,
                "Wood": 2
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A crude work area where simple tools and early crafted objects can be made. Building it unlocks the Stoneworking Bench and Woodworking Bench."
        },

        BUILDING_STONEWORKING_BENCH: {
            "id": BUILDING_STONEWORKING_BENCH,
            "name": "Stoneworking Bench",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Stone": 6,
                "Wood": 2
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "crafting_skill": "stoneworking",
            "description": "A crude Stone Age bench for shaping stone, flint, and early tool heads. It must be built within range of a Campfire."
        },

        BUILDING_WOODWORKING_BENCH: {
            "id": BUILDING_WOODWORKING_BENCH,
            "name": "Woodworking Bench",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 8,
                "Stone": 1
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "crafting_skill": "woodworking",
            "description": "A crude Stone Age bench for shaping branches, poles, handles, frames, and drag sled parts. It must be built within range of a Campfire."
        },

        BUILDING_STORAGE_AREA: {
            "id": BUILDING_STORAGE_AREA,
            "name": "Storage Area",
            "age": AGE_STONE,
            "width": 1,
            "height": 1,
            "cost": {
                "Wood": 5
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "storage_capacity": STORAGE_AREA_CAPACITY,
            "storage_resource": "",
            "description": "A cleared storage area for one selected resource type. Each Storage Area increases that resource's cap by 50. It must be built within range of a Campfire."
        },

        BUILDING_THINKERS_SPOT: {
            "id": BUILDING_THINKERS_SPOT,
            "name": "Thinker's Spot",
            "age": AGE_STONE,
            "width": 1,
            "height": 1,
            "cost": {
                "Stone": 3,
                "Wood": 1
            },
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "research_per_minute": THINKERS_SPOT_RESEARCH_PER_MINUTE,
            "description": "A simple place for early planning, observation, and shared ideas. It generates 1 Research per minute. Research will later be spent to learn item crafting plans, weapons, drag sleds, and more advanced Stone Age buildings."
        }
    }
