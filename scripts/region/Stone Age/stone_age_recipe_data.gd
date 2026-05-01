extends RefCounted
class_name StoneAgeRecipeData

# Legacy/removed recipe constants kept so older references do not break.
const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_STONE_SCRAPER: String = "stone_scraper"
const RECIPE_ADVANCED_SLING: String = "advanced_sling"

const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_SLING: String = "sling"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"
const RECIPE_CLOTH_SHOES: String = "cloth_shoes"
const RECIPE_WOVEN_POUCH: String = "woven_pouch"
const RECIPE_WARM_WRAP: String = "warm_wrap"
const RECIPE_BONE_CHARM: String = "bone_charm"

const RECIPE_THROWING_SPEAR: String = "throwing_spear"
const RECIPE_STONE_TIPPED_SPEAR: String = "stone_tipped_spear"
const RECIPE_STONE_CLUB: String = "stone_club"
const RECIPE_STONE_BATTLE_AXE: String = "stone_battle_axe"
const RECIPE_WORKED_HAND_AXE: String = "worked_hand_axe"
const RECIPE_CARRY_SLING: String = "carry_sling"
const RECIPE_HAMMER_STONE: String = "hammer_stone"
const RECIPE_STONE_CHISEL: String = "stone_chisel"
const RECIPE_WOOD_SHAPING_ADZE: String = "wood_shaping_adze"
const RECIPE_WOODEN_MALLET: String = "wooden_mallet"
const RECIPE_SMOOTHING_STONE: String = "smoothing_stone"
const RECIPE_HIDE_ARMOR: String = "hide_armor"

const RECIPE_DRAG_SLED: String = "drag_sled"
const RECIPE_TENT_KIT: String = "tent_kit"
const RECIPE_FLINT_TIPPED_HUNTING_SPEAR: String = "flint_tipped_hunting_spear"
const RECIPE_FLINT_EDGED_HAND_AXE: String = "flint_edged_hand_axe"
const RECIPE_FLINT_EDGED_WOODSMAN_AXE: String = "flint_edged_woodsman_axe"
const RECIPE_FLINT_TIPPED_MINING_PICK: String = "flint_tipped_mining_pick"
const RECIPE_FLINT_BATTLE_AXE: String = "flint_battle_axe"
const RECIPE_FLINT_CHISEL: String = "flint_chisel"

# Legacy/removed item constants kept so older references do not break.
const ITEM_POINTED_STICK: String = "pointed_stick"
const ITEM_STONE_SCRAPER: String = "stone_scraper"
const ITEM_ADVANCED_SLING: String = "advanced_sling"

const ITEM_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const ITEM_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const ITEM_CRUDE_CONTAINER: String = "crude_container"
const ITEM_SLING: String = "sling"
const ITEM_HERBAL_POULTICE: String = "herbal_poultice"
const ITEM_CLOTH_SHOES: String = "cloth_shoes"
const ITEM_WOVEN_POUCH: String = "woven_pouch"
const ITEM_WARM_WRAP: String = "warm_wrap"
const ITEM_BONE_CHARM: String = "bone_charm"

const ITEM_THROWING_SPEAR: String = "throwing_spear"
const ITEM_STONE_TIPPED_SPEAR: String = "stone_tipped_spear"
const ITEM_STONE_CLUB: String = "stone_club"
const ITEM_STONE_BATTLE_AXE: String = "stone_battle_axe"
const ITEM_WORKED_HAND_AXE: String = "worked_hand_axe"
const ITEM_CARRY_SLING: String = "carry_sling"
const ITEM_HAMMER_STONE: String = "hammer_stone"
const ITEM_STONE_CHISEL: String = "stone_chisel"
const ITEM_WOOD_SHAPING_ADZE: String = "wood_shaping_adze"
const ITEM_WOODEN_MALLET: String = "wooden_mallet"
const ITEM_SMOOTHING_STONE: String = "smoothing_stone"
const ITEM_HIDE_ARMOR: String = "hide_armor"

const ITEM_DRAG_SLED: String = "drag_sled"
const ITEM_TENT_KIT: String = "tent_kit"
const ITEM_FLINT_TIPPED_HUNTING_SPEAR: String = "flint_tipped_hunting_spear"
const ITEM_FLINT_EDGED_HAND_AXE: String = "flint_edged_hand_axe"
const ITEM_FLINT_EDGED_WOODSMAN_AXE: String = "flint_edged_woodsman_axe"
const ITEM_FLINT_TIPPED_MINING_PICK: String = "flint_tipped_mining_pick"
const ITEM_FLINT_BATTLE_AXE: String = "flint_battle_axe"
const ITEM_FLINT_CHISEL: String = "flint_chisel"

const RECIPE_FLINT_TIPPED_SPEAR: String = RECIPE_FLINT_TIPPED_HUNTING_SPEAR
const ITEM_FLINT_TIPPED_SPEAR: String = ITEM_FLINT_TIPPED_HUNTING_SPEAR

const RESOURCE_WOOD_NAME: String = "Wood"
const RESOURCE_STONE_NAME: String = "Stone"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"
const RESOURCE_HIDE_NAME: String = "Hide"

const CRAFTING_TIER_STONE_AGE_T1: String = "stone_age_t1"
const CRAFTING_TIER_STONE_AGE_T2: String = "stone_age_t2"
const CRAFTING_TIER_STONE_AGE_T3: String = "stone_age_t3"

const OUTPUT_TYPE_ITEM: String = "item"

const ITEM_FUNCTION_BASIC_TOOL: String = "basic_tool"
const ITEM_FUNCTION_TOOL_BONUS: String = "tool_bonus"
const ITEM_FUNCTION_WEAPON_STATS: String = "weapon_stats"
const ITEM_FUNCTION_ARMOR_STATS: String = "armor_stats"
const ITEM_FUNCTION_CONSUMABLE_EFFECT: String = "consumable_effect"
const ITEM_FUNCTION_BUILDING_COST_ITEM: String = "building_cost_item"
const ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT: String = "camp_move_requirement"
const ITEM_FUNCTION_STORAGE_BELONGING: String = "storage_belonging"
const ITEM_FUNCTION_PREPARATION_TOOL: String = "preparation_tool"
const ITEM_FUNCTION_SPEED_BELONGING: String = "speed_belonging"
const ITEM_FUNCTION_ROLE_BELONGING: String = "role_belonging"

const DEFAULT_CRAFT_TIME: float = 10.0


static func get_all_recipes() -> Dictionary:
    return {
        RECIPE_SIMPLE_HAND_AXE: {
            "id": RECIPE_SIMPLE_HAND_AXE,
            "name": "Simple Hand Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A crude stone hand tool used for chopping, scraping, and basic camp work.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_SIMPLE_HAND_AXE,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_STONE_NAME: 2,
                RESOURCE_WOOD_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_SIMPLE_HAND_AXE,
                    "name": "Simple Hand Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "effect_notes": "Future tool. Should improve early chopping, rough shaping, basic crafting, woodcutting, or woodworking tasks.",
                    "description": "A crude stone chopping tool. Useful for early woodworking and camp tasks."
                }
            ]
        },

        RECIPE_SHARP_STONE_KNIFE: {
            "id": RECIPE_SHARP_STONE_KNIFE,
            "name": "Sharp Stone Knife",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A crude cutting tool used for fiber, food, hide work, and medicine preparation later.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_SHARP_STONE_KNIFE,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 10.0,
            "cost": {
                RESOURCE_FLINT_NAME: 1,
                RESOURCE_WOOD_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_SHARP_STONE_KNIFE,
                    "name": "Sharp Stone Knife",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_PREPARATION_TOOL,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "effect_notes": "Future preparation tool. Should help with cutting fiber, preparing food, harvesting hide, basic medicine preparation, or small survival tasks.",
                    "description": "A small stone blade. Useful for cutting, scraping, and preparing materials."
                }
            ]
        },

        RECIPE_CRUDE_CONTAINER: {
            "id": RECIPE_CRUDE_CONTAINER,
            "name": "Crude Container",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A simple container made from fiber and wood for future hauling, storage, and villager belonging systems.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_CRUDE_CONTAINER,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 14.0,
            "cost": {
                RESOURCE_FIBER_NAME: 2,
                RESOURCE_WOOD_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_CRUDE_CONTAINER,
                    "name": "Crude Container",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_STORAGE_BELONGING,
                    "role_tags": [],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_GATHERING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "effect_notes": "Future belonging/storage item. Can become a villager belonging that improves carrying, storage interaction, hauling-like behavior, or resource pickup efficiency.",
                    "description": "A simple carrying container. Intended for future hauling and belonging systems."
                }
            ]
        },

        RECIPE_SLING: {
            "id": RECIPE_SLING,
            "name": "Sling",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A simple corded throwing weapon for future hunting and defense systems.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_SLING,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_FIBER_NAME: 3,
                RESOURCE_STONE_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_SLING,
                    "name": "Sling",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_RANGED_WEAPONS
                    ],
                    "effect_notes": "Future hunter weapon. Should provide early ranged attack or hunting bonus, cheaper than spear weapons.",
                    "description": "A corded throwing weapon. Intended for future hunting and early defense systems."
                }
            ]
        },

        RECIPE_HERBAL_POULTICE: {
            "id": RECIPE_HERBAL_POULTICE,
            "name": "Herbal Poultice",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A crude medicine item for future sickness, injury, and recovery systems.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_HERBAL_POULTICE,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_BERRIES_NAME: 2,
                RESOURCE_MUSHROOMS_NAME: 1,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_HERBAL_POULTICE,
                    "name": "Herbal Poultice",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_MEDICINE,
                    "item_function": ITEM_FUNCTION_CONSUMABLE_EFFECT,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "effect_notes": "Temporary medicine item until the Healer role exists. Future consumable medicine for sickness, wounds, infection risk, or recovery speed.",
                    "description": "A crude herbal treatment. Intended for future sickness and injury recovery systems."
                }
            ]
        },

        RECIPE_CLOTH_SHOES: {
            "id": RECIPE_CLOTH_SHOES,
            "name": "Cloth Shoes",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "Simple foot wraps made from fiber. Intended as an early speed belonging.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_CLOTH_SHOES,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 10.0,
            "cost": {
                RESOURCE_FIBER_NAME: 4
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_CLOTH_SHOES,
                    "name": "Cloth Shoes",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_SPEED_BELONGING,
                    "role_tags": [],
                    "skill_tags": [],
                    "effect_notes": "Future belonging item. Should increase villager speed by a small amount, likely +2% to +5%.",
                    "description": "Simple foot wraps that make movement easier over rough ground."
                }
            ]
        },

        RECIPE_WOVEN_POUCH: {
            "id": RECIPE_WOVEN_POUCH,
            "name": "Woven Pouch",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A small fiber pouch used to carry seeds, stones, herbs, or gathered materials.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_WOVEN_POUCH,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 10.0,
            "cost": {
                RESOURCE_FIBER_NAME: 3
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_WOVEN_POUCH,
                    "name": "Woven Pouch",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_STORAGE_BELONGING,
                    "role_tags": [],
                    "skill_tags": [
                        VillagerManager.SKILL_GATHERING
                    ],
                    "effect_notes": "Future belonging item. Should improve gathering, carrying small resources, or personal storage behavior.",
                    "description": "A small woven pouch for carrying gathered materials."
                }
            ]
        },

        RECIPE_WARM_WRAP: {
            "id": RECIPE_WARM_WRAP,
            "name": "Warm Wrap",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A simple wrap made from fiber and soft plant material for protection against cold and exposure.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_WARM_WRAP,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_FIBER_NAME: 5
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_WARM_WRAP,
                    "name": "Warm Wrap",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_ROLE_BELONGING,
                    "role_tags": [],
                    "skill_tags": [],
                    "effect_notes": "Future survival belonging. Should reduce sickness chance, cold exposure, or weather penalties once those systems exist.",
                    "description": "A rough wrap that helps protect a villager from exposure."
                }
            ]
        },

        RECIPE_BONE_CHARM: {
            "id": RECIPE_BONE_CHARM,
            "name": "Bone Charm",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A symbolic charm made from bone or shaped material for early spiritual and morale systems.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_BONE_CHARM,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_STONE_NAME: 1,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_BONE_CHARM,
                    "name": "Bone Charm",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_ROLE_BELONGING,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_THINKER,
                        StoneAgeVillagerAssignmentData.ROLE_RITUALIST
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_THINKING,
                        VillagerManager.SKILL_RITUALS
                    ],
                    "effect_notes": "Future belonging item. Should support thinker, ritualist, morale, faith, or early spiritual systems.",
                    "description": "A small charm used as an early symbol of belief, luck, or memory."
                }
            ]
        },

        RECIPE_THROWING_SPEAR: {
            "id": RECIPE_THROWING_SPEAR,
            "name": "Throwing Spear",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A lighter spear balanced for throwing, intended as the first dedicated hunting and ranged combat weapon.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_THROWING_SPEAR,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 14.0,
            "cost": {
                RESOURCE_WOOD_NAME: 3,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_THROWING_SPEAR,
                    "name": "Throwing Spear",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_RANGED_WEAPONS
                    ],
                    "effect_notes": "Future hunter weapon. Should be a better ranged hunting weapon than sling, useful before flint-tipped hunting spear.",
                    "description": "A light throwing spear. Intended for future Hunter and combat systems."
                }
            ]
        },

        RECIPE_STONE_TIPPED_SPEAR: {
            "id": RECIPE_STONE_TIPPED_SPEAR,
            "name": "Stone-Tipped Spear",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A stronger spear fitted with a worked stone point.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_STONE_TIPPED_SPEAR,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_WOOD_NAME: 3,
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_STONE_TIPPED_SPEAR,
                    "name": "Stone-Tipped Spear",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER,
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_RANGED_WEAPONS,
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "effect_notes": "Future weapon. Should serve as a flexible hunting and melee weapon with better damage than crude wooden weapons.",
                    "description": "A spear with a shaped stone point. Intended for future hunting and basic melee systems."
                }
            ]
        },

        RECIPE_STONE_CLUB: {
            "id": RECIPE_STONE_CLUB,
            "name": "Stone Club",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A heavy club reinforced with stone for early warrior training and close combat.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_STONE_CLUB,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 14.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_STONE_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_STONE_CLUB,
                    "name": "Stone Club",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "effect_notes": "Future warrior weapon. Should support early melee combat, higher impact than spear, but likely no hunting/ranged utility.",
                    "description": "A simple heavy weapon. Intended for future Warrior and combat tutorial systems."
                }
            ]
        },

        RECIPE_STONE_BATTLE_AXE: {
            "id": RECIPE_STONE_BATTLE_AXE,
            "name": "Stone Battle Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A heavier stone-headed axe designed for warriors and close combat.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_STONE_BATTLE_AXE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 18.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_STONE_NAME: 3,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_STONE_BATTLE_AXE,
                    "name": "Stone Battle Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "effect_notes": "Future warrior weapon. Should be stronger than Stone Club, with better attack or damage but possibly slower or less defensive later.",
                    "description": "A stone-headed axe built for close combat."
                }
            ]
        },

        RECIPE_WORKED_HAND_AXE: {
            "id": RECIPE_WORKED_HAND_AXE,
            "name": "Worked Hand Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A more carefully worked hand axe, bridging the simple hand axe and advanced flint-edged axes.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_WORKED_HAND_AXE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_WOOD_NAME: 1,
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_WORKED_HAND_AXE,
                    "name": "Worked Hand Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "effect_notes": "Future improved tool. Should outperform simple hand axe for general camp work, chopping, shaping, and early building support.",
                    "description": "An improved hand axe. Intended as a mid-grade tool before flint-edged axes."
                }
            ]
        },

        RECIPE_CARRY_SLING: {
            "id": RECIPE_CARRY_SLING,
            "name": "Carry Sling",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A larger fiber sling worn over the shoulder to help carry materials.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_CARRY_SLING,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 14.0,
            "cost": {
                RESOURCE_FIBER_NAME: 5,
                RESOURCE_WOOD_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_CARRY_SLING,
                    "name": "Carry Sling",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_STORAGE_BELONGING,
                    "role_tags": [],
                    "skill_tags": [
                        VillagerManager.SKILL_BUILDING,
                        VillagerManager.SKILL_GATHERING
                    ],
                    "effect_notes": "Future belonging item. Should improve carrying, building support, or local work efficiency for assigned villagers.",
                    "description": "A shoulder sling for carrying bundles of materials."
                }
            ]
        },

        RECIPE_HAMMER_STONE: {
            "id": RECIPE_HAMMER_STONE,
            "name": "Hammer Stone",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A shaped hammering stone used for striking, breaking, and rough stone work.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_HAMMER_STONE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 10.0,
            "cost": {
                RESOURCE_STONE_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_HAMMER_STONE,
                    "name": "Hammer Stone",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_MINING
                    ],
                    "effect_notes": "Future stoneworking tool. Should improve basic stone breaking, early mining, and stone tool preparation.",
                    "description": "A shaped hammering stone for rough stone work."
                }
            ]
        },

        RECIPE_STONE_CHISEL: {
            "id": RECIPE_STONE_CHISEL,
            "name": "Stone Chisel",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A simple stone chisel used for more precise shaping.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_STONE_CHISEL,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FLINT_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_STONE_CHISEL,
                    "name": "Stone Chisel",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "effect_notes": "Future stoneworking precision tool. Should improve stoneworking recipes or reduce failed crafting once quality systems exist.",
                    "description": "A simple chisel for shaping stone."
                }
            ]
        },

        RECIPE_WOOD_SHAPING_ADZE: {
            "id": RECIPE_WOOD_SHAPING_ADZE,
            "name": "Wood Shaping Adze",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A stone-edged adze used to shape wood more precisely than a hand axe.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_WOOD_SHAPING_ADZE,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_STONE_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_WOOD_SHAPING_ADZE,
                    "name": "Wood Shaping Adze",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "effect_notes": "Future woodworking tool. Should improve wood shaping, wooden components, woodworking recipes, and wood-based building work.",
                    "description": "A stone-edged tool for shaping wood."
                }
            ]
        },

        RECIPE_WOODEN_MALLET: {
            "id": RECIPE_WOODEN_MALLET,
            "name": "Wooden Mallet",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A simple wooden striking tool used in building and woodworking.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_WOODEN_MALLET,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_WOOD_NAME: 3
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_WOODEN_MALLET,
                    "name": "Wooden Mallet",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER,
                        StoneAgeVillagerAssignmentData.ROLE_MAKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING,
                        VillagerManager.SKILL_CRAFTING
                    ],
                    "effect_notes": "Future tool. Should improve building support, woodworking tasks, or assembly of simple structures.",
                    "description": "A wooden mallet for shaping and assembly work."
                }
            ]
        },

        RECIPE_SMOOTHING_STONE: {
            "id": RECIPE_SMOOTHING_STONE,
            "name": "Smoothing Stone",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A worn stone used to smooth wood, bone, hide, and prepared materials.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_SMOOTHING_STONE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 10.0,
            "cost": {
                RESOURCE_STONE_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_SMOOTHING_STONE,
                    "name": "Smoothing Stone",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_PREPARATION_TOOL,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "effect_notes": "Future preparation tool. Should support finishing, smoothing, hide preparation, or quality improvements for simple crafted goods.",
                    "description": "A worn stone for smoothing prepared materials."
                }
            ]
        },

        RECIPE_HIDE_ARMOR: {
            "id": RECIPE_HIDE_ARMOR,
            "name": "Hide Armor",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "Basic protective armor made from animal hide and fiber lashings. Intended to unlock after hunting produces hide.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_HIDE_ARMOR,
            "skill": VillagerManager.SKILL_CRAFTING,
            "craft_time": 24.0,
            "cost": {
                RESOURCE_HIDE_NAME: 4,
                RESOURCE_FIBER_NAME: 3
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_HIDE_ARMOR,
                    "name": "Hide Armor",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_ARMOR,
                    "item_function": ITEM_FUNCTION_ARMOR_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER,
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_EVADE,
                        VillagerManager.SKILL_PARRY
                    ],
                    "effect_notes": "Future armor. Should provide +1 defense for Hunter and Warrior. May add a small speed penalty later if armor weight becomes active.",
                    "description": "Basic hide protection for hunters and warriors."
                }
            ]
        },

        RECIPE_DRAG_SLED: {
            "id": RECIPE_DRAG_SLED,
            "name": "Drag Sled",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A crude wooden drag sled used to prepare for future camp movement systems.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_DRAG_SLED,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 18.0,
            "cost": {
                RESOURCE_WOOD_NAME: 10,
                RESOURCE_FIBER_NAME: 4
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_DRAG_SLED,
                    "name": "Drag Sled",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "effect_notes": "Future camp movement item. Should be required or heavily beneficial when moving camp, carrying supplies, or relocating village infrastructure.",
                    "description": "A crude sled for dragging supplies. Intended for future moving-camp actions."
                }
            ]
        },

        RECIPE_TENT_KIT: {
            "id": RECIPE_TENT_KIT,
            "name": "Tent Kit",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A bundled kit of poles, lashings, and cover material used to build portable tent structures.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_TENT_KIT,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 20.0,
            "cost": {
                RESOURCE_WOOD_NAME: 6,
                RESOURCE_FIBER_NAME: 8
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_TENT_KIT,
                    "name": "Tent Kit",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_KIT,
                    "item_function": ITEM_FUNCTION_BUILDING_COST_ITEM,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "effect_notes": "Future building kit. Should be consumed as an item cost for tents, portable shelters, or moving-camp shelter setup.",
                    "description": "A portable shelter kit. Used as an item cost for tents and later moving-camp systems."
                }
            ]
        },

        RECIPE_FLINT_TIPPED_HUNTING_SPEAR: {
            "id": RECIPE_FLINT_TIPPED_HUNTING_SPEAR,
            "name": "Flint-Tipped Hunting Spear",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A refined hunting spear fitted with a sharp flint tip.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_TIPPED_HUNTING_SPEAR,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 18.0,
            "cost": {
                RESOURCE_WOOD_NAME: 3,
                RESOURCE_FLINT_NAME: 2,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_TIPPED_HUNTING_SPEAR,
                    "name": "Flint-Tipped Hunting Spear",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_HUNTER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_RANGED_WEAPONS
                    ],
                    "effect_notes": "Future refined hunter weapon. Should be one of the stronger Stone Age hunting weapons and may improve hunting success against larger animals.",
                    "description": "A refined hunting spear with a flint point. Intended for later Hunter systems."
                }
            ]
        },

        RECIPE_FLINT_EDGED_HAND_AXE: {
            "id": RECIPE_FLINT_EDGED_HAND_AXE,
            "name": "Flint-Edged Hand Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "An improved hand axe with a sharper flint edge.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_EDGED_HAND_AXE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_WOOD_NAME: 1,
                RESOURCE_FLINT_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_EDGED_HAND_AXE,
                    "name": "Flint-Edged Hand Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_MAKER,
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER,
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_CRAFTING,
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_WOODWORKING
                    ],
                    "effect_notes": "Future improved tool. Should be a stronger general-purpose hand axe that improves crafting, chopping, woodcutting, or shaping tasks.",
                    "description": "An improved hand axe. Intended for future tool and work-efficiency systems."
                }
            ]
        },

        RECIPE_FLINT_EDGED_WOODSMAN_AXE: {
            "id": RECIPE_FLINT_EDGED_WOODSMAN_AXE,
            "name": "Flint-Edged Woodsman Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A larger axe intended for future woodcutting, clearing, and building bonuses.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_EDGED_WOODSMAN_AXE,
            "skill": VillagerManager.SKILL_WOODWORKING,
            "craft_time": 20.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_FLINT_NAME: 3,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_EDGED_WOODSMAN_AXE,
                    "name": "Flint-Edged Woodsman Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_WOODWORKING,
                        VillagerManager.SKILL_WOODCUTTING,
                        VillagerManager.SKILL_BUILDING
                    ],
                    "effect_notes": "Future specialist wood tool. Should improve woodcutting, clearing trees, woodworking recipes, or wood-based building work.",
                    "description": "A heavier woodcutting axe. Intended for future Woodworker and harvesting systems."
                }
            ]
        },

        RECIPE_FLINT_TIPPED_MINING_PICK: {
            "id": RECIPE_FLINT_TIPPED_MINING_PICK,
            "name": "Flint-Tipped Mining Pick",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A crude mining pick with a flint working point.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_TIPPED_MINING_PICK,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 20.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_FLINT_NAME: 3,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_TIPPED_MINING_PICK,
                    "name": "Flint-Tipped Mining Pick",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_MINING
                    ],
                    "effect_notes": "Future specialist stone tool. Should improve mining, quarrying, stoneworking recipes, or extraction from stone/flint/clay deposits.",
                    "description": "A crude mining pick. Intended for future Stoneworker and mining systems."
                }
            ]
        },

        RECIPE_FLINT_BATTLE_AXE: {
            "id": RECIPE_FLINT_BATTLE_AXE,
            "name": "Flint Battle Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "An advanced Stone Age battle axe with a sharper flint edge.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_BATTLE_AXE,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 22.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2,
                RESOURCE_FLINT_NAME: 4,
                RESOURCE_FIBER_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_BATTLE_AXE,
                    "name": "Flint Battle Axe",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "item_function": ITEM_FUNCTION_WEAPON_STATS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_WARRIOR
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING,
                        VillagerManager.SKILL_MELEE_WEAPONS
                    ],
                    "effect_notes": "Future advanced warrior weapon. Should be stronger than Stone Battle Axe and one of the best Stone Age melee weapons.",
                    "description": "A sharp flint-edged battle axe for warriors."
                }
            ]
        },

        RECIPE_FLINT_CHISEL: {
            "id": RECIPE_FLINT_CHISEL,
            "name": "Flint Chisel",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "A sharper chisel made from flint for improved stone shaping.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_FLINT_CHISEL,
            "skill": VillagerManager.SKILL_STONEWORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_FLINT_NAME: 2,
                RESOURCE_FIBER_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_FLINT_CHISEL,
                    "name": "Flint Chisel",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "item_function": ITEM_FUNCTION_TOOL_BONUS,
                    "role_tags": [
                        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER
                    ],
                    "skill_tags": [
                        VillagerManager.SKILL_STONEWORKING
                    ],
                    "effect_notes": "Future improved stoneworking precision tool. Should outperform Stone Chisel for stone shaping and advanced stone recipes.",
                    "description": "A sharp flint chisel for careful stone shaping."
                }
            ]
        }
    }
