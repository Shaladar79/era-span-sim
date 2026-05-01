extends RefCounted
class_name StoneAgeRecipeData

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

const ITEM_POINTED_STICK: String = "pointed_stick"
const ITEM_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const ITEM_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const ITEM_CRUDE_CONTAINER: String = "crude_container"
const ITEM_SLING: String = "sling"
const ITEM_HERBAL_POULTICE: String = "herbal_poultice"

const ITEM_THROWING_SPEAR: String = "throwing_spear"
const ITEM_STONE_TIPPED_SPEAR: String = "stone_tipped_spear"
const ITEM_STONE_CLUB: String = "stone_club"
const ITEM_STONE_SCRAPER: String = "stone_scraper"
const ITEM_WORKED_HAND_AXE: String = "worked_hand_axe"

const ITEM_DRAG_SLED: String = "drag_sled"
const ITEM_TENT_KIT: String = "tent_kit"
const ITEM_ADVANCED_SLING: String = "advanced_sling"
const ITEM_FLINT_TIPPED_HUNTING_SPEAR: String = "flint_tipped_hunting_spear"
const ITEM_FLINT_EDGED_HAND_AXE: String = "flint_edged_hand_axe"
const ITEM_FLINT_EDGED_WOODSMAN_AXE: String = "flint_edged_woodsman_axe"
const ITEM_FLINT_TIPPED_MINING_PICK: String = "flint_tipped_mining_pick"

const RECIPE_FLINT_TIPPED_SPEAR: String = RECIPE_FLINT_TIPPED_HUNTING_SPEAR
const ITEM_FLINT_TIPPED_SPEAR: String = ITEM_FLINT_TIPPED_HUNTING_SPEAR

const RESOURCE_WOOD_NAME: String = "Wood"
const RESOURCE_STONE_NAME: String = "Stone"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"

const CRAFTING_TIER_STONE_AGE_T1: String = "stone_age_t1"
const CRAFTING_TIER_STONE_AGE_T2: String = "stone_age_t2"
const CRAFTING_TIER_STONE_AGE_T3: String = "stone_age_t3"

const OUTPUT_TYPE_ITEM: String = "item"

const DEFAULT_CRAFT_TIME: float = 10.0


static func get_all_recipes() -> Dictionary:
    return {
        RECIPE_POINTED_STICK: {
            "id": RECIPE_POINTED_STICK,
            "name": "Pointed Stick",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A sharpened stick used as a crude tool, weapon, and future hunting item.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_POINTED_STICK,
            "skill": VillagerManager.SKILL_WOOD_WORKING,
            "craft_time": 8.0,
            "cost": {
                RESOURCE_WOOD_NAME: 2
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_POINTED_STICK,
                    "name": "Pointed Stick",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "description": "A sharpened wooden stick. Useful as an early weapon and simple camp tool."
                }
            ]
        },

        RECIPE_SIMPLE_HAND_AXE: {
            "id": RECIPE_SIMPLE_HAND_AXE,
            "name": "Simple Hand Axe",
            "tier": CRAFTING_TIER_STONE_AGE_T1,
            "description": "A crude stone hand tool used for chopping, scraping, and basic camp work.",
            "required_building": RegionBuildingData.BUILDING_MAKING_SPOT,
            "required_recipe_unlock": RECIPE_SIMPLE_HAND_AXE,
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
            "skill": VillagerManager.SKILL_HAULING,
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
            "skill": VillagerManager.SKILL_WOOD_WORKING,
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
            "skill": VillagerManager.SKILL_MEDICINE,
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
                    "description": "A crude herbal treatment. Intended for future sickness and injury recovery systems."
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
            "skill": VillagerManager.SKILL_WOOD_WORKING,
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
                    "description": "A simple heavy weapon. Intended for future Warrior and combat tutorial systems."
                }
            ]
        },

        RECIPE_STONE_SCRAPER: {
            "id": RECIPE_STONE_SCRAPER,
            "name": "Stone Scraper",
            "tier": CRAFTING_TIER_STONE_AGE_T2,
            "description": "A worked scraping tool for future hide, fiber, food, and medicine preparation.",
            "required_building": RegionBuildingData.BUILDING_STONEWORKING_BENCH,
            "required_recipe_unlock": RECIPE_STONE_SCRAPER,
            "skill": VillagerManager.SKILL_STONE_WORKING,
            "craft_time": 12.0,
            "cost": {
                RESOURCE_STONE_NAME: 1,
                RESOURCE_FLINT_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_STONE_SCRAPER,
                    "name": "Stone Scraper",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_TOOL,
                    "description": "A scraping tool. Intended for future hide, fiber, and preparation systems."
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
                    "description": "An improved hand axe. Intended as a mid-grade tool before flint-edged axes."
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
            "skill": VillagerManager.SKILL_WOOD_WORKING,
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
            "skill": VillagerManager.SKILL_WOOD_WORKING,
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
                    "description": "A portable shelter kit. Used as an item cost for tents and later moving-camp systems."
                }
            ]
        },

        RECIPE_ADVANCED_SLING: {
            "id": RECIPE_ADVANCED_SLING,
            "name": "Advanced Sling",
            "tier": CRAFTING_TIER_STONE_AGE_T3,
            "description": "An improved sling with better cordage and stone pouching.",
            "required_building": RegionBuildingData.BUILDING_WOODWORKING_BENCH,
            "required_recipe_unlock": RECIPE_ADVANCED_SLING,
            "skill": VillagerManager.SKILL_WOOD_WORKING,
            "craft_time": 16.0,
            "cost": {
                RESOURCE_FIBER_NAME: 5,
                RESOURCE_STONE_NAME: 2,
                RESOURCE_WOOD_NAME: 1
            },
            "outputs": [
                {
                    "type": OUTPUT_TYPE_ITEM,
                    "id": ITEM_ADVANCED_SLING,
                    "name": "Advanced Sling",
                    "amount": 1,
                    "category": RegionItemInventory.CATEGORY_WEAPON,
                    "description": "An improved sling. Intended for future ranged hunting and combat systems."
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
            "skill": VillagerManager.SKILL_WOOD_WORKING,
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
            "skill": VillagerManager.SKILL_STONE_WORKING,
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
                    "description": "A crude mining pick. Intended for future Stoneworker and mining systems."
                }
            ]
        }
    }
