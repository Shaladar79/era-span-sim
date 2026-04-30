extends RefCounted
class_name RegionCrafting


func get_craftable_recipes_for_building(
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory
) -> Array:
    var craftable_recipes: Array = []
    var recipe_ids: Array = RegionRecipeData.get_all_recipe_ids()

    for recipe_index in range(recipe_ids.size()):
        var recipe_id: String = str(recipe_ids[recipe_index])

        if not can_craft_recipe_at_building(
            recipe_id,
            building_id,
            research,
            inventory
        ):
            continue

        var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

        if recipe.is_empty():
            continue

        craftable_recipes.append(recipe)

    craftable_recipes.sort_custom(_sort_recipes_by_name)

    return craftable_recipes


func can_craft_recipe_at_building(
    recipe_id: String,
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory
) -> bool:
    if recipe_id == "":
        return false

    if building_id == "":
        return false

    var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

    if recipe.is_empty():
        return false

    if not is_recipe_for_building(recipe, building_id):
        return false

    if not has_recipe_unlocked(recipe, research):
        return false

    if not has_required_resources(recipe, inventory):
        return false

    return true


func is_recipe_for_building(
    recipe: Dictionary,
    building_id: String
) -> bool:
    var required_building: String = str(recipe.get("required_building", ""))

    if required_building == "":
        return false

    return required_building == building_id


func has_recipe_unlocked(
    recipe: Dictionary,
    research: RegionResearch
) -> bool:
    var required_recipe_unlock: String = str(recipe.get("required_recipe_unlock", ""))

    if required_recipe_unlock == "":
        return false

    return research.has_unlocked_recipe(required_recipe_unlock)


func has_required_resources(
    recipe: Dictionary,
    inventory: RegionInventory
) -> bool:
    var cost_variant: Variant = recipe.get("cost", {})

    if typeof(cost_variant) != TYPE_DICTIONARY:
        return true

    var cost: Dictionary = cost_variant
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])
        var required_amount: int = int(cost.get(resource_name, 0))

        if required_amount <= 0:
            continue

        if inventory.get_amount(resource_name) < required_amount:
            return false

    return true


func get_all_known_recipes_for_building(
    building_id: String,
    research: RegionResearch
) -> Array:
    var known_recipes: Array = []
    var recipe_ids: Array = RegionRecipeData.get_all_recipe_ids()

    for recipe_index in range(recipe_ids.size()):
        var recipe_id: String = str(recipe_ids[recipe_index])
        var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

        if recipe.is_empty():
            continue

        if not is_recipe_for_building(recipe, building_id):
            continue

        if not has_recipe_unlocked(recipe, research):
            continue

        known_recipes.append(recipe)

    known_recipes.sort_custom(_sort_recipes_by_name)

    return known_recipes


func get_missing_resources_for_recipe(
    recipe_id: String,
    inventory: RegionInventory
) -> Dictionary:
    var missing_resources: Dictionary = {}
    var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

    if recipe.is_empty():
        return missing_resources

    var cost_variant: Variant = recipe.get("cost", {})

    if typeof(cost_variant) != TYPE_DICTIONARY:
        return missing_resources

    var cost: Dictionary = cost_variant
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])
        var required_amount: int = int(cost.get(resource_name, 0))
        var current_amount: int = inventory.get_amount(resource_name)

        if current_amount >= required_amount:
            continue

        missing_resources[resource_name] = required_amount - current_amount

    return missing_resources


func get_recipe_cost_text(recipe_id: String) -> String:
    var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

    if recipe.is_empty():
        return ""

    var cost_variant: Variant = recipe.get("cost", {})

    if typeof(cost_variant) != TYPE_DICTIONARY:
        return ""

    var cost: Dictionary = cost_variant
    var resource_names: Array = cost.keys()
    resource_names.sort()

    var cost_parts: Array = []

    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])
        var required_amount: int = int(cost.get(resource_name, 0))

        if required_amount <= 0:
            continue

        cost_parts.append(resource_name + " " + str(required_amount))

    return ", ".join(cost_parts)


func get_recipe_output_text(recipe_id: String) -> String:
    var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

    if recipe.is_empty():
        return ""

    var outputs_variant: Variant = recipe.get("outputs", [])

    if typeof(outputs_variant) != TYPE_ARRAY:
        return ""

    var outputs: Array = outputs_variant
    var output_parts: Array = []

    for output_index in range(outputs.size()):
        var output_variant: Variant = outputs[output_index]

        if typeof(output_variant) != TYPE_DICTIONARY:
            continue

        var output_data: Dictionary = output_variant
        var output_name: String = str(output_data.get("name", "Unknown"))
        var amount: int = int(output_data.get("amount", 1))

        output_parts.append(output_name + " x" + str(amount))

    return ", ".join(output_parts)


func _sort_recipes_by_name(a: Dictionary, b: Dictionary) -> bool:
    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b
