extends RefCounted
class_name StoneAgeResearchData

# -------------------------------------------------------------------
# Current Stone Age idea / research IDs.
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
const RESEARCH_T1_RANGED_WEAPONS: String = "t1_ranged_weapons"

const RESEARCH_DEFEND_THE_PEOPLE: String = "defend_the_people"
const RESEARCH_TO_WAR: String = "to_war"
const RESEARCH_T2_BELONGINGS: String = "t2_belongings"
const RESEARCH_T1_MELEE_WEAPONS: String = "t1_melee_weapons"
const RESEARCH_T2_RANGED_WEAPONS: String = "t2_ranged_weapons"
const RESEARCH_BONE_CARVING: String = "bone_carving"

const RESEARCH_FEAR_OF_THE_DARK: String = "fear_of_the_dark"
const RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE: String = "personal_possessions_stone_age"
const RESEARCH_TENT_LIFE: String = "tent_life"
const RESEARCH_LIGHT_UP_THE_NIGHT: String = "light_up_the_night"
const RESEARCH_WHISPERS_IN_THE_DARK: String = "whispers_in_the_dark"
const RESEARCH_T2_MELEE_WEAPONS: String = "t2_melee_weapons"

const RESEARCH_STONE_AGE_RITUAL_1: String = "stone_age_ritual_1"
const RESEARCH_STONE_AGE_RITUAL_2: String = "stone_age_ritual_2"
const RESEARCH_STONE_AGE_RITUAL_3: String = "stone_age_ritual_3"

const RESEARCH_TIME_TO_MOVE_ON: String = "time_to_move_on"


# -------------------------------------------------------------------
# Legacy research constants kept for compatibility.
# These are not currently returned in get_all_research_plans().
# -------------------------------------------------------------------

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

const RESEARCH_BONFIRE_PLAN: String = "bonfire_plan"
const RESEARCH_SPIRITUAL_LEADER_TENT_PLAN: String = "spiritual_leader_tent_plan"
const RESEARCH_RITUAL_SITE_PLAN: String = "ritual_site_plan"

const RESEARCH_STONEWORKING_HUT_PLAN: String = "stoneworking_hut_plan"
const RESEARCH_WOODWORKING_HUT_PLAN: String = "woodworking_hut_plan"

const RESEARCH_STONEWORKING_BENCH_PLAN: String = RESEARCH_STONEWORKING_HUT_PLAN
const RESEARCH_WOODWORKING_BENCH_PLAN: String = RESEARCH_WOODWORKING_HUT_PLAN

const RESEARCH_HUNTERS_HUT_PLAN: String = "hunters_hut_plan"
const RESEARCH_FISHING_HUT_PLAN: String = "fishing_hut_plan"
const RESEARCH_WARLEADER_SHELTER_PLAN: String = "warleader_shelter_plan"
const RESEARCH_WARRIOR_HUT_PLAN: String = "warrior_hut_plan"

const RESEARCH_CAMP_PATHS: String = "camp_paths"
const RESEARCH_SHARED_WORK_RHYTHM: String = "shared_work_rhythm"


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

const RECIPE_FLINT_TIPPED_SPEAR: String = RECIPE_FLINT_TIPPED_HUNTING_SPEAR


# -------------------------------------------------------------------
# Resource / bonus constants kept for compatibility.
# -------------------------------------------------------------------

const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FISH_NAME: String = "Fish"

const GLOBAL_BONUS_SMALL_AMOUNT: float = 0.02
const BELONGING_SLOT_BONUS_AMOUNT: int = 1


static func make_plan(
    research_id: String,
    research_name: String,
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

        RESEARCH_HUNTING: make_plan(
            RESEARCH_HUNTING,
            "Hunting",
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

        RESEARCH_T1_RANGED_WEAPONS: make_plan(
            RESEARCH_T1_RANGED_WEAPONS,
            "T1 Ranged Weapons",
            RESEARCH_TIER_STONE_AGE_T1,
            4,
            "Placeholder for future Tier 1 ranged weapon recipe unlocks.",
            [
                RESEARCH_WE_NEED_A_LEADER
            ]
        ),

        RESEARCH_DEFEND_THE_PEOPLE: make_plan(
            RESEARCH_DEFEND_THE_PEOPLE,
            "Defend the People",
            RESEARCH_TIER_STONE_AGE_T2,
            8,
            "The village recognizes that danger must be answered with organization, unlocking the Warleader's Camp.",
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

        RESEARCH_T2_BELONGINGS: make_plan(
            RESEARCH_T2_BELONGINGS,
            "T2 Belongings",
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "Placeholder for future Tier 2 belonging recipe unlocks.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ]
        ),

        RESEARCH_T1_MELEE_WEAPONS: make_plan(
            RESEARCH_T1_MELEE_WEAPONS,
            "T1 Melee Weapons",
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "Placeholder for future Tier 1 melee weapon recipe unlocks.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ]
        ),

        RESEARCH_T2_RANGED_WEAPONS: make_plan(
            RESEARCH_T2_RANGED_WEAPONS,
            "T2 Ranged Weapons",
            RESEARCH_TIER_STONE_AGE_T2,
            6,
            "Placeholder for future Tier 2 ranged weapon recipe unlocks.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ]
        ),

        RESEARCH_BONE_CARVING: make_plan(
            RESEARCH_BONE_CARVING,
            "Bone Carving",
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

        RESEARCH_FEAR_OF_THE_DARK: make_plan(
            RESEARCH_FEAR_OF_THE_DARK,
            "Fear of the Dark",
            RESEARCH_TIER_STONE_AGE_T3,
            12,
            "The village begins to explain and organize its fear of the dark, unlocking the Spiritual Leader's Hut.",
            [
                RESEARCH_DEFEND_THE_PEOPLE
            ],
            [],
            [
                RegionBuildingData.BUILDING_SPIRITUAL_LEADER_HUT
            ]
        ),

        RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE: make_plan(
            RESEARCH_PERSONAL_POSSESSIONS_STONE_AGE,
            "Personal Possessions: Stone Age",
            RESEARCH_TIER_STONE_AGE_T3,
            15,
            "The village begins expanding how personal possessions and belongings work in the Stone Age.",
            [
                RESEARCH_FEAR_OF_THE_DARK
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
            RESEARCH_TIER_STONE_AGE_T3,
            12,
            "The village develops portable shelter ideas, unlocking tents and the Tent Kit recipe.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ],
            [],
            [
                RegionBuildingData.BUILDING_TENT,
               
            ],
            [
                RECIPE_TENT_KIT
            ]
        ),

        RESEARCH_LIGHT_UP_THE_NIGHT: make_plan(
            RESEARCH_LIGHT_UP_THE_NIGHT,
            "Light Up the Night",
            RESEARCH_TIER_STONE_AGE_T3,
            10,
            "The village begins learning stronger ways to hold back the dark, unlocking the Bonfire.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ],
            [],
            [
                RegionBuildingData.BUILDING_BONFIRE
            ]
        ),

        RESEARCH_WHISPERS_IN_THE_DARK: make_plan(
            RESEARCH_WHISPERS_IN_THE_DARK,
            "Whispers in the Dark",
            RESEARCH_TIER_STONE_AGE_T3,
            15,
            "The village begins hearing meaning in the dark, unlocking the Ritual Site.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ],
            [],
            [
                RegionBuildingData.BUILDING_RITUAL_SITE
            ]
        ),

        RESEARCH_T2_MELEE_WEAPONS: make_plan(
            RESEARCH_T2_MELEE_WEAPONS,
            "T2 Melee Weapons",
            RESEARCH_TIER_STONE_AGE_T3,
            10,
            "Placeholder for future Tier 2 melee weapon recipe unlocks.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ]
        ),

        RESEARCH_STONE_AGE_RITUAL_1: make_plan(
            RESEARCH_STONE_AGE_RITUAL_1,
            "Stone Age Ritual Placeholder I",
            RESEARCH_TIER_STONE_AGE_T3,
            20,
            "Placeholder for a future Stone Age ritual research.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ]
        ),

        RESEARCH_STONE_AGE_RITUAL_2: make_plan(
            RESEARCH_STONE_AGE_RITUAL_2,
            "Stone Age Ritual Placeholder II",
            RESEARCH_TIER_STONE_AGE_T3,
            20,
            "Placeholder for a future Stone Age ritual research.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ]
        ),

        RESEARCH_STONE_AGE_RITUAL_3: make_plan(
            RESEARCH_STONE_AGE_RITUAL_3,
            "Stone Age Ritual Placeholder III",
            RESEARCH_TIER_STONE_AGE_T3,
            20,
            "Placeholder for a future Stone Age ritual research.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ]
        ),

        RESEARCH_TIME_TO_MOVE_ON: make_plan(
            RESEARCH_TIME_TO_MOVE_ON,
            "Time to Move On",
            RESEARCH_TIER_STONE_AGE_TRANSITION,
            25,
            "The village prepares to move beyond this region. Later this will unlock the Chieftain's Move On hero-panel option and preserve resources tagged for movement.",
            [
                RESEARCH_FEAR_OF_THE_DARK
            ],
            [],
            [],
            [],
            [],
            [
                "stone_age_transition_available",
                "chieftain_move_region_available"
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
