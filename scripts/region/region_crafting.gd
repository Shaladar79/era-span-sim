extends RefCounted
class_name RegionCrafting


func get_craftable_recipes_for_building(
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory
) -> Array:
    var craftable_recipes: Array = []
    var known_recipes: Array = get_all_known_recipes_for_building(
        building_id,
        research
    )

    for recipe_index in range(known_recipes.size()):
        var recipe: Dictionary = known_recipes[recipe_index]
        var recipe_id: String = str(recipe.get("id", ""))

        if not has_required_resources(recipe, inventory):
            continue

        craftable_recipes.append(recipe)

    craftable_recipes.sort_custom(_sort_recipes_by_name)

    return craftable_recipes


func get_all_recipes_for_building(building_id: String) -> Array:
    var building_recipes: Array = []
    var recipe_ids: Array = RegionRecipeData.get_all_recipe_ids()

    if building_id == "":
        return building_recipes

    for recipe_index in range(recipe_ids.size()):
        var recipe_id: String = str(recipe_ids[recipe_index])
        var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

        if recipe.is_empty():
            continue

        if not is_recipe_for_building(recipe, building_id):
            continue

        building_recipes.append(recipe)

    building_recipes.sort_custom(_sort_recipes_by_name)

    return building_recipes


func building_has_any_recipes(building_id: String) -> bool:
    return not get_all_recipes_for_building(building_id).is_empty()


func get_all_known_recipes_for_building(
    building_id: String,
    research: RegionResearch
) -> Array:
    var known_recipes: Array = []
    var building_recipes: Array = get_all_recipes_for_building(building_id)

    for recipe_index in range(building_recipes.size()):
        var recipe: Dictionary = building_recipes[recipe_index]

        if not has_recipe_unlocked(recipe, research):
            continue

        known_recipes.append(recipe)

    known_recipes.sort_custom(_sort_recipes_by_name)

    return known_recipes


func get_unaffordable_known_recipes_for_building(
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory
) -> Array:
    var unaffordable_recipes: Array = []
    var known_recipes: Array = get_all_known_recipes_for_building(
        building_id,
        research
    )

    for recipe_index in range(known_recipes.size()):
        var recipe: Dictionary = known_recipes[recipe_index]

        if has_required_resources(recipe, inventory):
            continue

        unaffordable_recipes.append(recipe)

    unaffordable_recipes.sort_custom(_sort_recipes_by_name)

    return unaffordable_recipes

func get_known_recipe_display_rows_for_building(
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory
) -> Array:
    var recipe_rows: Array = []
    var known_recipes: Array = get_all_known_recipes_for_building(
        building_id,
        research
    )

    for recipe_index in range(known_recipes.size()):
        var recipe: Dictionary = known_recipes[recipe_index]
        var recipe_id: String = str(recipe.get("id", ""))

        if recipe_id == "":
            continue

        var can_craft: bool = has_required_resources(
            recipe,
            inventory
        )

        var missing_text: String = ""

        if not can_craft:
            missing_text = get_missing_resources_text(
                recipe_id,
                inventory
            )

        recipe_rows.append({
            "id": recipe_id,
            "name": str(recipe.get("name", recipe_id)),
            "description": str(recipe.get("description", "")),
            "can_craft": can_craft,
            "cost_text": get_recipe_cost_text(recipe_id),
            "output_text": get_recipe_output_text(recipe_id),
            "missing_text": missing_text
        })

    recipe_rows.sort_custom(_sort_recipe_rows_by_name)

    return recipe_rows

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


func get_missing_resources_text(
    recipe_id: String,
    inventory: RegionInventory
) -> String:
    var missing_resources: Dictionary = get_missing_resources_for_recipe(
        recipe_id,
        inventory
    )

    if missing_resources.is_empty():
        return ""

    var resource_names: Array = missing_resources.keys()
    resource_names.sort()

    var missing_parts: Array = []

    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])
        var missing_amount: int = int(missing_resources.get(resource_name, 0))

        if missing_amount <= 0:
            continue

        missing_parts.append(resource_name + " " + str(missing_amount))

    return ", ".join(missing_parts)


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

func _sort_recipe_rows_by_name(a: Dictionary, b: Dictionary) -> bool:
    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b

func craft_recipe_at_building(
    recipe_id: String,
    building_id: String,
    research: RegionResearch,
    inventory: RegionInventory,
    item_inventory: RegionItemInventory
) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": ""
    }

    if not can_craft_recipe_at_building(
        recipe_id,
        building_id,
        research,
        inventory
    ):
        result["message"] = "Cannot craft recipe right now."
        return result

    var recipe: Dictionary = RegionRecipeData.get_recipe(recipe_id)

    if recipe.is_empty():
        result["message"] = "Recipe not found."
        return result

    var cost: Dictionary = RegionRecipeData.get_recipe_cost(recipe_id)

    if not inventory.has_cost(cost):
        result["message"] = "Not enough resources."
        return result

    inventory.spend_cost(cost)

    var outputs: Array = RegionRecipeData.get_recipe_outputs(recipe_id)
    item_inventory.add_items_from_outputs(outputs)

    var output_text: String = get_recipe_output_text(recipe_id)

    if output_text == "":
        output_text = str(recipe.get("name", recipe_id))

    result["success"] = true
    result["message"] = "Crafted " + output_text + "."

    return result


func _sort_recipes_by_name(a: Dictionary, b: Dictionary) -> bool:
    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b
