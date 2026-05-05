extends RefCounted
class_name StoneAgeRecipeData

# -------------------------------------------------------------------
# Active Stone Age recipe constants.
# Raw Resources -> Components -> Finished Items
# -------------------------------------------------------------------

# T1 recipes
const RECIPE_TORCH: String = "torch"
const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_FOOT_WRAPPING: String = "foot_wrapping"

# T2 recipes
const RECIPE_STONE_HATCHET: String = "stone_hatchet"
const RECIPE_STONE_MAUL: String = "stone_maul"
const RECIPE_STONE_KNIFE: String = "stone_knife"
const RECIPE_TWIG_BASKET: String = "twig_basket"
const RECIPE_FISH_TRAP: String = "fish_trap"
const RECIPE_SLING: String = "sling"
const RECIPE_STONE_SPEAR_HEAD: String = "stone_spear_head"
const RECIPE_WOODEN_SPEAR_HAFT: String = "wooden_spear_haft"
const RECIPE_STONE_SPEAR: String = "stone_spear"
const RECIPE_HIDE_WRAP: String = "hide_wrap"
const RECIPE_STONE_CLUB: String = "stone_club"
const RECIPE_HIDE_ARMOR: String = "hide_armor"
const RECIPE_BONE_CHARM: String = "bone_charm"

# T3 component recipes
const RECIPE_FLINT_AXE_HEAD: String = "flint_axe_head"
const RECIPE_FLINT_PICK_HEAD: String = "flint_pick_head"
const RECIPE_FLINT_SPEAR_HEAD: String = "flint_spear_head"
const RECIPE_TOOL_HAFT: String = "tool_haft"
const RECIPE_TENT_FRAME: String = "tent_frame"

# T3 finished recipes
const RECIPE_FLINT_HATCHET: String = "flint_hatchet"
const RECIPE_FLINT_PICK: String = "flint_pick"
const RECIPE_FLINT_TIPPED_HUNTER_SPEAR: String = "flint_tipped_hunter_spear"
const RECIPE_FLINT_TIPPED_SPEAR: String = "flint_tipped_spear"
const RECIPE_HIDE_SLING: String = "hide_sling"
const RECIPE_HIDE_POUCH: String = "hide_pouch"
const RECIPE_TENT_KIT: String = "tent_kit"
const RECIPE_DRAG_SLED: String = "drag_sled"


# -------------------------------------------------------------------
# Active Stone Age item constants.
# -------------------------------------------------------------------

# T1 items
const ITEM_TORCH: String = "torch"
const ITEM_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const ITEM_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const ITEM_FOOT_WRAPPING: String = "foot_wrapping"

# T2 items
const ITEM_STONE_HATCHET: String = "stone_hatchet"
const ITEM_STONE_MAUL: String = "stone_maul"
const ITEM_STONE_KNIFE: String = "stone_knife"
const ITEM_TWIG_BASKET: String = "twig_basket"
const ITEM_FISH_TRAP: String = "fish_trap"
const ITEM_SLING: String = "sling"
const ITEM_STONE_SPEAR_HEAD: String = "stone_spear_head"
const ITEM_WOODEN_SPEAR_HAFT: String = "wooden_spear_haft"
const ITEM_STONE_SPEAR: String = "stone_spear"
const ITEM_HIDE_WRAP: String = "hide_wrap"
const ITEM_STONE_CLUB: String = "stone_club"
const ITEM_HIDE_ARMOR: String = "hide_armor"
const ITEM_BONE_CHARM: String = "bone_charm"

# T3 component items
const ITEM_FLINT_AXE_HEAD: String = "flint_axe_head"
const ITEM_FLINT_PICK_HEAD: String = "flint_pick_head"
const ITEM_FLINT_SPEAR_HEAD: String = "flint_spear_head"
const ITEM_TOOL_HAFT: String = "tool_haft"
const ITEM_TENT_FRAME: String = "tent_frame"

# T3 finished items
const ITEM_FLINT_HATCHET: String = "flint_hatchet"
const ITEM_FLINT_PICK: String = "flint_pick"
const ITEM_FLINT_TIPPED_HUNTER_SPEAR: String = "flint_tipped_hunter_spear"
const ITEM_FLINT_TIPPED_SPEAR: String = "flint_tipped_spear"
const ITEM_HIDE_SLING: String = "hide_sling"
const ITEM_HIDE_POUCH: String = "hide_pouch"
const ITEM_TENT_KIT: String = "tent_kit"
const ITEM_DRAG_SLED: String = "drag_sled"


# -------------------------------------------------------------------
# Legacy/removed recipe constants kept so older references do not break.
# These are not returned in get_all_recipes().
# -------------------------------------------------------------------

const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_STONE_SCRAPER: String = "stone_scraper"
const RECIPE_ADVANCED_SLING: String = "advanced_sling"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"
const RECIPE_CLOTH_SHOES: String = "cloth_shoes"
const RECIPE_WOVEN_POUCH: String = "woven_pouch"
const RECIPE_WARM_WRAP: String = "warm_wrap"
const RECIPE_THROWING_SPEAR: String = "throwing_spear"
const RECIPE_STONE_TIPPED_SPEAR: String = RECIPE_STONE_SPEAR
const RECIPE_STONE_BATTLE_AXE: String = "stone_battle_axe"
const RECIPE_WORKED_HAND_AXE: String = "worked_hand_axe"
const RECIPE_CARRY_SLING: String = "carry_sling"
const RECIPE_HAMMER_STONE: String = "hammer_stone"
const RECIPE_STONE_CHISEL: String = "stone_chisel"
const RECIPE_WOOD_SHAPING_ADZE: String = "wood_shaping_adze"
const RECIPE_WOODEN_MALLET: String = "wooden_mallet"
const RECIPE_SMOOTHING_STONE: String = "smoothing_stone"
const RECIPE_FLINT_TIPPED_HUNTING_SPEAR: String = RECIPE_FLINT_TIPPED_HUNTER_SPEAR
const RECIPE_FLINT_EDGED_HAND_AXE: String = RECIPE_FLINT_HATCHET
const RECIPE_FLINT_EDGED_WOODSMAN_AXE: String = RECIPE_FLINT_HATCHET
const RECIPE_FLINT_TIPPED_MINING_PICK: String = RECIPE_FLINT_PICK
const RECIPE_FLINT_BATTLE_AXE: String = "flint_battle_axe"
const RECIPE_FLINT_CHISEL: String = "flint_chisel"


# -------------------------------------------------------------------
# Legacy/removed item constants kept so older references do not break.
# -------------------------------------------------------------------

const ITEM_POINTED_STICK: String = "pointed_stick"
const ITEM_STONE_SCRAPER: String = "stone_scraper"
const ITEM_ADVANCED_SLING: String = "advanced_sling"
const ITEM_CRUDE_CONTAINER: String = "crude_container"
const ITEM_HERBAL_POULTICE: String = "herbal_poultice"
const ITEM_CLOTH_SHOES: String = ITEM_FOOT_WRAPPING
const ITEM_WOVEN_POUCH: String = "woven_pouch"
const ITEM_WARM_WRAP: String = "warm_wrap"
const ITEM_THROWING_SPEAR: String = "throwing_spear"
const ITEM_STONE_TIPPED_SPEAR: String = ITEM_STONE_SPEAR
const ITEM_STONE_BATTLE_AXE: String = "stone_battle_axe"
const ITEM_WORKED_HAND_AXE: String = "worked_hand_axe"
const ITEM_CARRY_SLING: String = "carry_sling"
const ITEM_HAMMER_STONE: String = "hammer_stone"
const ITEM_STONE_CHISEL: String = "stone_chisel"
const ITEM_WOOD_SHAPING_ADZE: String = "wood_shaping_adze"
const ITEM_WOODEN_MALLET: String = "wooden_mallet"
const ITEM_SMOOTHING_STONE: String = "smoothing_stone"
const ITEM_FLINT_TIPPED_HUNTING_SPEAR: String = ITEM_FLINT_TIPPED_HUNTER_SPEAR
const ITEM_FLINT_EDGED_HAND_AXE: String = ITEM_FLINT_HATCHET
const ITEM_FLINT_EDGED_WOODSMAN_AXE: String = ITEM_FLINT_HATCHET
const ITEM_FLINT_TIPPED_MINING_PICK: String = ITEM_FLINT_PICK
const ITEM_FLINT_BATTLE_AXE: String = "flint_battle_axe"
const ITEM_FLINT_CHISEL: String = "flint_chisel"


# -------------------------------------------------------------------
# Resource constants.
# -------------------------------------------------------------------

const RESOURCE_WOOD_NAME: String = "Wood"
const RESOURCE_STONE_NAME: String = "Stone"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"
const RESOURCE_REEDS_NAME: String = "Reeds"
const RESOURCE_HIDE_NAME: String = "Hide"
const RESOURCE_BONE_NAME: String = "Bone"


# -------------------------------------------------------------------
# Crafting/item metadata constants.
# -------------------------------------------------------------------

const CRAFTING_TIER_STONE_AGE_T1: String = StoneAgeTuning.CRAFTING_TIER_1
const CRAFTING_TIER_STONE_AGE_T2: String = StoneAgeTuning.CRAFTING_TIER_2
const CRAFTING_TIER_STONE_AGE_T3: String = StoneAgeTuning.CRAFTING_TIER_3

const OUTPUT_TYPE_ITEM: String = "item"

const ITEM_FUNCTION_COMPONENT: String = "component"
const ITEM_FUNCTION_BASIC_TOOL: String = StoneAgeTuning.ITEM_FUNCTION_BASIC_TOOL
const ITEM_FUNCTION_TOOL_BONUS: String = StoneAgeTuning.ITEM_FUNCTION_TOOL_BONUS
const ITEM_FUNCTION_WEAPON_STATS: String = StoneAgeTuning.ITEM_FUNCTION_WEAPON_STATS
const ITEM_FUNCTION_ARMOR_STATS: String = StoneAgeTuning.ITEM_FUNCTION_ARMOR_STATS
const ITEM_FUNCTION_CONSUMABLE_EFFECT: String = StoneAgeTuning.ITEM_FUNCTION_CONSUMABLE_EFFECT
const ITEM_FUNCTION_BUILDING_COST_ITEM: String = StoneAgeTuning.ITEM_FUNCTION_BUILDING_COST_ITEM
const ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT: String = StoneAgeTuning.ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT
const ITEM_FUNCTION_STORAGE_BELONGING: String = StoneAgeTuning.ITEM_FUNCTION_STORAGE_BELONGING
const ITEM_FUNCTION_PREPARATION_TOOL: String = StoneAgeTuning.ITEM_FUNCTION_PREPARATION_TOOL
const ITEM_FUNCTION_SPEED_BELONGING: String = StoneAgeTuning.ITEM_FUNCTION_SPEED_BELONGING
const ITEM_FUNCTION_ROLE_BELONGING: String = StoneAgeTuning.ITEM_FUNCTION_ROLE_BELONGING

const DEFAULT_CRAFT_TIME: float = StoneAgeTuning.DEFAULT_CRAFT_TIME


static func make_item_output(
    item_id: String,
    item_name: String,
    amount: int,
    category: String,
    item_function: String,
    role_tags: Array = [],
    skill_tags: Array = [],
    effect_notes: String = "",
    description: String = ""
) -> Dictionary:
    return {
        "type": OUTPUT_TYPE_ITEM,
        "id": item_id,
        "name": item_name,
        "amount": amount,
        "category": category,
        "item_function": item_function,
        "role_tags": role_tags.duplicate(true),
        "skill_tags": skill_tags.duplicate(true),
        "effect_notes": effect_notes,
        "description": description
    }


static func make_recipe(
    recipe_id: String,
    recipe_name: String,
    tier: String,
    description: String,
    required_building: String,
    required_recipe_unlock: String,
    skill: String,
    craft_time: float,
    cost: Dictionary,
    outputs: Array,
    item_cost: Dictionary = {}
) -> Dictionary:
    return {
        "id": recipe_id,
        "name": recipe_name,
        "tier": tier,
        "description": description,
        "required_building": required_building,
        "required_recipe_unlock": required_recipe_unlock,
        "skill": skill,
        "craft_time": craft_time,
        "cost": cost.duplicate(true),
        "item_cost": item_cost.duplicate(true),
        "outputs": outputs.duplicate(true)
    }


static func get_all_recipes() -> Dictionary:
    return {
        RECIPE_TORCH: make_recipe(
            RECIPE_TORCH,
            "Torch",
            CRAFTING_TIER_STONE_AGE_T1,
            "A simple carried light source. It grants a small personal protection/light radius when equipped as a belonging.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_TORCH,
            VillagerManager.SKILL_CRAFTING,
            8.0,
            {
                RESOURCE_WOOD_NAME: 1,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_TORCH,
                    "Torch",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_ROLE_BELONGING,
                    [],
                    [],
                    "Belonging. Personal protection/light radius 0.25. No fuel cost once crafted/equipped.",
                    "A simple torch used to push back darkness around one villager."
                )
            ]
        ),

        RECIPE_SIMPLE_HAND_AXE: make_recipe(
            RECIPE_SIMPLE_HAND_AXE,
            "Simple Hand Axe",
            CRAFTING_TIER_STONE_AGE_T1,
            "A crude early camp tool for chopping, scraping, and rough work.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_SIMPLE_HAND_AXE,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_STONE_NAME: 2,
                RESOURCE_WOOD_NAME: 1
            },
            [
                make_item_output(
                    ITEM_SIMPLE_HAND_AXE,
                    "Simple Hand Axe",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_BASIC_TOOL,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "Basic early camp tool.",
                    "A crude stone chopping tool."
                )
            ]
        ),

        RECIPE_SHARP_STONE_KNIFE: make_recipe(
            RECIPE_SHARP_STONE_KNIFE,
            "Sharp Stone Knife",
            CRAFTING_TIER_STONE_AGE_T1,
            "A crude cutting and preparation tool.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_SHARP_STONE_KNIFE,
            VillagerManager.SKILL_CRAFTING,
            10.0,
            {
                RESOURCE_FLINT_NAME: 1,
                RESOURCE_WOOD_NAME: 1
            },
            [
                make_item_output(
                    ITEM_SHARP_STONE_KNIFE,
                    "Sharp Stone Knife",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_PREPARATION_TOOL,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Preparation tool for cutting, scraping, hide work, and fiber work.",
                    "A small stone blade for cutting and preparation."
                )
            ]
        ),

        RECIPE_FOOT_WRAPPING: make_recipe(
            RECIPE_FOOT_WRAPPING,
            "Foot Wrapping",
            CRAFTING_TIER_STONE_AGE_T1,
            "Simple fiber wrappings that make rough walking easier.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_FOOT_WRAPPING,
            VillagerManager.SKILL_CRAFTING,
            10.0,
            {
                RESOURCE_FIBER_NAME: 4
            },
            [
                make_item_output(
                    ITEM_FOOT_WRAPPING,
                    "Foot Wrapping",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_SPEED_BELONGING,
                    [],
                    [],
                    "Belonging. Future movement/speed bonus.",
                    "Simple foot wraps that help villagers move over rough ground."
                )
            ]
        ),

        RECIPE_STONE_HATCHET: make_recipe(
            RECIPE_STONE_HATCHET,
            "Stone Hatchet",
            CRAFTING_TIER_STONE_AGE_T2,
            "A rough stone hatchet for organized wood gathering.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_STONE_HATCHET,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_STONE_NAME: 3,
                RESOURCE_WOOD_NAME: 1,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_STONE_HATCHET,
                    "Stone Hatchet",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_TOOL_BONUS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Gatherer tool. Intended bonus to Wood gathering.",
                    "A rough stone hatchet for gathering wood."
                )
            ]
        ),

        RECIPE_STONE_MAUL: make_recipe(
            RECIPE_STONE_MAUL,
            "Stone Maul",
            CRAFTING_TIER_STONE_AGE_T2,
            "A heavy stone tool for breaking and hauling stone.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_STONE_MAUL,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_STONE_NAME: 4,
                RESOURCE_WOOD_NAME: 1
            },
            [
                make_item_output(
                    ITEM_STONE_MAUL,
                    "Stone Maul",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_TOOL_BONUS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER,
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_MINING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Gatherer tool. Intended bonus to Stone gathering.",
                    "A heavy stone maul for gathering and breaking stone."
                )
            ]
        ),

        RECIPE_STONE_KNIFE: make_recipe(
            RECIPE_STONE_KNIFE,
            "Stone Knife",
            CRAFTING_TIER_STONE_AGE_T2,
            "A more reliable stone cutting tool for fiber and reeds gathering.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_STONE_KNIFE,
            VillagerManager.SKILL_STONEWORKING,
            12.0,
            {
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FLINT_NAME: 1,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_STONE_KNIFE,
                    "Stone Knife",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_PREPARATION_TOOL,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER,
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_GATHERING,
                        VillagerManager.SKILL_CRAFTING
                    ],
                    "Gatherer tool. Intended bonus to Fiber and Reeds gathering.",
                    "A sturdy stone knife for cutting useful plant material."
                )
            ]
        ),

        RECIPE_TWIG_BASKET: make_recipe(
            RECIPE_TWIG_BASKET,
            "Twig Basket",
            CRAFTING_TIER_STONE_AGE_T2,
            "A simple basket for carrying gathered food and light materials.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_TWIG_BASKET,
            VillagerManager.SKILL_WOODWORKING,
            12.0,
            {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_FIBER_NAME: 3
            },
            [
                make_item_output(
                    ITEM_TWIG_BASKET,
                    "Twig Basket",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_STORAGE_BELONGING,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER
                    ],
                    [
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Gatherer tool/belonging. Intended bonus to Berries and Mushrooms gathering.",
                    "A light woven basket for gathered food."
                )
            ]
        ),

        RECIPE_FISH_TRAP: make_recipe(
            RECIPE_FISH_TRAP,
            "Fish Trap",
            CRAFTING_TIER_STONE_AGE_T2,
            "A woven trap for catching fish in shallow water.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_FISH_TRAP,
            VillagerManager.SKILL_WOODWORKING,
            14.0,
            {
                RESOURCE_REEDS_NAME: 4,
                RESOURCE_FIBER_NAME: 2,
                RESOURCE_WOOD_NAME: 1
            },
            [
                make_item_output(
                    ITEM_FISH_TRAP,
                    "Fish Trap",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_TOOL_BONUS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_FISHER,
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER
                    ],
                    [
                        VillagerManager.SKILL_GATHERING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "Fishing tool. Intended support for Fish gathering.",
                    "A simple trap for catching fish."
                )
            ]
        ),

        RECIPE_SLING: make_recipe(
            RECIPE_SLING,
            "Sling",
            CRAFTING_TIER_STONE_AGE_T2,
            "A simple corded ranged weapon for hunters.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_SLING,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_FIBER_NAME: 3,
                RESOURCE_STONE_NAME: 1
            },
            [
                make_item_output(
                    ITEM_SLING,
                    "Sling",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_RANGED_WEAPONS
                    ],
                    "Hunter ranged weapon. Lower damage than Stone Spear, but should reduce hunter injury chance.",
                    "A simple ranged hunting weapon."
                )
            ]
        ),

        RECIPE_STONE_SPEAR_HEAD: make_recipe(
            RECIPE_STONE_SPEAR_HEAD,
            "Stone Spear Head",
            CRAFTING_TIER_STONE_AGE_T2,
            "A shaped stone point used to assemble a Stone Spear.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_STONE_SPEAR_HEAD,
            VillagerManager.SKILL_STONEWORKING,
            10.0,
            {
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FLINT_NAME: 1
            },
            [
                make_item_output(
                    ITEM_STONE_SPEAR_HEAD,
                    "Stone Spear Head",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "Component for Stone Spear.",
                    "A shaped stone spear point."
                )
            ]
        ),

        RECIPE_WOODEN_SPEAR_HAFT: make_recipe(
            RECIPE_WOODEN_SPEAR_HAFT,
            "Wooden Spear Haft",
            CRAFTING_TIER_STONE_AGE_T2,
            "A worked wooden shaft used to assemble spears.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_WOODEN_SPEAR_HAFT,
            VillagerManager.SKILL_WOODWORKING,
            10.0,
            {
                RESOURCE_WOOD_NAME: 3,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_WOODEN_SPEAR_HAFT,
                    "Wooden Spear Haft",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "Component for Stone Spear and flint-tipped spears.",
                    "A worked wooden spear shaft."
                )
            ]
        ),

        RECIPE_STONE_SPEAR: make_recipe(
            RECIPE_STONE_SPEAR,
            "Stone Spear",
            CRAFTING_TIER_STONE_AGE_T2,
            "A hunting spear assembled from a stone head and wooden haft.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_STONE_SPEAR,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {},
            [
                make_item_output(
                    ITEM_STONE_SPEAR,
                    "Stone Spear",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "Hunter melee weapon. Higher damage than Sling, but no injury-chance reduction.",
                    "A basic stone-headed hunting spear."
                )
            ],
            {
                ITEM_STONE_SPEAR_HEAD: 1,
                ITEM_WOODEN_SPEAR_HAFT: 1
            }
        ),

        RECIPE_HIDE_WRAP: make_recipe(
            RECIPE_HIDE_WRAP,
            "Hide Wrap",
            CRAFTING_TIER_STONE_AGE_T2,
            "A simple hide wrap that helps protect against exposure.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_HIDE_WRAP,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_HIDE_NAME: 2,
                RESOURCE_FIBER_NAME: 2
            },
            [
                make_item_output(
                    ITEM_HIDE_WRAP,
                    "Hide Wrap",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_ROLE_BELONGING,
                    [],
                    [],
                    "Belonging. Lowers sickness risk by 5%.",
                    "A simple protective hide wrap."
                )
            ]
        ),

        RECIPE_STONE_CLUB: make_recipe(
            RECIPE_STONE_CLUB,
            "Stone Club",
            CRAFTING_TIER_STONE_AGE_T2,
            "A heavy stone-reinforced club for warriors.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_STONE_CLUB,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_STONE_NAME: 2
            },
            [
                make_item_output(
                    ITEM_STONE_CLUB,
                    "Stone Club",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    [
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "Warrior weapon. Early melee weapon.",
                    "A simple heavy warrior weapon."
                )
            ]
        ),

        RECIPE_HIDE_ARMOR: make_recipe(
            RECIPE_HIDE_ARMOR,
            "Hide Armor",
            CRAFTING_TIER_STONE_AGE_T2,
            "Basic protective armor made from animal hide and fiber lashings.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_HIDE_ARMOR,
            VillagerManager.SKILL_CRAFTING,
            24.0,
            {
                RESOURCE_HIDE_NAME: 4,
                RESOURCE_FIBER_NAME: 3
            },
            [
                make_item_output(
                    ITEM_HIDE_ARMOR,
                    "Hide Armor",
                    1,
                    RegionItemInventory.CATEGORY_ARMOR,
                    ITEM_FUNCTION_ARMOR_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER,
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    [
                        VillagerManager.SKILL_EVADE,
                        VillagerManager.SKILL_PARRY
                    ],
                    "Armor for Hunters and Warriors. No later Stone Age armor upgrade planned.",
                    "Basic hide protection."
                )
            ]
        ),

        RECIPE_BONE_CHARM: make_recipe(
            RECIPE_BONE_CHARM,
            "Bone Charm",
            CRAFTING_TIER_STONE_AGE_T2,
            "A symbolic bone charm carried by a Thinker.",
            RegionBuildingData.BUILDING_BONECARVERS_HUT,
            RECIPE_BONE_CHARM,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_BONE_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_BONE_CHARM,
                    "Bone Charm",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_ROLE_BELONGING,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_THINKER
                    ],
                    [
                        VillagerManager.SKILL_THINKING
                    ],
                    "Belonging. Adds +0.25 Ideas per 30 seconds to a Thinker's normal research gain.",
                    "A small charm used by a Thinker."
                )
            ]
        ),

        RECIPE_FLINT_AXE_HEAD: make_recipe(
            RECIPE_FLINT_AXE_HEAD,
            "Flint Axe Head",
            CRAFTING_TIER_STONE_AGE_T3,
            "A sharp flint axe head used for improved hatchets.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_FLINT_AXE_HEAD,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_FLINT_NAME: 3,
                RESOURCE_STONE_NAME: 1
            },
            [
                make_item_output(
                    ITEM_FLINT_AXE_HEAD,
                    "Flint Axe Head",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "Component for Flint Hatchet.",
                    "A sharpened flint axe head."
                )
            ]
        ),

        RECIPE_FLINT_PICK_HEAD: make_recipe(
            RECIPE_FLINT_PICK_HEAD,
            "Flint Pick Head",
            CRAFTING_TIER_STONE_AGE_T3,
            "A strong flint pick head used for improved stone gathering tools.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_FLINT_PICK_HEAD,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_FLINT_NAME: 3,
                RESOURCE_STONE_NAME: 1
            },
            [
                make_item_output(
                    ITEM_FLINT_PICK_HEAD,
                    "Flint Pick Head",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "Component for Flint Pick.",
                    "A shaped flint pick head."
                )
            ]
        ),

        RECIPE_FLINT_SPEAR_HEAD: make_recipe(
            RECIPE_FLINT_SPEAR_HEAD,
            "Flint Spear Head",
            CRAFTING_TIER_STONE_AGE_T3,
            "A sharper spear head for advanced hunter and warrior spears.",
            RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            RECIPE_FLINT_SPEAR_HEAD,
            VillagerManager.SKILL_STONEWORKING,
            14.0,
            {
                RESOURCE_FLINT_NAME: 3,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_FLINT_SPEAR_HEAD,
                    "Flint Spear Head",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "Component for flint-tipped spears.",
                    "A sharp flint spear point."
                )
            ]
        ),

        RECIPE_TOOL_HAFT: make_recipe(
            RECIPE_TOOL_HAFT,
            "Tool Haft",
            CRAFTING_TIER_STONE_AGE_T3,
            "A sturdy worked handle for improved tools.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_TOOL_HAFT,
            VillagerManager.SKILL_WOODWORKING,
            12.0,
            {
                RESOURCE_WOOD_NAME: 3,
                RESOURCE_FIBER_NAME: 1
            },
            [
                make_item_output(
                    ITEM_TOOL_HAFT,
                    "Tool Haft",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "Component for Flint Hatchet and Flint Pick.",
                    "A sturdy handle for improved tools."
                )
            ]
        ),

        RECIPE_TENT_FRAME: make_recipe(
            RECIPE_TENT_FRAME,
            "Tent Frame",
            CRAFTING_TIER_STONE_AGE_T3,
            "A portable frame used to assemble Tent Kits.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_TENT_FRAME,
            VillagerManager.SKILL_WOODWORKING,
            14.0,
            {
                RESOURCE_WOOD_NAME: 6,
                RESOURCE_FIBER_NAME: 2
            },
            [
                make_item_output(
                    ITEM_TENT_FRAME,
                    "Tent Frame",
                    1,
                    RegionItemInventory.CATEGORY_MATERIAL,
                    ITEM_FUNCTION_COMPONENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "Component for Tent Kit.",
                    "A portable wooden frame for a tent."
                )
            ]
        ),

        RECIPE_FLINT_HATCHET: make_recipe(
            RECIPE_FLINT_HATCHET,
            "Flint Hatchet",
            CRAFTING_TIER_STONE_AGE_T3,
            "An improved wood-gathering tool assembled from a flint axe head and tool haft.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_FLINT_HATCHET,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {},
            [
                make_item_output(
                    ITEM_FLINT_HATCHET,
                    "Flint Hatchet",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_TOOL_BONUS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Gatherer tool. Slightly better than Stone Hatchet for Wood gathering.",
                    "An improved flint hatchet."
                )
            ],
            {
                ITEM_FLINT_AXE_HEAD: 1,
                ITEM_TOOL_HAFT: 1
            }
        ),

        RECIPE_FLINT_PICK: make_recipe(
            RECIPE_FLINT_PICK,
            "Flint Pick",
            CRAFTING_TIER_STONE_AGE_T3,
            "An improved stone-gathering tool assembled from a flint pick head and tool haft.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_FLINT_PICK,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {},
            [
                make_item_output(
                    ITEM_FLINT_PICK,
                    "Flint Pick",
                    1,
                    RegionItemInventory.CATEGORY_TOOL,
                    ITEM_FUNCTION_TOOL_BONUS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER,
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    [
                        VillagerManager.SKILL_MINING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Gatherer tool. Slightly better than Stone Maul for Stone gathering.",
                    "An improved flint pick."
                )
            ],
            {
                ITEM_FLINT_PICK_HEAD: 1,
                ITEM_TOOL_HAFT: 1
            }
        ),

        RECIPE_FLINT_TIPPED_HUNTER_SPEAR: make_recipe(
            RECIPE_FLINT_TIPPED_HUNTER_SPEAR,
            "Flint-Tipped Hunter Spear",
            CRAFTING_TIER_STONE_AGE_T3,
            "An improved hunter spear assembled from a flint spear head and wooden spear haft.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_FLINT_TIPPED_HUNTER_SPEAR,
            VillagerManager.SKILL_CRAFTING,
            14.0,
            {},
            [
                make_item_output(
                    ITEM_FLINT_TIPPED_HUNTER_SPEAR,
                    "Flint-Tipped Hunter Spear",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "Hunter melee weapon. Upgrade to Stone Spear with higher hunt damage/success.",
                    "A sharper spear made for hunters."
                )
            ],
            {
                ITEM_FLINT_SPEAR_HEAD: 1,
                ITEM_WOODEN_SPEAR_HAFT: 1
            }
        ),

        RECIPE_FLINT_TIPPED_SPEAR: make_recipe(
            RECIPE_FLINT_TIPPED_SPEAR,
            "Flint-Tipped Spear",
            CRAFTING_TIER_STONE_AGE_T3,
            "An improved warrior spear assembled from a flint spear head and wooden spear haft.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_FLINT_TIPPED_SPEAR,
            VillagerManager.SKILL_CRAFTING,
            14.0,
            {},
            [
                make_item_output(
                    ITEM_FLINT_TIPPED_SPEAR,
                    "Flint-Tipped Spear",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    [
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "Warrior weapon. Upgrade path from Stone Club into spear fighting.",
                    "A sharper spear made for warriors."
                )
            ],
            {
                ITEM_FLINT_SPEAR_HEAD: 1,
                ITEM_WOODEN_SPEAR_HAFT: 1
            }
        ),

        RECIPE_HIDE_SLING: make_recipe(
            RECIPE_HIDE_SLING,
            "Hide Sling",
            CRAFTING_TIER_STONE_AGE_T3,
            "An improved sling reinforced with hide.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_HIDE_SLING,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_HIDE_NAME: 1,
                RESOURCE_FIBER_NAME: 3,
                RESOURCE_STONE_NAME: 1
            },
            [
                make_item_output(
                    ITEM_HIDE_SLING,
                    "Hide Sling",
                    1,
                    RegionItemInventory.CATEGORY_WEAPON,
                    ITEM_FUNCTION_WEAPON_STATS,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    [
                        VillagerManager.SKILL_RANGED_WEAPONS
                    ],
                    "Hunter ranged weapon. Better injury reduction and/or ranged hunting performance than Sling.",
                    "An improved hunter sling."
                )
            ]
        ),

        RECIPE_HIDE_POUCH: make_recipe(
            RECIPE_HIDE_POUCH,
            "Hide Pouch",
            CRAFTING_TIER_STONE_AGE_T3,
            "A durable hide pouch for carrying gathered materials.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_HIDE_POUCH,
            VillagerManager.SKILL_CRAFTING,
            12.0,
            {
                RESOURCE_HIDE_NAME: 1,
                RESOURCE_FIBER_NAME: 2
            },
            [
                make_item_output(
                    ITEM_HIDE_POUCH,
                    "Hide Pouch",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_STORAGE_BELONGING,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_GATHERER
                    ],
                    [
                        VillagerManager.SKILL_GATHERING
                    ],
                    "Belonging. General gathering speed bonus. Upgrade direction from Twig Basket.",
                    "A durable pouch for gathered materials."
                )
            ]
        ),

        RECIPE_TENT_KIT: make_recipe(
            RECIPE_TENT_KIT,
            "Tent Kit",
            CRAFTING_TIER_STONE_AGE_T3,
            "A bundled kit of frame pieces, hide, and fiber used to build portable tents.",
            RegionBuildingData.BUILDING_MAKING_SPOT,
            RECIPE_TENT_KIT,
            VillagerManager.SKILL_CRAFTING,
            18.0,
            {
                RESOURCE_HIDE_NAME: 4,
                RESOURCE_FIBER_NAME: 6
            },
            [
                make_item_output(
                    ITEM_TENT_KIT,
                    "Tent Kit",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_BUILDING_COST_ITEM,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "Building-cost kit. Consumed to build Tent.",
                    "A portable shelter kit."
                )
            ],
            {
                ITEM_TENT_FRAME: 1
            }
        ),

        RECIPE_DRAG_SLED: make_recipe(
            RECIPE_DRAG_SLED,
            "Drag Sled",
            CRAFTING_TIER_STONE_AGE_T3,
            "A crude sled for later moving-camp and transport systems.",
            RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            RECIPE_DRAG_SLED,
            VillagerManager.SKILL_WOODWORKING,
            18.0,
            {
                RESOURCE_WOOD_NAME: 10,
                RESOURCE_FIBER_NAME: 4
            },
            [
                make_item_output(
                    ITEM_DRAG_SLED,
                    "Drag Sled",
                    1,
                    RegionItemInventory.CATEGORY_KIT,
                    ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT,
                    [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "Transport placeholder. Future camp movement support.",
                    "A crude sled for dragging supplies."
                )
            ]
        )
    }
