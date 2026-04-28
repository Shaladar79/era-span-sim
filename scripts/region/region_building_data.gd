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
const BUILDING_SHELTER: String = "shelter"
const BUILDING_TENT: String = "tent"
const BUILDING_STURDY_SHELTER: String = "sturdy_shelter"
const BUILDING_FURRED_TENT: String = "furred_tent"

const BUILDING_MAKING_SPOT: String = "making_spot"
const BUILDING_STONE_WORKING_SPOT: String = "stone_working_spot"
const BUILDING_STONE_WORKING_BENCH: String = "stone_working_bench"
const BUILDING_WOOD_WORKING_SPOT: String = "wood_working_spot"
const BUILDING_WOOD_WORKING_BENCH: String = "wood_working_bench"

const BUILDING_HOLE_IN_GROUND: String = "hole_in_ground"
const BUILDING_CRUDE_CONTAINER: String = "crude_container"

const BUILDING_THINKERS_SPOT: String = "thinkers_spot"
const BUILDING_THINKERS_ROCK: String = "thinkers_rock"


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
    },

    BUILDING_SHELTER: {
        "id": BUILDING_SHELTER,
        "name": "Shelter",
        "description": "A crude lean-to or brush shelter that gives basic protection from weather.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_RESIDENCE,
        "width": 3,
        "height": 2,
        "cost": {
            "Wood": 8,
            "Fiber": 4
        },
        "movable": false,
        "unlocked": true
    },

    BUILDING_TENT: {
        "id": BUILDING_TENT,
        "name": "Tent",
        "description": "A portable hide-and-fiber dwelling that can support a more mobile camp.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_RESIDENCE,
        "width": 3,
        "height": 2,
        "cost": {
            "Wood": 4,
            "Fiber": 8,
            "Hide": 6
        },
        "movable": true,
        "unlocked": false
    },

    BUILDING_STURDY_SHELTER: {
        "id": BUILDING_STURDY_SHELTER,
        "name": "Sturdy Shelter",
        "description": "A reinforced shelter suitable for a chieftain, elder, or important family group.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_LEADERSHIP,
        "width": 4,
        "height": 3,
        "cost": {
            "Wood": 16,
            "Stone": 6,
            "Fiber": 6
        },
        "movable": false,
        "unlocked": false
    },

    BUILDING_FURRED_TENT: {
        "id": BUILDING_FURRED_TENT,
        "name": "Furred Tent",
        "description": "A larger, insulated tent for a chieftain or important leader during mobile settlement phases.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_LEADERSHIP,
        "width": 4,
        "height": 3,
        "cost": {
            "Wood": 8,
            "Fiber": 10,
            "Hide": 12
        },
        "movable": true,
        "unlocked": false
    },

    BUILDING_MAKING_SPOT: {
        "id": BUILDING_MAKING_SPOT,
        "name": "Making Spot",
        "description": "A cleared work area where villagers can perform simple handcrafting.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_CRAFTING,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 2,
            "Stone": 1
        },
        "movable": false,
        "unlocked": true
    },

    BUILDING_STONE_WORKING_SPOT: {
        "id": BUILDING_STONE_WORKING_SPOT,
        "name": "Stone Working Spot",
        "description": "A basic place for chipping stone, shaping flint, and making crude stone tools.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_CRAFTING,
        "width": 2,
        "height": 2,
        "cost": {
            "Stone": 6,
            "Flint": 2
        },
        "movable": false,
        "unlocked": false
    },

    BUILDING_STONE_WORKING_BENCH: {
        "id": BUILDING_STONE_WORKING_BENCH,
        "name": "Stone Working Bench",
        "description": "An improved workbench for more reliable stone shaping and tool production.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_CRAFTING,
        "width": 3,
        "height": 2,
        "cost": {
            "Wood": 6,
            "Stone": 12,
            "Flint": 4
        },
        "movable": false,
        "unlocked": false
    },

    BUILDING_WOOD_WORKING_SPOT: {
        "id": BUILDING_WOOD_WORKING_SPOT,
        "name": "Wood Working Spot",
        "description": "A simple work area for cutting, scraping, binding, and shaping wood.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_CRAFTING,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 6,
            "Stone": 2
        },
        "movable": false,
        "unlocked": false
    },

    BUILDING_WOOD_WORKING_BENCH: {
        "id": BUILDING_WOOD_WORKING_BENCH,
        "name": "Wood Working Bench",
        "description": "An improved bench for shaping wooden tools, frames, handles, and simple structures.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_CRAFTING,
        "width": 3,
        "height": 2,
        "cost": {
            "Wood": 14,
            "Stone": 4,
            "Fiber": 4
        },
        "movable": false,
        "unlocked": false
    },

    BUILDING_HOLE_IN_GROUND: {
        "id": BUILDING_HOLE_IN_GROUND,
        "name": "Hole in the Ground",
        "description": "A crude storage pit for keeping gathered resources in one place.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_STORAGE,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 1
        },
        "movable": false,
        "unlocked": true
    },

    BUILDING_CRUDE_CONTAINER: {
        "id": BUILDING_CRUDE_CONTAINER,
        "name": "Crude Container",
        "description": "A primitive container made from wood, bark, hide, or woven fiber for safer storage.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_STORAGE,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 6,
            "Fiber": 6,
            "Hide": 2
        },
        "movable": true,
        "unlocked": false
    },

    BUILDING_THINKERS_SPOT: {
        "id": BUILDING_THINKERS_SPOT,
        "name": "Thinker's Spot",
        "description": "A quiet place where elders and clever villagers observe, discuss, and test new ideas.",
        "age": AGE_STONE,
        "tier": 1,
        "category": CATEGORY_RESEARCH,
        "width": 2,
        "height": 2,
        "cost": {
            "Wood": 3,
            "Stone": 3
        },
        "movable": false,
        "unlocked": true
    },

    BUILDING_THINKERS_ROCK: {
        "id": BUILDING_THINKERS_ROCK,
        "name": "Thinker's Rock",
        "description": "A marked stone gathering place that improves early research, planning, and oral tradition.",
        "age": AGE_STONE,
        "tier": 2,
        "category": CATEGORY_RESEARCH,
        "width": 3,
        "height": 2,
        "cost": {
            "Stone": 12,
            "Flint": 2
        },
        "movable": false,
        "unlocked": false
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

    var cost_variant: Variant = building_data.get("cost", {})

    if typeof(cost_variant) != TYPE_DICTIONARY:
        return {}

    var cost: Dictionary = cost_variant
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
