extends RefCounted
class_name StoneAgeResearchData

const RESEARCH_POINTED_STICK_PLAN: String = "pointed_stick_plan"
const RESEARCH_SIMPLE_HAND_AXE_PLAN: String = "simple_hand_axe_plan"
const RESEARCH_SHARP_STONE_KNIFE_PLAN: String = "sharp_stone_knife_plan"
const RESEARCH_CRUDE_CONTAINER_PLAN: String = "crude_container_plan"
const RESEARCH_SLING_PLAN: String = "sling_plan"
const RESEARCH_HERBAL_POULTICE_PLAN: String = "herbal_poultice_plan"

const RESEARCH_THROWING_SPEAR_PLAN: String = "throwing_spear_plan"
const RESEARCH_STONE_TIPPED_SPEAR_PLAN: String = "stone_tipped_spear_plan"
const RESEARCH_STONE_CLUB_PLAN: String = "stone_club_plan"
const RESEARCH_STONE_SCRAPER_PLAN: String = "stone_scraper_plan"
const RESEARCH_WORKED_HAND_AXE_PLAN: String = "worked_hand_axe_plan"

const RESEARCH_DRAG_SLED_PLAN: String = "drag_sled_plan"
const RESEARCH_TENT_KIT_PLAN: String = "tent_kit_plan"
const RESEARCH_TENT_PLAN: String = "tent_plan"
const RESEARCH_CHIEFTAINS_TENT_PLAN: String = "chieftains_tent_plan"
const RESEARCH_PERSONAL_CARRYING: String = "personal_carrying"

const RESEARCH_ADVANCED_SLING_PLAN: String = "advanced_sling_plan"
const RESEARCH_FLINT_TIPPED_HUNTING_SPEAR_PLAN: String = "flint_tipped_hunting_spear_plan"
const RESEARCH_FLINT_EDGED_HAND_AXE_PLAN: String = "flint_edged_hand_axe_plan"
const RESEARCH_FLINT_EDGED_WOODSMAN_AXE_PLAN: String = "flint_edged_woodsman_axe_plan"
const RESEARCH_FLINT_TIPPED_MINING_PICK_PLAN: String = "flint_tipped_mining_pick_plan"

const RESEARCH_FEAR_OF_THE_DARK: String = "fear_of_the_dark"
const RESEARCH_BONFIRE_PLAN: String = "bonfire_plan"
const RESEARCH_SPIRITUAL_LEADER_TENT_PLAN: String = "spiritual_leader_tent_plan"
const RESEARCH_RITUAL_SITE_PLAN: String = "ritual_site_plan"

const RESEARCH_STONEWORKING_HUT_PLAN: String = "stoneworking_hut_plan"
const RESEARCH_WOODWORKING_HUT_PLAN: String = "woodworking_hut_plan"

# Backward-compatible aliases for older code references.
const RESEARCH_STONEWORKING_BENCH_PLAN: String = RESEARCH_STONEWORKING_HUT_PLAN
const RESEARCH_WOODWORKING_BENCH_PLAN: String = RESEARCH_WOODWORKING_HUT_PLAN

const RESEARCH_HUNTERS_HUT_PLAN: String = "hunters_hut_plan"
const RESEARCH_WARLEADER_SHELTER_PLAN: String = "warleader_shelter_plan"
const RESEARCH_WARRIOR_HUT_PLAN: String = "warrior_hut_plan"

const RESEARCH_CAMP_PATHS: String = "camp_paths"
const RESEARCH_SHARED_WORK_RHYTHM: String = "shared_work_rhythm"

const RESEARCH_TIER_STONE_AGE_T1: String = "stone_age_t1"
const RESEARCH_TIER_STONE_AGE_T2: String = "stone_age_t2"
const RESEARCH_TIER_STONE_AGE_T3: String = "stone_age_t3"

const UNLOCK_TYPE_BUILDING: String = "building"
const UNLOCK_TYPE_RECIPE: String = "recipe"
const UNLOCK_TYPE_GLOBAL_BONUS: String = "global_bonus"

const BONUS_VILLAGER_MOVE_SPEED: String = "villager_move_speed"
const BONUS_BUILDING_SPEED: String = "building_speed"
const BONUS_BELONGING_SLOTS: String = "belonging_slots"

const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_SLING: String = "sling"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"

const RECIPE_THROWING_SPEAR: String = "throwing_spear"
const RECIPE_STONE_TIPPED_SPEAR: String = "stone_tipped_spear"
const RECIPE_STONE_CLUB: String = "stone_club"
const RECIPE_STONE_SCRAPER: String = "stone_scraper"
const RECIPE_WORKED_HAND_AXE: String = "worked_hand_axe"

const RECIPE_DRAG_SLED: String = "drag_sled"
const RECIPE_TENT_KIT: String = "tent_kit"
const RECIPE_ADVANCED_SLING: String = "advanced_sling"
const RECIPE_FLINT_TIPPED_HUNTING_SPEAR: String = "flint_tipped_hunting_spear"
const RECIPE_FLINT_EDGED_HAND_AXE: String = "flint_edged_hand_axe"
const RECIPE_FLINT_EDGED_WOODSMAN_AXE: String = "flint_edged_woodsman_axe"
const RECIPE_FLINT_TIPPED_MINING_PICK: String = "flint_tipped_mining_pick"

# Backward-compatible alias.
const RECIPE_FLINT_TIPPED_SPEAR: String = RECIPE_FLINT_TIPPED_HUNTING_SPEAR

const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"
const RESOURCE_FLINT_NAME: String = "Flint"

const GLOBAL_BONUS_SMALL_AMOUNT: float = 0.02
const BELONGING_SLOT_BONUS_AMOUNT: int = 1


static func get_all_research_plans() -> Dictionary:
    return {
        RESEARCH_WOODWORKING_HUT_PLAN: {
            "id": RESEARCH_WOODWORKING_HUT_PLAN,
            "name": "Woodworking Hut",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 4,
            "description": "The village learns to set aside a dedicated hut for shaping branches, handles, frames, poles, and later moving-camp parts.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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

        RESEARCH_STONEWORKING_HUT_PLAN: {
            "id": RESEARCH_STONEWORKING_HUT_PLAN,
            "name": "Stoneworking Hut",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 4,
            "description": "The village learns to set aside a dedicated hut for shaping stone, flint, crude blades, and early tool heads.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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

        RESEARCH_POINTED_STICK_PLAN: {
            "id": RESEARCH_POINTED_STICK_PLAN,
            "name": "Pointed Stick Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 4,
            "description": "Teaches the village to shape a crude pointed stick for basic defense, work, and future hunting systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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

        RESEARCH_SHARP_STONE_KNIFE_PLAN: {
            "id": RESEARCH_SHARP_STONE_KNIFE_PLAN,
            "name": "Sharp Stone Knife Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 5,
            "description": "Teaches the village to make a crude cutting tool for fiber, food, hides, and medicine work later.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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
            "cost": 6,
            "description": "Teaches the village to make crude containers for carrying and organizing supplies later.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_MAKING_SPOT,
                RegionBuildingData.BUILDING_STORAGE_AREA
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_CRUDE_CONTAINER
            ],
            "global_bonuses": []
        },

        RESEARCH_HERBAL_POULTICE_PLAN: {
            "id": RESEARCH_HERBAL_POULTICE_PLAN,
            "name": "Herbal Poultice Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 6,
            "description": "Teaches the village to prepare a crude medicine from gathered fiber, berries, and mushrooms for future sickness and injury systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            "required_research": [],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME,
                RESOURCE_BERRIES_NAME,
                RESOURCE_MUSHROOMS_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_HERBAL_POULTICE
            ],
            "global_bonuses": []
        },

        RESEARCH_SLING_PLAN: {
            "id": RESEARCH_SLING_PLAN,
            "name": "Sling Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 7,
            "description": "Teaches the village to make a simple sling for future hunting and defense systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_MAKING_SPOT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_POINTED_STICK_PLAN
            ],
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

        RESEARCH_SIMPLE_HAND_AXE_PLAN: {
            "id": RESEARCH_SIMPLE_HAND_AXE_PLAN,
            "name": "Simple Hand Axe Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 6,
            "description": "Teaches the village to shape a crude chopping hand tool.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_MAKING_SPOT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_SHARP_STONE_KNIFE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_SIMPLE_HAND_AXE
            ],
            "global_bonuses": []
        },

        RESEARCH_CAMP_PATHS: {
            "id": RESEARCH_CAMP_PATHS,
            "name": "Camp Paths",
            "tier": RESEARCH_TIER_STONE_AGE_T1,
            "cost": 8,
            "description": "The village learns to keep clear paths through camp, improving villager movement.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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
            "cost": 8,
            "description": "The village learns to coordinate construction work more effectively.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
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
        },

        RESEARCH_HUNTERS_HUT_PLAN: {
            "id": RESEARCH_HUNTERS_HUT_PLAN,
            "name": "Hunter's Hut",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 8,
            "description": "The village learns to build a dedicated hut for future hunters. Hunting behavior is not active yet; this building is a trigger and specialist shelter placeholder.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_MAKING_SPOT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_POINTED_STICK_PLAN,
                RESEARCH_SLING_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_HUNTERS_HUT
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_WARLEADER_SHELTER_PLAN: {
            "id": RESEARCH_WARLEADER_SHELTER_PLAN,
            "name": "Warleader Shelter",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 10,
            "description": "The village learns to prepare a shelter for a future Warleader, separating the hunting and combat tutorial branch from the cultural systems branch.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
                RegionBuildingData.BUILDING_HUNTERS_HUT
            ],
            "required_research": [
                RESEARCH_HUNTERS_HUT_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_WARLEADER_SHELTER
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_WARRIOR_HUT_PLAN: {
            "id": RESEARCH_WARRIOR_HUT_PLAN,
            "name": "Warrior Hut",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 12,
            "description": "The village learns to build a dedicated hut for future warriors. Combat behavior is not active yet; this building is a trigger and specialist shelter placeholder.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WARLEADER_SHELTER,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_WARLEADER_SHELTER_PLAN,
                RESEARCH_SIMPLE_HAND_AXE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_WARRIOR_HUT
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_THROWING_SPEAR_PLAN: {
            "id": RESEARCH_THROWING_SPEAR_PLAN,
            "name": "Throwing Spear Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 8,
            "description": "The village learns to make a light throwing spear for early hunting and ranged combat.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_HUNTERS_HUT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_HUNTERS_HUT_PLAN,
                RESEARCH_POINTED_STICK_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_THROWING_SPEAR
            ],
            "global_bonuses": []
        },

        RESEARCH_STONE_TIPPED_SPEAR_PLAN: {
            "id": RESEARCH_STONE_TIPPED_SPEAR_PLAN,
            "name": "Stone-Tipped Spear Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 9,
            "description": "The village learns to make a stronger spear with a shaped stone point.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_HUNTERS_HUT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_HUNTERS_HUT_PLAN,
                RESEARCH_SHARP_STONE_KNIFE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_STONE_TIPPED_SPEAR
            ],
            "global_bonuses": []
        },

        RESEARCH_STONE_CLUB_PLAN: {
            "id": RESEARCH_STONE_CLUB_PLAN,
            "name": "Stone Club Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 9,
            "description": "The village learns to make a simple heavy club for warrior training and close combat.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WARLEADER_SHELTER,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_WARLEADER_SHELTER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_STONE_CLUB
            ],
            "global_bonuses": []
        },

        RESEARCH_STONE_SCRAPER_PLAN: {
            "id": RESEARCH_STONE_SCRAPER_PLAN,
            "name": "Stone Scraper Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 8,
            "description": "The village learns to make a worked scraper for future hide, fiber, food, and medicine preparation.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_SHARP_STONE_KNIFE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FLINT_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_STONE_SCRAPER
            ],
            "global_bonuses": []
        },

        RESEARCH_WORKED_HAND_AXE_PLAN: {
            "id": RESEARCH_WORKED_HAND_AXE_PLAN,
            "name": "Worked Hand Axe Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T2,
            "cost": 9,
            "description": "The village learns to make a more carefully worked hand axe.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_SIMPLE_HAND_AXE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_WORKED_HAND_AXE
            ],
            "global_bonuses": []
        },

        RESEARCH_DRAG_SLED_PLAN: {
            "id": RESEARCH_DRAG_SLED_PLAN,
            "name": "Drag Sled Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 10,
            "description": "The village learns to make crude drag sleds for future camp movement actions.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_HUNTERS_HUT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_HUNTERS_HUT_PLAN,
                RESEARCH_CRUDE_CONTAINER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_DRAG_SLED
            ],
            "global_bonuses": []
        },

        RESEARCH_TENT_KIT_PLAN: {
            "id": RESEARCH_TENT_KIT_PLAN,
            "name": "Tent Kit Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 10,
            "description": "The village learns to bundle poles and lashings into portable Tent Kits.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_DRAG_SLED_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_TENT_KIT
            ],
            "global_bonuses": []
        },

        RESEARCH_TENT_PLAN: {
            "id": RESEARCH_TENT_PLAN,
            "name": "Tent Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 12,
            "description": "The village learns how to turn Tent Kits into portable shelters.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_TENT_KIT_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_TENT
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_CHIEFTAINS_TENT_PLAN: {
            "id": RESEARCH_CHIEFTAINS_TENT_PLAN,
            "name": "Chieftain's Tent Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 12,
            "description": "The village learns how to build a portable leadership tent using multiple Tent Kits.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER
            ],
            "required_research": [
                RESEARCH_TENT_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_CHIEFTAINS_TENT
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_PERSONAL_CARRYING: {
            "id": RESEARCH_PERSONAL_CARRYING,
            "name": "Personal Carrying",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 14,
            "description": "The village learns better carrying habits. Villagers gain one additional belonging slot, reaching the Stone Age cap of 2.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT
            ],
            "required_research": [
                RESEARCH_DRAG_SLED_PLAN,
                RESEARCH_CRUDE_CONTAINER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [],
            "global_bonuses": [
                {
                    "id": BONUS_BELONGING_SLOTS,
                    "name": "Belonging Slots",
                    "amount": BELONGING_SLOT_BONUS_AMOUNT
                }
            ]
        },

        RESEARCH_ADVANCED_SLING_PLAN: {
            "id": RESEARCH_ADVANCED_SLING_PLAN,
            "name": "Advanced Sling Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 11,
            "description": "The village learns to make a stronger sling with better cordage and stone pouching.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_HUNTERS_HUT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_SLING_PLAN,
                RESEARCH_STONE_SCRAPER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FIBER_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_ADVANCED_SLING
            ],
            "global_bonuses": []
        },

        RESEARCH_FLINT_TIPPED_HUNTING_SPEAR_PLAN: {
            "id": RESEARCH_FLINT_TIPPED_HUNTING_SPEAR_PLAN,
            "name": "Flint-Tipped Hunting Spear Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 12,
            "description": "The village learns to make a refined hunting spear with a sharp flint point.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_HUNTERS_HUT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_STONE_TIPPED_SPEAR_PLAN,
                RESEARCH_STONE_SCRAPER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FLINT_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_FLINT_TIPPED_HUNTING_SPEAR
            ],
            "global_bonuses": []
        },

        RESEARCH_FLINT_EDGED_HAND_AXE_PLAN: {
            "id": RESEARCH_FLINT_EDGED_HAND_AXE_PLAN,
            "name": "Flint-Edged Hand Axe Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 12,
            "description": "The village learns to make a sharper hand axe with a flint edge.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_WORKED_HAND_AXE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FLINT_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_FLINT_EDGED_HAND_AXE
            ],
            "global_bonuses": []
        },

        RESEARCH_FLINT_EDGED_WOODSMAN_AXE_PLAN: {
            "id": RESEARCH_FLINT_EDGED_WOODSMAN_AXE_PLAN,
            "name": "Flint-Edged Woodsman Axe Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 14,
            "description": "The village learns to make a heavier flint-edged axe for future woodcutting and clearing systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WOODWORKING_BENCH,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_FLINT_EDGED_HAND_AXE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FLINT_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_FLINT_EDGED_WOODSMAN_AXE
            ],
            "global_bonuses": []
        },

        RESEARCH_FLINT_TIPPED_MINING_PICK_PLAN: {
            "id": RESEARCH_FLINT_TIPPED_MINING_PICK_PLAN,
            "name": "Flint-Tipped Mining Pick Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 14,
            "description": "The village learns to make a crude mining pick with a flint working point.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ],
            "required_research": [
                RESEARCH_FLINT_EDGED_HAND_AXE_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [
                RESOURCE_FLINT_NAME
            ],
            "unlocks_buildings": [],
            "unlocks_recipes": [
                RECIPE_FLINT_TIPPED_MINING_PICK
            ],
            "global_bonuses": []
        },

        RESEARCH_FEAR_OF_THE_DARK: {
            "id": RESEARCH_FEAR_OF_THE_DARK,
            "name": "Fear of the Dark",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 12,
            "description": "The village begins to explain and organize its fear of the dark, opening the first cultural and spiritual systems.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_WARLEADER_SHELTER
            ],
            "required_research": [
                RESEARCH_WARLEADER_SHELTER_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_BONFIRE_PLAN: {
            "id": RESEARCH_BONFIRE_PLAN,
            "name": "Bonfire Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 14,
            "description": "The village learns to build a larger communal fire with a wider camp influence.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT
            ],
            "required_research": [
                RESEARCH_FEAR_OF_THE_DARK
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_BONFIRE
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_SPIRITUAL_LEADER_TENT_PLAN: {
            "id": RESEARCH_SPIRITUAL_LEADER_TENT_PLAN,
            "name": "Spiritual Leader's Tent Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 16,
            "description": "The village learns to build a special tent for a future Spiritual Leader.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_CHIEFTAINS_TENT
            ],
            "required_research": [
                RESEARCH_FEAR_OF_THE_DARK,
                RESEARCH_CHIEFTAINS_TENT_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_SPIRITUAL_LEADER_TENT
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
        },

        RESEARCH_RITUAL_SITE_PLAN: {
            "id": RESEARCH_RITUAL_SITE_PLAN,
            "name": "Ritual Site Plan",
            "tier": RESEARCH_TIER_STONE_AGE_T3,
            "cost": 18,
            "description": "The village learns to mark a gathering place for future rituals.",
            "required_buildings": [
                RegionBuildingData.BUILDING_THINKERS_SPOT,
                RegionBuildingData.BUILDING_BONFIRE,
                RegionBuildingData.BUILDING_SPIRITUAL_LEADER_TENT
            ],
            "required_research": [
                RESEARCH_BONFIRE_PLAN,
                RESEARCH_SPIRITUAL_LEADER_TENT_PLAN
            ],
            "required_any_resources_seen": [],
            "required_all_resources_seen": [],
            "unlocks_buildings": [
                RegionBuildingData.BUILDING_RITUAL_SITE
            ],
            "unlocks_recipes": [],
            "global_bonuses": []
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
