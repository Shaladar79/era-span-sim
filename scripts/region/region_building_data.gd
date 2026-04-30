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

const BUILDING_HUNTERS_HUT: String = "hunters_hut"
const BUILDING_WARLEADER_SHELTER: String = "warleader_shelter"
const BUILDING_WARRIOR_HUT: String = "warrior_hut"

const CAMPFIRE_BUILD_RADIUS: int = 6

const STORAGE_BASE_RESOURCE_CAP: int = 20
const STORAGE_AREA_CAPACITY: int = 50

const SHELTER_CAPACITY: int = 2

const CHIEFTAINS_SHELTER_REQUIRED_SHELTERS: int = 3
const CHIEFTAINS_SHELTER_CAPACITY: int = 0

const THINKERS_SPOT_RESEARCH_PER_MINUTE: int = 1

const SPECIALIST_HUT_CAPACITY: int = 1
const WARLEADER_SHELTER_CAPACITY: int = 0

static var runtime_unlocked_buildings: Dictionary = {}


static func reset_runtime_unlocks() -> void:
    runtime_unlocked_buildings = {
        BUILDING_CAMPFIRE: true
    }


static func unlock_building(building_id: String) -> void:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    if building_id == "":
        return

    runtime_unlocked_buildings[building_id] = true


static func unlock_buildings(building_ids: Array) -> void:
    for building_index in range(building_ids.size()):
        unlock_building(str(building_ids[building_index]))


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
            "item_cost": {},
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
            "item_cost": {},
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
            "item_cost": {},
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
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A crude work area where simple tools and early crafted objects can be made. It allows early research plans to become available when enough Research is stored."
        },

        BUILDING_STONEWORKING_BENCH: {
            "id": BUILDING_STONEWORKING_BENCH,
            "name": "Stoneworking Hut",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Stone": 6,
                "Wood": 2
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "crafting_skill": "stoneworking",
            "specialist_role": "stoneworker",
            "specialist_housing_capacity": SPECIALIST_HUT_CAPACITY,
            "assigned_villagers": [],
            "description": "A dedicated Stone Age work hut for shaping stone, flint, crude blades, and early tool heads. Later, an assigned villager will become a Stoneworker and use this hut as specialist shelter."
        },

        BUILDING_WOODWORKING_BENCH: {
            "id": BUILDING_WOODWORKING_BENCH,
            "name": "Woodworking Hut",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 8,
                "Stone": 1
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "crafting_skill": "woodworking",
            "specialist_role": "woodworker",
            "specialist_housing_capacity": SPECIALIST_HUT_CAPACITY,
            "assigned_villagers": [],
            "description": "A dedicated Stone Age work hut for shaping branches, poles, handles, frames, and later moving-camp parts. Later, an assigned villager will become a Woodworker and use this hut as specialist shelter."
        },

        BUILDING_HUNTERS_HUT: {
            "id": BUILDING_HUNTERS_HUT,
            "name": "Hunter's Hut",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 10,
                "Fiber": 4,
                "Stone": 2
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "specialist_role": "hunter",
            "specialist_housing_capacity": SPECIALIST_HUT_CAPACITY,
            "assigned_villagers": [],
            "description": "A dedicated Stone Age hut for future hunters. For now, it unlocks and builds as a placeholder. Later, an assigned villager will become a Hunter and use this hut as specialist shelter."
        },

        BUILDING_WARLEADER_SHELTER: {
            "id": BUILDING_WARLEADER_SHELTER,
            "name": "Warleader Shelter",
            "age": AGE_STONE,
            "width": 2,
            "height": 2,
            "cost": {
                "Wood": 14,
                "Fiber": 4,
                "Stone": 4
            },
            "item_cost": {},
            "movable": true,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": WARLEADER_SHELTER_CAPACITY,
            "houses_warleader": true,
            "grants_generic_warleader": true,
            "description": "A larger shelter used by a future Warleader. It introduces the hunting and combat leadership branch, but the Warleader system will be built later."
        },

        BUILDING_WARRIOR_HUT: {
            "id": BUILDING_WARRIOR_HUT,
            "name": "Warrior Hut",
            "age": AGE_STONE,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 8,
                "Stone": 6,
                "Fiber": 2
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "specialist_role": "warrior",
            "specialist_housing_capacity": SPECIALIST_HUT_CAPACITY,
            "assigned_villagers": [],
            "description": "A dedicated Stone Age hut for future warriors. For now, it unlocks and builds as a placeholder. Later, an assigned villager will become a Warrior and use this hut as specialist shelter."
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
            "item_cost": {},
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
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "research_per_minute": THINKERS_SPOT_RESEARCH_PER_MINUTE,
            "description": "A simple place for early planning, observation, and shared ideas. It generates 1 Research per minute. Research can be spent to learn item crafting plans, tools, huts, and later Stone Age systems."
        }
    }
