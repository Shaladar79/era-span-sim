extends RefCounted
class_name StoneAgeResearchData

# -------------------------------------------------------------------
# Core Stone Age idea / research IDs.
# -------------------------------------------------------------------

const RESEARCH_LEARN_CAMPFIRE: String = "learn_campfire"
const RESEARCH_STORAGE_AREA: String = "storage_area"
const RESEARCH_SHELTER: String = "shelter"
const RESEARCH_WE_NEED_A_LEADER: String = "we_need_a_leader"

const RESEARCH_WOOD_CARVING: String = "wood_carving"
const RESEARCH_STONE_WORKING: String = "stone_working"
const RESEARCH_FISHING: String = "fishing"
const RESEARCH_GATHERING: String = "gathering"
const RESEARCH_HUNTING: String = "hunting"

const RESEARCH_RECOGNIZE_FLINT: String = "recognize_flint"
const RESEARCH_SKINNING: String = "skinning"

const RESEARCH_DEFEND_THE_PEOPLE: String = "defend_the_people"
const RESEARCH_TO_WAR: String = "to_war"
const RESEARCH_BONE_CARVING: String = "bone_carving"

const RESEARCH_FEAR_OF_THE_DARK: String = "fear_of_the_dark"
const RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE: String = "personal_possessions_stone_age"
const RESEARCH_TENT_LIFE: String = "tent_life"
const RESEARCH_LIGHT_UP_THE_NIGHT: String = "light_up_the_night"
const RESEARCH_TIME_TO_MOVE_ON: String = "time_to_move_on"


# -------------------------------------------------------------------
# Recipe research IDs.
# -------------------------------------------------------------------

# T1 recipe research
const RESEARCH_TORCH_CRAFTING: String = "torch_crafting"
const RESEARCH_BASIC_STONE_TOOLS: String = "basic_stone_tools"
const RESEARCH_FOOT_WRAPPINGS: String = "foot_wrappings"

# T2 recipe research
const RESEARCH_WOOD_GATHERING_TOOLS: String = "wood_gathering_tools"
const RESEARCH_STONE_GATHERING_TOOLS: String = "stone_gathering_tools"
const RESEARCH_CUTTING_TOOLS: String = "cutting_tools"
const RESEARCH_FORAGERS_BASKETRY: String = "foragers_basketry"
const RESEARCH_FISH_TRAPPING: String = "fish_trapping"
const RESEARCH_HUNTERS_SLING: String = "hunters_sling"
const RESEARCH_STONE_SPEAR_COMPONENTS: String = "stone_spear_components"
const RESEARCH_HIDE_WRAPS: String = "hide_wraps"
const RESEARCH_STONE_CLUBS: String = "stone_clubs"
const RESEARCH_HIDE_ARMOR: String = "hide_armor"
const RESEARCH_BONE_CHARMS: String = "bone_charms"

# T3 recipe research
const RESEARCH_FLINT_TOOL_COMPONENTS: String = "flint_tool_components"
const RESEARCH_FLINT_SPEAR_COMPONENTS: String = "flint_spear_components"
const RESEARCH_IMPROVED_HAFTING: String = "improved_hafting"
const RESEARCH_TENT_FRAMING: String = "tent_framing"
const RESEARCH_FLINT_HATCHET: String = "flint_hatchet"
const RESEARCH_FLINT_PICK: String = "flint_pick"
const RESEARCH_FLINT_TIPPED_HUNTER_SPEAR: String = "flint_tipped_hunter_spear"
const RESEARCH_FLINT_TIPPED_SPEAR: String = "flint_tipped_spear"
const RESEARCH_HIDE_SLING: String = "hide_sling"
const RESEARCH_HIDE_POUCH: String = "hide_pouch"
const RESEARCH_TENT_KIT_ASSEMBLY: String = "tent_kit_assembly"
const RESEARCH_DRAG_SLED: String = "drag_sled"


# -------------------------------------------------------------------
# Future / legacy placeholder research constants.
# These are intentionally not returned in get_all_research_plans().
# -------------------------------------------------------------------

const RESEARCH_WHISPERS_IN_THE_DARK: String = "whispers_in_the_dark"
const RESEARCH_STONE_AGE_RITUAL_1: String = "stone_age_ritual_1"
const RESEARCH_STONE_AGE_RITUAL_2: String = "stone_age_ritual_2"
const RESEARCH_STONE_AGE_RITUAL_3: String = "stone_age_ritual_3"

const RESEARCH_T1_RANGED_WEAPONS: String = "t1_ranged_weapons"
const RESEARCH_T2_BELONGINGS: String = "t2_belongings"
const RESEARCH_T1_MELEE_WEAPONS: String = "t1_melee_weapons"
const RESEARCH_T2_RANGED_WEAPONS: String = "t2_ranged_weapons"
const RESEARCH_T2_MELEE_WEAPONS: String = "t2_melee_weapons"

const RESEARCH_POINTED_STICK_PLAN: String = "pointed_stick_plan"
const RESEARCH_SIMPLE_HAND_AXE_PLAN: String = RESEARCH_BASIC_STONE_TOOLS
const RESEARCH_SHARP_STONE_KNIFE_PLAN: String = RESEARCH_BASIC_STONE_TOOLS
const RESEARCH_CRUDE_CONTAINER_PLAN: String = "crude_container_plan"
const RESEARCH_SLING_PLAN: String = RESEARCH_HUNTERS_SLING
const RESEARCH_HERBAL_POULTICE_PLAN: String = "herbal_poultice_plan"

const RESEARCH_THROWING_SPEAR_PLAN: String = "throwing_spear_plan"
const RESEARCH_STONE_TIPPED_SPEAR_PLAN: String = RESEARCH_STONE_SPEAR_COMPONENTS
const RESEARCH_STONE_CLUB_PLAN: String = RESEARCH_STONE_CLUBS
const RESEARCH_STONE_SCRAPER_PLAN: String = "stone_scraper_plan"
const RESEARCH_WORKED_HAND_AXE_PLAN: String = "worked_hand_axe_plan"

const RESEARCH_DRAG_SLED_PLAN: String = RESEARCH_DRAG_SLED
const RESEARCH_TENT_KIT_PLAN: String = RESEARCH_TENT_KIT_ASSEMBLY
const RESEARCH_TENT_PLAN: String = RESEARCH_TENT_LIFE
const RESEARCH_CHIEFTAINS_TENT_PLAN: String = "chieftains_tent_plan"
const RESEARCH_PERSONAL_CARRYING: String = RESEARCH_HIDE_POUCH

const RESEARCH_ADVANCED_SLING_PLAN: String = RESEARCH_HIDE_SLING
const RESEARCH_FLINT_TIPPED_HUNTING_SPEAR_PLAN: String = RESEARCH_FLINT_TIPPED_HUNTER_SPEAR
const RESEARCH_FLINT_EDGED_HAND_AXE_PLAN: String = RESEARCH_FLINT_HATCHET
const RESEARCH_FLINT_EDGED_WOODSMAN_AXE_PLAN: String = RESEARCH_FLINT_HATCHET
const RESEARCH_FLINT_TIPPED_MINING_PICK_PLAN: String = RESEARCH_FLINT_PICK

const RESEARCH_BONFIRE_PLAN: String = RESEARCH_LIGHT_UP_THE_NIGHT
const RESEARCH_SPIRITUAL_LEADER_TENT_PLAN: String = "spiritual_leader_tent_plan"
const RESEARCH_RITUAL_SITE_PLAN: String = "ritual_site_plan"

const RESEARCH_STONEWORKING_HUT_PLAN: String = RESEARCH_STONE_WORKING
const RESEARCH_WOODWORKING_HUT_PLAN: String = RESEARCH_WOOD_CARVING

const RESEARCH_STONEWORKING_BENCH_PLAN: String = RESEARCH_STONEWORKING_HUT_PLAN
const RESEARCH_WOODWORKING_BENCH_PLAN: String = RESEARCH_WOODWORKING_HUT_PLAN

const RESEARCH_HUNTERS_HUT_PLAN: String = RESEARCH_HUNTING
const RESEARCH_FISHING_HUT_PLAN: String = RESEARCH_FISHING
const RESEARCH_WARLEADER_SHELTER_PLAN: String = RESEARCH_DEFEND_THE_PEOPLE
const RESEARCH_WARRIOR_HUT_PLAN: String = RESEARCH_TO_WAR

const RESEARCH_CAMP_PATHS: String = "camp_paths"
const RESEARCH_SHARED_WORK_RHYTHM: String = "shared_work_rhythm"


# -------------------------------------------------------------------
# Category constants.
# -------------------------------------------------------------------

const CATEGORY_CORE: String = "core"
const CATEGORY_TOOLS: String = "tools"
const CATEGORY_BELONGINGS: String = "belongings"
const CATEGORY_EQUIPMENT: String = "equipment"
const CATEGORY_RELICS: String = "relics"


# -------------------------------------------------------------------
# Shared metadata constants.
# -------------------------------------------------------------------

const RESEARCH_TIER_STONE_AGE_T1: String = "stone_age_t1"
const RESEARCH_TIER_STONE_AGE_T2: String = "stone_age_t2"
const RESEARCH_TIER_STONE_AGE_T3: String = "stone_age_t3"
const RESEARCH_TIER_STONE_AGE_TRANSITION: String = "stone_age_transition"

const UNLOCK_TYPE_BUILDING: String = "building"
const UNLOCK_TYPE_RECIPE: String = "recipe"
const UNLOCK_TYPE_GLOBAL_BONUS: String = "global_bonus"
const UNLOCK_TYPE_SYSTEM: String = "system"

const BONUS_VILLAGER_MOVE_SPEED: String = "villager_move_speed"
const BONUS_BUILDING_SPEED: String = "building_speed"
const BONUS_BELONGING_SLOTS: String = "belonging_slots"

const GLOBAL_BONUS_SMALL_AMOUNT: float = 0.02
const BELONGING_SLOT_BONUS_AMOUNT: int = 1


# -------------------------------------------------------------------
# Legacy recipe constants kept for compatibility.
# -------------------------------------------------------------------

const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_SLING: String = "sling"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"

const RECIPE_THROWING_SPEAR: String = "throwing_spear"
const RECIPE_STONE_TIPPED_SPEAR: String = "stone_spear"
const RECIPE_STONE_CLUB: String = "stone_club"
const RECIPE_STONE_SCRAPER: String = "stone_scraper"
const RECIPE_WORKED_HAND_AXE: String = "worked_hand_axe"

const RECIPE_DRAG_SLED: String = "drag_sled"
const RECIPE_TENT_KIT: String = "tent_kit"
const RECIPE_ADVANCED_SLING: String = "advanced_sling"
const RECIPE_FLINT_TIPPED_HUNTING_SPEAR: String = "flint_tipped_hunter_spear"
const RECIPE_FLINT_EDGED_HAND_AXE: String = "flint_hatchet"
const RECIPE_FLINT_EDGED_WOODSMAN_AXE: String = "flint_hatchet"
const RECIPE_FLINT_TIPPED_MINING_PICK: String = "flint_pick"

const RECIPE_FLINT_TIPPED_SPEAR: String = "flint_tipped_spear"


# -------------------------------------------------------------------
# Resource / bonus constants kept for compatibility.
# -------------------------------------------------------------------

const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FISH_NAME: String = "Fish"


static func get_default_research_category() -> String:
    return CATEGORY_CORE


static func get_research_categories() -> Array:
    return [
        {
            "id": CATEGORY_CORE,
            "name": "Core"
        },
        {
            "id": CATEGORY_TOOLS,
            "name": "Tools"
        },
        {
            "id": CATEGORY_BELONGINGS,
            "name": "Belongings"
        },
        {
            "id": CATEGORY_EQUIPMENT,
            "name": "Equipment"
        },
        {
            "id": CATEGORY_RELICS,
            "name": "Relics"
        }
    ]


static func get_research_category_name(category_id: String) -> String:
    var categories: Array = get_research_categories()

    for category_index in range(categories.size()):
        var category_data: Dictionary = categories[category_index]
        var current_id: String = str(category_data.get("id", ""))

        if current_id == category_id:
            return str(category_data.get("name", category_id))

    return category_id.capitalize()


static func make_plan(
    research_id: String,
    research_name: String,
    category: String,
    tier: String,
    cost: int,
    description: String,
    required_research: Array = [],
    required_buildings: Array = [],
    unlocks_buildings: Array = [],
    unlocks_recipes: Array = [],
    global_bonuses: Array = [],
    unlocks_systems: Array = []
) -> Dictionary:
    return {
        "id": research_id,
        "name": research_name,
        "category": category,
        "tier": tier,
        "cost": cost,
        "description": description,
        "required_buildings": required_buildings.duplicate(true),
        "required_research": required_research.duplicate(true),
        "required_any_resources_seen": [],
        "required_all_resources_seen": [],
        "unlocks_buildings": unlocks_buildings.duplicate(true),
        "unlocks_recipes": unlocks_recipes.duplicate(true),
        "global_bonuses": global_bonuses.duplicate(true),
        "unlocks_systems": unlocks_systems.duplicate(true)
    }


static func get_all_research_plans() -> Dictionary:
    return {
        RESEARCH_LEARN_CAMPFIRE: make_plan(
            RESEARCH_LEARN_CAMPFIRE,
            "The Gift of Fire",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            2,
            "The village learns to preserve and use controlled fire, allowing Campfire construction.",
            [],
            [
                RegionBuildingData.BUILDING_THINKERS_SPOT
            ],
            [
                RegionBuildingData.BUILDING_CAMPFIRE
            ]
        ),

        RESEARCH_STORAGE_AREA: make_plan(
            RESEARCH_STORAGE_AREA,
            "Storage Area",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            2,
            "The village learns to set aside a controlled area for stored resources.",
            [
                RESEARCH_LEARN_CAMPFIRE
            ],
            [],
            [
                RegionBuildingData.BUILDING_STORAGE_AREA
            ]
        ),

        RESEARCH_SHELTER: make_plan(
            RESEARCH_SHELTER,
            "Shelter",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village learns to build simple shelters for protection and population growth.",
            [
                RESEARCH_LEARN_CAMPFIRE
            ],
            [],
            [
                RegionBuildingData.BUILDING_SHELTER
            ]
        ),

        RESEARCH_WE_NEED_A_LEADER: make_plan(
            RESEARCH_WE_NEED_A_LEADER,
            "We Need a Leader",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            6,
            "The village recognizes the need for leadership, unlocking the Chieftain's Shelter and preparing the hero system.",
            [
                RESEARCH_LEARN_CAMPFIRE,
                RESEARCH_SHELTER
            ],
            [],
            [
                RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER
            ],
            [],
            [],
            [
                "hero_system_available"
            ]
        ),

        RESEARCH_WOOD_CARVING: make_plan(
            RESEARCH_WOOD_CARVING,
            "Wood Carving",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village begins shaping wood with intent, unlocking the Woodcarver's Hut.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_WOODWORKING_BENCH
            ]
        ),

        RESEARCH_STONE_WORKING: make_plan(
            RESEARCH_STONE_WORKING,
            "Stone Working",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village begins shaping stone with intent, unlocking the Stoneworker's Hut.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_STONEWORKING_BENCH
            ]
        ),

        RESEARCH_FISHING: make_plan(
            RESEARCH_FISHING,
            "Fishing",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village begins developing fishing knowledge, unlocking the Fishing Hut.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_FISHING_HUT
            ]
        ),

        RESEARCH_GATHERING: make_plan(
            RESEARCH_GATHERING,
            "Gathering",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village improves its understanding of useful plants, fibers, and natural materials, unlocking the Gatherer's Hut.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_GATHERERS_HUT
            ]
        ),

        RESEARCH_RECOGNIZE_FLINT: make_plan(
            RESEARCH_RECOGNIZE_FLINT,
            "Recognize Flint",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village learns to recognize useful flint deposits. This prepares Gatherers to collect Flint and unlocks later flint tool chains.",
            [
                RESEARCH_GATHERING
            ],
            [
                RegionBuildingData.BUILDING_GATHERERS_HUT
            ],
            [],
            [],
            [],
            [
                "flint_gathering_available"
            ]
        ),

        RESEARCH_HUNTING: make_plan(
            RESEARCH_HUNTING,
            "Hunting",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village begins organizing dangerous animal hunting, unlocking the Hunter's Hut.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_HUNTERS_HUT
            ]
        ),

        RESEARCH_SKINNING: make_plan(
            RESEARCH_SKINNING,
            "Skinning",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village learns to recover useful hide from hunted animals. This prepares Hunters to produce Hide and unlocks later hide-based recipes.",
            [
                RESEARCH_HUNTING
            ],
            [
                RegionBuildingData.BUILDING_HUNTERS_HUT
            ],
            [],
            [],
            [],
            [
                "hide_gathering_available"
            ]
        ),

        RESEARCH_DEFEND_THE_PEOPLE: make_plan(
            RESEARCH_DEFEND_THE_PEOPLE,
            "Defend the People",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T2,
            8,
            "The village recognizes that danger must be answered with organization, unlocking the Warleader's Shelter.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [
                RegionBuildingData.BUILDING_WARLEADER_SHELTER
            ]
        ),

        RESEARCH_TO_WAR: make_plan(
            RESEARCH_TO_WAR,
            "To War",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village begins organizing warriors and conflict roles, unlocking the Warrior's Hut.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [
                RegionBuildingData.BUILDING_WARRIOR_HUT
            ]
        ),

        RESEARCH_BONE_CARVING: make_plan(
            RESEARCH_BONE_CARVING,
            "Bone Carving",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village begins using bone as a shaped material, unlocking the Bonecarver's Hut.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [
                RegionBuildingData.BUILDING_BONECARVERS_HUT
            ]
        ),

        RESEARCH_LIGHT_UP_THE_NIGHT: make_plan(
            RESEARCH_LIGHT_UP_THE_NIGHT,
            "Light Up the Night",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T2,
            10,
            "The village builds stronger communal fire practices, unlocking the Bonfire.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [
                RegionBuildingData.BUILDING_BONFIRE
            ]
        ),

        RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE: make_plan(
            RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE,
            "Personal Possessions: Stone Age",
            CATEGORY_BELONGINGS,
            RESEARCH_TIER_STONE_AGE_T3,
            15,
            "The village begins expanding how personal possessions and belongings work in the Stone Age.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [],
            [],
            [
                {
                    "id": BONUS_BELONGING_SLOTS,
                    "name": "Belonging Slots",
                    "amount": BELONGING_SLOT_BONUS_AMOUNT
                }
            ]
        ),

        RESEARCH_TENT_LIFE: make_plan(
            RESEARCH_TENT_LIFE,
            "Tent Life",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T3,
            12,
            "The village develops portable shelter ideas, unlocking normal Tent construction. Tent Kits are unlocked by Tent Kit Assembly.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [
                RegionBuildingData.BUILDING_TENT
            ]
        ),

        RESEARCH_FEAR_OF_THE_DARK: make_plan(
            RESEARCH_FEAR_OF_THE_DARK,
            "Fear of the Dark",
            CATEGORY_RELICS,
            RESEARCH_TIER_STONE_AGE_T3,
            12,
            "The village begins to understand that darkness carries more than animal danger. This is reserved as a future hero/story pressure gateway.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ],
            [],
            [],
            [],
            [],
            [
                "future_story_pressure_gateway"
            ]
        ),

        RESEARCH_TIME_TO_MOVE_ON: make_plan(
            RESEARCH_TIME_TO_MOVE_ON,
            "Time to Move On",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_TRANSITION,
            25,
            "The village prepares to move beyond this region. Later this will unlock the Chieftain's Move On hero-panel option and preserve resources tagged for movement.",
            [
                RESEARCH_TENT_LIFE,
                RESEARCH_DRAG_SLED
            ],
            [],
            [],
            [],
            [],
            [
                "stone_age_transition_available",
                "chieftain_move_region_available"
            ]
        ),

        RESEARCH_TORCH_CRAFTING: make_plan(
            RESEARCH_TORCH_CRAFTING,
            "Torch Crafting",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T1,
            3,
            "The village learns to make personal carried lights.",
            [
                RESEARCH_LEARN_CAMPFIRE
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_TORCH
            ]
        ),

        RESEARCH_BASIC_STONE_TOOLS: make_plan(
            RESEARCH_BASIC_STONE_TOOLS,
            "Basic Stone Tools",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "The village learns to make the earliest simple stone tools at a Making Spot.",
            [],
            [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            [],
            [
                RegionRecipeData.RECIPE_SIMPLE_HAND_AXE,
                RegionRecipeData.RECIPE_SHARP_STONE_KNIFE
            ]
        ),

        RESEARCH_FOOT_WRAPPINGS: make_plan(
            RESEARCH_FOOT_WRAPPINGS,
            "Foot Wrappings",
            CATEGORY_BELONGINGS,
            RESEARCH_TIER_STONE_AGE_T1,
            3,
            "The village learns to wrap feet for rough travel and daily work.",
            [],
            [
                RegionBuildingData.BUILDING_MAKING_SPOT
            ],
            [],
            [
                RegionRecipeData.RECIPE_FOOT_WRAPPING
            ]
        ),

        RESEARCH_WOOD_GATHERING_TOOLS: make_plan(
            RESEARCH_WOOD_GATHERING_TOOLS,
            "Wood Gathering Tools",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops stone hatchets for better wood gathering.",
            [
                RESEARCH_GATHERING,
                RESEARCH_STONE_WORKING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_STONE_HATCHET
            ]
        ),

        RESEARCH_STONE_GATHERING_TOOLS: make_plan(
            RESEARCH_STONE_GATHERING_TOOLS,
            "Stone Gathering Tools",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops stone mauls for better stone gathering.",
            [
                RESEARCH_GATHERING,
                RESEARCH_STONE_WORKING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_STONE_MAUL
            ]
        ),

        RESEARCH_CUTTING_TOOLS: make_plan(
            RESEARCH_CUTTING_TOOLS,
            "Cutting Tools",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops better knives for fiber and reed cutting.",
            [
                RESEARCH_GATHERING,
                RESEARCH_STONE_WORKING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_STONE_KNIFE
            ]
        ),

        RESEARCH_FORAGERS_BASKETRY: make_plan(
            RESEARCH_FORAGERS_BASKETRY,
            "Forager's Basketry",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops twig baskets for gathering light food resources.",
            [
                RESEARCH_GATHERING,
                RESEARCH_WOOD_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_TWIG_BASKET
            ]
        ),

        RESEARCH_FISH_TRAPPING: make_plan(
            RESEARCH_FISH_TRAPPING,
            "Fish Trapping",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops fish traps for organized fishing.",
            [
                RESEARCH_FISHING,
                RESEARCH_WOOD_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FISH_TRAP
            ]
        ),

        RESEARCH_HUNTERS_SLING: make_plan(
            RESEARCH_HUNTERS_SLING,
            "Hunter's Sling",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops a simple ranged hunter weapon.",
            [
                RESEARCH_HUNTING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_SLING
            ]
        ),

        RESEARCH_STONE_SPEAR_COMPONENTS: make_plan(
            RESEARCH_STONE_SPEAR_COMPONENTS,
            "Stone Spear Components",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T2,
            8,
            "The village learns to shape spear heads, spear hafts, and assemble Stone Spears.",
            [
                RESEARCH_HUNTING,
                RESEARCH_STONE_WORKING,
                RESEARCH_WOOD_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_STONE_SPEAR_HEAD,
                RegionRecipeData.RECIPE_WOODEN_SPEAR_HAFT,
                RegionRecipeData.RECIPE_STONE_SPEAR
            ]
        ),

        RESEARCH_HIDE_WRAPS: make_plan(
            RESEARCH_HIDE_WRAPS,
            "Hide Wraps",
            CATEGORY_BELONGINGS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village learns to make protective hide wraps after learning to recover usable hide.",
            [
                RESEARCH_SKINNING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_HIDE_WRAP
            ]
        ),

        RESEARCH_STONE_CLUBS: make_plan(
            RESEARCH_STONE_CLUBS,
            "Stone Clubs",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village develops early melee weapons for warriors.",
            [
                RESEARCH_TO_WAR,
                RESEARCH_STONE_WORKING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_STONE_CLUB
            ]
        ),

        RESEARCH_HIDE_ARMOR: make_plan(
            RESEARCH_HIDE_ARMOR,
            "Hide Armor",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T2,
            8,
            "The village learns to turn hide into basic armor for hunters and warriors.",
            [
                RESEARCH_SKINNING,
                RESEARCH_TO_WAR
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_HIDE_ARMOR
            ]
        ),

        RESEARCH_BONE_CHARMS: make_plan(
            RESEARCH_BONE_CHARMS,
            "Bone Charms",
            CATEGORY_BELONGINGS,
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "The village learns to carve small bone charms for thinkers.",
            [
                RESEARCH_BONE_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_BONE_CHARM
            ]
        ),

        RESEARCH_FLINT_TOOL_COMPONENTS: make_plan(
            RESEARCH_FLINT_TOOL_COMPONENTS,
            "Flint Tool Components",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T3,
            10,
            "The village learns to shape flint axe heads and flint pick heads after learning to recognize useful flint.",
            [
                RESEARCH_RECOGNIZE_FLINT,
                RESEARCH_STONE_WORKING,
                RESEARCH_WOOD_GATHERING_TOOLS,
                RESEARCH_STONE_GATHERING_TOOLS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_AXE_HEAD,
                RegionRecipeData.RECIPE_FLINT_PICK_HEAD
            ]
        ),

        RESEARCH_FLINT_SPEAR_COMPONENTS: make_plan(
            RESEARCH_FLINT_SPEAR_COMPONENTS,
            "Flint Spear Components",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to shape sharper flint spear heads after learning to recognize useful flint.",
            [
                RESEARCH_RECOGNIZE_FLINT,
                RESEARCH_HUNTING,
                RESEARCH_STONE_WORKING,
                RESEARCH_STONE_SPEAR_COMPONENTS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_SPEAR_HEAD
            ]
        ),

        RESEARCH_IMPROVED_HAFTING: make_plan(
            RESEARCH_IMPROVED_HAFTING,
            "Improved Hafting",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T3,
            10,
            "The village learns stronger methods for joining heads, shafts, and handles.",
            [
                RESEARCH_WOOD_CARVING,
                RESEARCH_STONE_SPEAR_COMPONENTS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_TOOL_HAFT
            ]
        ),

        RESEARCH_TENT_FRAMING: make_plan(
            RESEARCH_TENT_FRAMING,
            "Tent Framing",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to build portable tent frames.",
            [
                RESEARCH_TENT_LIFE,
                RESEARCH_WOOD_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_TENT_FRAME
            ]
        ),

        RESEARCH_FLINT_HATCHET: make_plan(
            RESEARCH_FLINT_HATCHET,
            "Flint Hatchet",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to assemble improved flint hatchets.",
            [
                RESEARCH_FLINT_TOOL_COMPONENTS,
                RESEARCH_IMPROVED_HAFTING,
                RESEARCH_WOOD_GATHERING_TOOLS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_HATCHET
            ]
        ),

        RESEARCH_FLINT_PICK: make_plan(
            RESEARCH_FLINT_PICK,
            "Flint Pick",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to assemble improved flint picks.",
            [
                RESEARCH_FLINT_TOOL_COMPONENTS,
                RESEARCH_IMPROVED_HAFTING,
                RESEARCH_STONE_GATHERING_TOOLS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_PICK
            ]
        ),

        RESEARCH_FLINT_TIPPED_HUNTER_SPEAR: make_plan(
            RESEARCH_FLINT_TIPPED_HUNTER_SPEAR,
            "Flint-Tipped Hunter Spear",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to assemble sharper hunter spears.",
            [
                RESEARCH_FLINT_SPEAR_COMPONENTS,
                RESEARCH_IMPROVED_HAFTING,
                RESEARCH_STONE_SPEAR_COMPONENTS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_TIPPED_HUNTER_SPEAR
            ]
        ),

        RESEARCH_FLINT_TIPPED_SPEAR: make_plan(
            RESEARCH_FLINT_TIPPED_SPEAR,
            "Flint-Tipped Spear",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to assemble sharper warrior spears.",
            [
                RESEARCH_FLINT_SPEAR_COMPONENTS,
                RESEARCH_IMPROVED_HAFTING,
                RESEARCH_STONE_CLUBS
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_FLINT_TIPPED_SPEAR
            ]
        ),

        RESEARCH_HIDE_SLING: make_plan(
            RESEARCH_HIDE_SLING,
            "Hide Sling",
            CATEGORY_EQUIPMENT,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village improves hunter slings with hide reinforcement after learning skinning.",
            [
                RESEARCH_SKINNING,
                RESEARCH_HUNTERS_SLING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_HIDE_SLING
            ]
        ),

        RESEARCH_HIDE_POUCH: make_plan(
            RESEARCH_HIDE_POUCH,
            "Hide Pouch",
            CATEGORY_BELONGINGS,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village improves gathering belongings with durable hide pouches after learning skinning.",
            [
                RESEARCH_SKINNING,
                RESEARCH_FORAGERS_BASKETRY
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_HIDE_POUCH
            ]
        ),

        RESEARCH_TENT_KIT_ASSEMBLY: make_plan(
            RESEARCH_TENT_KIT_ASSEMBLY,
            "Tent Kit Assembly",
            CATEGORY_CORE,
            RESEARCH_TIER_STONE_AGE_T3,
            9,
            "The village learns to assemble Tent Kits from Tent Frames, hide, and fiber.",
            [
                RESEARCH_SKINNING,
                RESEARCH_TENT_LIFE,
                RESEARCH_TENT_FRAMING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_TENT_KIT
            ]
        ),

        RESEARCH_DRAG_SLED: make_plan(
            RESEARCH_DRAG_SLED,
            "Drag Sled",
            CATEGORY_TOOLS,
            RESEARCH_TIER_STONE_AGE_TRANSITION,
            12,
            "The village prepares crude transport tools for future moving-camp systems.",
            [
                RESEARCH_TENT_LIFE,
                RESEARCH_WOOD_CARVING
            ],
            [],
            [],
            [
                RegionRecipeData.RECIPE_DRAG_SLED
            ]
        )
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


static func get_research_category(research_id: String) -> String:
    var plan: Dictionary = get_research_plan(research_id)

    if plan.is_empty():
        return CATEGORY_CORE

    return str(plan.get("category", CATEGORY_CORE))
