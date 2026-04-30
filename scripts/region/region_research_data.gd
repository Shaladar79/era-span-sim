extends RefCounted
class_name RegionResearchData

const RESEARCH_POINTED_STICK_PLAN: String = "pointed_stick_plan"
const RESEARCH_SIMPLE_HAND_AXE_PLAN: String = "simple_hand_axe_plan"
const RESEARCH_SHARP_STONE_KNIFE_PLAN: String = "sharp_stone_knife_plan"
const RESEARCH_CRUDE_CONTAINER_PLAN: String = "crude_container_plan"
const RESEARCH_SLING_PLAN: String = "sling_plan"
const RESEARCH_HERBAL_POULTICE_PLAN: String = "herbal_poultice_plan"
const RESEARCH_STONEWORKING_BENCH_PLAN: String = "stoneworking_bench_plan"
const RESEARCH_WOODWORKING_BENCH_PLAN: String = "woodworking_bench_plan"
const RESEARCH_CAMP_PATHS: String = "camp_paths"
const RESEARCH_SHARED_WORK_RHYTHM: String = "shared_work_rhythm"

const RESEARCH_TIER_STONE_AGE_T1: String = "stone_age_t1"

const UNLOCK_TYPE_BUILDING: String = "building"
const UNLOCK_TYPE_RECIPE: String = "recipe"
const UNLOCK_TYPE_GLOBAL_BONUS: String = "global_bonus"

const BONUS_VILLAGER_MOVE_SPEED: String = "villager_move_speed"
const BONUS_BUILDING_SPEED: String = "building_speed"

const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_SLING: String = "sling"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"

const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"

const GLOBAL_BONUS_SMALL_AMOUNT: float = 0.02


static func get_all_research_plans() -> Dictionary:
    return {
        RESEARCH_POINTED_STICK_PLAN: {
            "id": RESEARCH_POINTED_STICK_PLAN,
            "name": "Pointed Stick Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 2,
            "description": "Teaches the village to shape a crude pointed stick for basic defense, work, and future hunting systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_POINTED_STICK
            ],
            "global_bonuses": []
        },

        RESEARCH_SIMPLE_HAND_AXE_PLAN: {
            "id": RESEARCH_SIMPLE_HAND_AXE_PLAN,
            "name": "Simple Hand Axe Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 3,
            "description": "Teaches the village to shape a crude chopping hand tool.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_SIMPLE_HAND_AXE
            ],
            "global_bonuses": []
        },

        RESEARCH_SHARP_STONE_KNIFE_PLAN: {
            "id": RESEARCH_SHARP_STONE_KNIFE_PLAN,
            "name": "Sharp Stone Knife Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 3,
            "description": "Teaches the village to make a crude cutting tool for fiber, food, hides, and medicine work later.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_SHARP_STONE_KNIFE
            ],
            "global_bonuses": []
        },

        RESEARCH_CRUDE_CONTAINER_PLAN: {
            "id": RESEARCH_CRUDE_CONTAINER_PLAN,
            "name": "Crude Container Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 4,
            "description": "Teaches the village to make crude containers for carrying and organizing supplies later.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT,
                RegionBuildingData.BUILDING_STORAGE_AREA
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_CRUDE_CONTAINER
            ],
            "global_bonuses": []
        },

        RESEARCH_SLING_PLAN: {
            "id": RESEARCH_SLING_PLAN,
            "name": "Sling Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 4,
            "description": "Teaches the village to make a simple sling for future hunting and defense systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_SLING
            ],
            "global_bonuses": []
        },

        RESEARCH_HERBAL_POULTICE_PLAN: {
            "id": RESEARCH_HERBAL_POULTICE_PLAN,
            "name": "Herbal Poultice Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 5,
            "description": "Teaches the village to prepare a crude medicine for future sickness and injury systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [
                RESOURCE_BERRIES_NAME,
                RESOURCE_MUSHROOMS_NAME
            ],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_HERBAL_POULTICE
            ],
            "global_bonuses": []
        },

        RESEARCH_STONEWORKING_BENCH_PLAN: {
            "id": RESEARCH_STONEWORKING_BENCH_PLAN,
            "name": "Stoneworking Bench Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 5,
            "description": "Unlocks the Stoneworking Bench for controlled stone and flint shaping.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_WOODWORKING_BENCH_PLAN: {
            "id": RESEARCH_WOODWORKING_BENCH_PLAN,
            "name": "Woodworking Bench Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 5,
            "description": "Unlocks the Woodworking Bench for shaping poles, handles, frames, and portable structures later.",
            "required_buildings": [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_CAMP_PATHS: {
            "id": RESEARCH_CAMP_PATHS,
            "name": "Camp Paths",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 5,
            "description": "The village learns to keep clear paths through camp, improving villager movement.",
            "required_buildings": [
                RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
                RegionBuildingData.BUILDING_STORAGE_AREA
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [],
            "global_bonuses": [
                {
                    "id": BONUS_VILLAGER_MOVE_SPEED,
                    "name": "Villager Movement Speed",
                    "amount": GLOBAL_BONUS_SMALL_AMOUNT
                }
            ]
        },

        RESEARCH_SHARED_WORK_RHYTHM: {
            "id": RESEARCH_SHARED_WORK_RHYTHM,
            "name": "Shared Work Rhythm",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 6,
            "description": "The village learns to coordinate construction work more effectively.",
            "required_buildings": [
                RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [],
            "global_bonuses": [
                {
                    "id": BONUS_BUILDING_SPEED,
                    "name": "Building Speed",
                    "amount": GLOBAL_BONUS_SMALL_AMOUNT
                }
            ]
        }
    }


static func get_research_plan(research_id: String) -> Dictionary:
    var all_plans: Dictionary = get_all_research_plans()

    if not all_plans.has(research_id):
        return {}

    var plan: Dictionary = all_plans[research_id]

    return plan.duplicate(true)


static func get_all_research_ids() -> Array:
    var all_plans: Dictionary = get_all_research_plans()
    var research_ids: Array = all_plans.keys()

    research_ids.sort()

    return research_ids


static func get_research_name(research_id: String) -> String:
    var plan: Dictionary = get_research_plan(research_id)

    if plan.is_empty():
        return research_id

    return str(plan.get("name", research_id))


static func get_research_cost(research_id: String) -> int:
    var plan: Dictionary = get_research_plan(research_id)

    if plan.is_empty():
        return 0

    return int(plan.get("cost", 0))
