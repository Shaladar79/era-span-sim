extends RefCounted
class_name RegionRecipeData

const RECIPE_POINTED_STICK: String = "pointed_stick"
const RECIPE_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const RECIPE_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const RECIPE_CRUDE_CONTAINER: String = "crude_container"
const RECIPE_SLING: String = "sling"
const RECIPE_HERBAL_POULTICE: String = "herbal_poultice"

const ITEM_POINTED_STICK: String = "pointed_stick"
const ITEM_SIMPLE_HAND_AXE: String = "simple_hand_axe"
const ITEM_SHARP_STONE_KNIFE: String = "sharp_stone_knife"
const ITEM_CRUDE_CONTAINER: String = "crude_container"
const ITEM_SLING: String = "sling"
const ITEM_HERBAL_POULTICE: String = "herbal_poultice"

const RESOURCE_WOOD_NAME: String = "Wood"
const RESOURCE_STONE_NAME: String = "Stone"
const RESOURCE_FLINT_NAME: String = "Flint"
const RESOURCE_FIBER_NAME: String = "Fiber"
const RESOURCE_BERRIES_NAME: String = "Berries"
const RESOURCE_MUSHROOMS_NAME: String = "Mushrooms"

const CRAFTING_TIER_STONE_AGE_T1: String = "stone_age_t1"

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
            "required_recipe_unlock": RegionResearchData.RECIPE_POINTED_STICK,
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
            "required_recipe_unlock": RegionResearchData.RECIPE_SIMPLE_HAND_AXE,
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
            "required_recipe_unlock": RegionResearchData.RECIPE_SHARP_STONE_KNIFE,
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
            "required_recipe_unlock": RegionResearchData.RECIPE_CRUDE_CONTAINER,
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
            "required_recipe_unlock": RegionResearchData.RECIPE_SLING,
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
            "required_recipe_unlock": RegionResearchData.RECIPE_HERBAL_POULTICE,
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
        }
    }


static func get_recipe(recipe_id: String) -> Dictionary:
    var all_recipes: Dictionary = get_all_recipes()

    if not all_recipes.has(recipe_id):
        return {}

    var recipe: Dictionary = all_recipes[recipe_id]

    return recipe.duplicate(true)


static func get_all_recipe_ids() -> Array:
    var all_recipes: Dictionary = get_all_recipes()
    var recipe_ids: Array = all_recipes.keys()

    recipe_ids.sort()

    return recipe_ids


static func get_recipe_name(recipe_id: String) -> String:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return recipe_id

    return str(recipe.get("name", recipe_id))


static func get_recipe_cost(recipe_id: String) -> Dictionary:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return {}

    var cost: Variant = recipe.get("cost", {})

    if typeof(cost) != TYPE_DICTIONARY:
        return {}

    return cost.duplicate(true)


static func get_recipe_outputs(recipe_id: String) -> Array:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return []

    var outputs: Variant = recipe.get("outputs", [])

    if typeof(outputs) != TYPE_ARRAY:
        return []

    return outputs.duplicate(true)


static func get_required_building(recipe_id: String) -> String:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return ""

    return str(recipe.get("required_building", ""))


static func get_required_recipe_unlock(recipe_id: String) -> String:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return ""

    return str(recipe.get("required_recipe_unlock", ""))


static func get_recipe_skill(recipe_id: String) -> String:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return ""

    return str(recipe.get("skill", ""))


static func get_recipe_craft_time(recipe_id: String) -> float:
    var recipe: Dictionary = get_recipe(recipe_id)

    if recipe.is_empty():
        return DEFAULT_CRAFT_TIME

    return float(recipe.get("craft_time", DEFAULT_CRAFT_TIME))
