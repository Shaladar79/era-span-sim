extends RefCounted
class_name RegionRecipeData

const RECIPE_POINTED_STICK: String = StoneAgeRecipeData.RECIPE_POINTED_STICK
const RECIPE_SIMPLE_HAND_AXE: String = StoneAgeRecipeData.RECIPE_SIMPLE_HAND_AXE
const RECIPE_SHARP_STONE_KNIFE: String = StoneAgeRecipeData.RECIPE_SHARP_STONE_KNIFE
const RECIPE_CRUDE_CONTAINER: String = StoneAgeRecipeData.RECIPE_CRUDE_CONTAINER
const RECIPE_SLING: String = StoneAgeRecipeData.RECIPE_SLING
const RECIPE_HERBAL_POULTICE: String = StoneAgeRecipeData.RECIPE_HERBAL_POULTICE

const RECIPE_THROWING_SPEAR: String = StoneAgeRecipeData.RECIPE_THROWING_SPEAR
const RECIPE_STONE_TIPPED_SPEAR: String = StoneAgeRecipeData.RECIPE_STONE_TIPPED_SPEAR
const RECIPE_STONE_CLUB: String = StoneAgeRecipeData.RECIPE_STONE_CLUB
const RECIPE_STONE_SCRAPER: String = StoneAgeRecipeData.RECIPE_STONE_SCRAPER
const RECIPE_WORKED_HAND_AXE: String = StoneAgeRecipeData.RECIPE_WORKED_HAND_AXE

const RECIPE_DRAG_SLED: String = StoneAgeRecipeData.RECIPE_DRAG_SLED
const RECIPE_TENT_KIT: String = StoneAgeRecipeData.RECIPE_TENT_KIT
const RECIPE_ADVANCED_SLING: String = StoneAgeRecipeData.RECIPE_ADVANCED_SLING
const RECIPE_FLINT_TIPPED_HUNTING_SPEAR: String = StoneAgeRecipeData.RECIPE_FLINT_TIPPED_HUNTING_SPEAR
const RECIPE_FLINT_EDGED_HAND_AXE: String = StoneAgeRecipeData.RECIPE_FLINT_EDGED_HAND_AXE
const RECIPE_FLINT_EDGED_WOODSMAN_AXE: String = StoneAgeRecipeData.RECIPE_FLINT_EDGED_WOODSMAN_AXE
const RECIPE_FLINT_TIPPED_MINING_PICK: String = StoneAgeRecipeData.RECIPE_FLINT_TIPPED_MINING_PICK

const ITEM_POINTED_STICK: String = StoneAgeRecipeData.ITEM_POINTED_STICK
const ITEM_SIMPLE_HAND_AXE: String = StoneAgeRecipeData.ITEM_SIMPLE_HAND_AXE
const ITEM_SHARP_STONE_KNIFE: String = StoneAgeRecipeData.ITEM_SHARP_STONE_KNIFE
const ITEM_CRUDE_CONTAINER: String = StoneAgeRecipeData.ITEM_CRUDE_CONTAINER
const ITEM_SLING: String = StoneAgeRecipeData.ITEM_SLING
const ITEM_HERBAL_POULTICE: String = StoneAgeRecipeData.ITEM_HERBAL_POULTICE

const ITEM_THROWING_SPEAR: String = StoneAgeRecipeData.ITEM_THROWING_SPEAR
const ITEM_STONE_TIPPED_SPEAR: String = StoneAgeRecipeData.ITEM_STONE_TIPPED_SPEAR
const ITEM_STONE_CLUB: String = StoneAgeRecipeData.ITEM_STONE_CLUB
const ITEM_STONE_SCRAPER: String = StoneAgeRecipeData.ITEM_STONE_SCRAPER
const ITEM_WORKED_HAND_AXE: String = StoneAgeRecipeData.ITEM_WORKED_HAND_AXE

const ITEM_DRAG_SLED: String = StoneAgeRecipeData.ITEM_DRAG_SLED
const ITEM_TENT_KIT: String = StoneAgeRecipeData.ITEM_TENT_KIT
const ITEM_ADVANCED_SLING: String = StoneAgeRecipeData.ITEM_ADVANCED_SLING
const ITEM_FLINT_TIPPED_HUNTING_SPEAR: String = StoneAgeRecipeData.ITEM_FLINT_TIPPED_HUNTING_SPEAR
const ITEM_FLINT_EDGED_HAND_AXE: String = StoneAgeRecipeData.ITEM_FLINT_EDGED_HAND_AXE
const ITEM_FLINT_EDGED_WOODSMAN_AXE: String = StoneAgeRecipeData.ITEM_FLINT_EDGED_WOODSMAN_AXE
const ITEM_FLINT_TIPPED_MINING_PICK: String = StoneAgeRecipeData.ITEM_FLINT_TIPPED_MINING_PICK

# Backward-compatible aliases in case older files still refer to this name.
const RECIPE_FLINT_TIPPED_SPEAR: String = StoneAgeRecipeData.RECIPE_FLINT_TIPPED_SPEAR
const ITEM_FLINT_TIPPED_SPEAR: String = StoneAgeRecipeData.ITEM_FLINT_TIPPED_SPEAR

const RESOURCE_WOOD_NAME: String = StoneAgeRecipeData.RESOURCE_WOOD_NAME
const RESOURCE_STONE_NAME: String = StoneAgeRecipeData.RESOURCE_STONE_NAME
const RESOURCE_FLINT_NAME: String = StoneAgeRecipeData.RESOURCE_FLINT_NAME
const RESOURCE_FIBER_NAME: String = StoneAgeRecipeData.RESOURCE_FIBER_NAME
const RESOURCE_BERRIES_NAME: String = StoneAgeRecipeData.RESOURCE_BERRIES_NAME
const RESOURCE_MUSHROOMS_NAME: String = StoneAgeRecipeData.RESOURCE_MUSHROOMS_NAME

const CRAFTING_TIER_STONE_AGE_T1: String = StoneAgeRecipeData.CRAFTING_TIER_STONE_AGE_T1
const CRAFTING_TIER_STONE_AGE_T2: String = StoneAgeRecipeData.CRAFTING_TIER_STONE_AGE_T2
const CRAFTING_TIER_STONE_AGE_T3: String = StoneAgeRecipeData.CRAFTING_TIER_STONE_AGE_T3

const OUTPUT_TYPE_ITEM: String = StoneAgeRecipeData.OUTPUT_TYPE_ITEM

const DEFAULT_CRAFT_TIME: float = StoneAgeRecipeData.DEFAULT_CRAFT_TIME


static func get_all_recipes() -> Dictionary:
    var recipes: Dictionary = {}

    recipes.merge(
        StoneAgeRecipeData.get_all_recipes(),
        true
    )

    return recipes


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
