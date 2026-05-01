extends RefCounted
class_name StoneAgeBuildingData

const AGE_STONE: String = RegionAgeData.AGE_STONE

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

const BUILDING_TENT: String = "tent"
const BUILDING_CHIEFTAINS_TENT: String = "chieftains_tent"
const BUILDING_BONFIRE: String = "bonfire"
const BUILDING_SPIRITUAL_LEADER_TENT: String = "spiritual_leader_tent"
const BUILDING_RITUAL_SITE: String = "ritual_site"

const CAMPFIRE_BUILD_RADIUS: int = 6
const BONFIRE_BUILD_RADIUS: int = 15

const STORAGE_BASE_RESOURCE_CAP: int = 20
const STORAGE_AREA_CAPACITY: int = 50

const SHELTER_CAPACITY: int = 2
const TENT_CAPACITY: int = 2

const CHIEFTAINS_SHELTER_REQUIRED_SHELTERS: int = 3
const CHIEFTAINS_SHELTER_CAPACITY: int = 0
const CHIEFTAINS_TENT_CAPACITY: int = 0
const SPIRITUAL_LEADER_TENT_CAPACITY: int = 0

const THINKERS_SPOT_RESEARCH_PER_MINUTE: int = 1

const SPECIALIST_HUT_CAPACITY: int = 1
const WARLEADER_SHELTER_CAPACITY: int = 0


static func get_all_buildings() -> Dictionary:
    return {
        BUILDING_CAMPFIRE: {
            "id": BUILDING_CAMPFIRE,
            "name": "Campfire",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CORE,
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

        BUILDING_STORAGE_AREA: {
            "id": BUILDING_STORAGE_AREA,
            "name": "Storage Area",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CORE,
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

        BUILDING_MAKING_SPOT: {
            "id": BUILDING_MAKING_SPOT,
            "name": "Making Spot",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CORE,
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

        BUILDING_THINKERS_SPOT: {
            "id": BUILDING_THINKERS_SPOT,
            "name": "Thinker's Spot",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CORE,
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
            "description": "A simple place for early planning, observation, and shared ideas. It generates 1 Research per minute."
        },

        BUILDING_BONFIRE: {
            "id": BUILDING_BONFIRE,
            "name": "Bonfire",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CORE,
            "width": 2,
            "height": 2,
            "cost": {
                "Wood": 20,
                "Stone": 8
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": BONFIRE_BUILD_RADIUS,
            "provides_bonfire_radius": true,
            "description": "A larger communal fire. It has a much wider camp influence than a Campfire and begins the cultural response to fear of the dark."
        },

        BUILDING_SHELTER: {
            "id": BUILDING_SHELTER,
            "name": "Shelter",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_HOUSING,
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
            "category": RegionAgeData.CATEGORY_HOUSING,
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
            "description": "A larger, more respected shelter used by the village leader. Building it grants a generic Chieftain for now and unlocks the Making Spot and Thinker's Spot."
        },

        BUILDING_TENT: {
            "id": BUILDING_TENT,
            "name": "Tent",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_HOUSING,
            "width": 2,
            "height": 1,
            "cost": {
                "Wood": 2
            },
            "item_cost": {
                RegionRecipeData.ITEM_TENT_KIT: 1
            },
            "movable": true,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": TENT_CAPACITY,
            "description": "A portable shelter built from a Tent Kit. It shelters 2 normal villagers and supports future moving-camp systems."
        },

        BUILDING_CHIEFTAINS_TENT: {
            "id": BUILDING_CHIEFTAINS_TENT,
            "name": "Chieftain's Tent",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_HOUSING,
            "width": 2,
            "height": 2,
            "cost": {
                "Wood": 4,
                "Stone": 2
            },
            "item_cost": {
                RegionRecipeData.ITEM_TENT_KIT: 2
            },
            "movable": true,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": CHIEFTAINS_TENT_CAPACITY,
            "houses_chieftain": true,
            "description": "A portable leadership tent built from multiple Tent Kits. It represents the Chieftain's authority becoming mobile for future camp movement systems."
        },

        BUILDING_WARLEADER_SHELTER: {
            "id": BUILDING_WARLEADER_SHELTER,
            "name": "Warleader Shelter",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_HOUSING,
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

        BUILDING_SPIRITUAL_LEADER_TENT: {
            "id": BUILDING_SPIRITUAL_LEADER_TENT,
            "name": "Spiritual Leader's Tent",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_HOUSING,
            "width": 2,
            "height": 2,
            "cost": {
                "Fiber": 4,
                "Stone": 2
            },
            "item_cost": {
                RegionRecipeData.ITEM_TENT_KIT: 2
            },
            "movable": true,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "housing_capacity": SPIRITUAL_LEADER_TENT_CAPACITY,
            "houses_spiritual_leader": true,
            "description": "A special tent for a future Spiritual Leader. It supports the later cultural and ritual systems."
        },

        BUILDING_STONEWORKING_BENCH: {
            "id": BUILDING_STONEWORKING_BENCH,
            "name": "Stoneworking Hut",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CRAFTING,
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
            "description": "A dedicated Stone Age work hut for shaping stone, flint, crude blades, and early tool heads."
        },

        BUILDING_WOODWORKING_BENCH: {
            "id": BUILDING_WOODWORKING_BENCH,
            "name": "Woodworking Hut",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_CRAFTING,
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
            "description": "A dedicated Stone Age work hut for shaping branches, poles, handles, frames, and later moving-camp parts."
        },

        BUILDING_HUNTERS_HUT: {
            "id": BUILDING_HUNTERS_HUT,
            "name": "Hunter's Hut",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_SPECIAL,
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
            "description": "A dedicated Stone Age hut for future hunters. For now, it unlocks and builds as a placeholder."
        },

        BUILDING_WARRIOR_HUT: {
            "id": BUILDING_WARRIOR_HUT,
            "name": "Warrior Hut",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_SPECIAL,
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
            "description": "A dedicated Stone Age hut for future warriors. For now, it unlocks and builds as a placeholder."
        },

        BUILDING_RITUAL_SITE: {
            "id": BUILDING_RITUAL_SITE,
            "name": "Ritual Site",
            "age": AGE_STONE,
            "category": RegionAgeData.CATEGORY_SPECIAL,
            "width": 3,
            "height": 3,
            "cost": {
                "Stone": 12,
                "Wood": 8,
                "Fiber": 4
            },
            "item_cost": {},
            "movable": false,
            "requires_campfire_range": true,
            "requires_research_unlock": true,
            "campfire_radius": CAMPFIRE_BUILD_RADIUS,
            "description": "A marked gathering place for future rituals. It unlocks the foundation for later cultural and spiritual mechanics."
        }
    }
