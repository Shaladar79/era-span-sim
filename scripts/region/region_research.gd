extends RefCounted
class_name RegionResearch

const RESEARCH_TICK_INTERVAL: float = 60.0

var research_points: int = 0
var research_timer: float = 0.0

var learned_research: Array = []
var unlocked_recipes: Array = []
var unlocked_buildings: Array = []
var global_bonuses: Dictionary = {}


func reset() -> void:
    research_points = 0
    research_timer = 0.0
    learned_research.clear()
    unlocked_recipes.clear()
    unlocked_buildings.clear()
    global_bonuses.clear()


func update(
    delta: float,
    building_manager: RegionBuildingManager
) -> void:
    research_timer += delta

    if research_timer < RESEARCH_TICK_INTERVAL:
        return

    research_timer -= RESEARCH_TICK_INTERVAL

    var research_per_minute: int = get_total_research_per_minute(building_manager)

    if research_per_minute <= 0:
        return

    add_research(research_per_minute)

    print(
        "Research gained: ",
        research_per_minute,
        ". Total Research: ",
        research_points
    )


func get_total_research_per_minute(building_manager: RegionBuildingManager) -> int:
    var total_research: int = 0
    var buildings: Array = building_manager.get_buildings()

    for building_index in range(buildings.size()):
        var building_variant: Variant = buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != RegionBuildingData.BUILDING_THINKERS_SPOT:
            continue

        if not bool(building_data.get("active", true)):
            continue

        total_research += int(building_data.get(
            "research_per_minute",
            RegionBuildingData.THINKERS_SPOT_RESEARCH_PER_MINUTE
        ))

    return total_research


func add_research(amount: int) -> void:
    if amount <= 0:
        return

    research_points += amount


func spend_research(amount: int) -> bool:
    if amount <= 0:
        return true

    if research_points < amount:
        return false

    research_points -= amount
    return true


func get_research_points() -> int:
    return research_points


func set_research_points(amount: int) -> void:
    research_points = max(0, amount)


func get_buyable_research_plans(
    building_manager: RegionBuildingManager,
    inventory: RegionInventory
) -> Array:
    var buyable_plans: Array = []
    var research_ids: Array = RegionResearchData.get_all_research_ids()

    for research_index in range(research_ids.size()):
        var research_id: String = str(research_ids[research_index])
        var plan: Dictionary = RegionResearchData.get_research_plan(research_id)

        if plan.is_empty():
            continue

        if can_buy_research_plan(
            research_id,
            building_manager,
            inventory
        ):
            buyable_plans.append(plan)

    buyable_plans.sort_custom(_sort_research_plans_by_cost_then_name)

    return buyable_plans


func can_buy_research_plan(
    research_id: String,
    building_manager: RegionBuildingManager,
    inventory: RegionInventory
) -> bool:
    var plan: Dictionary = RegionResearchData.get_research_plan(research_id)

    if plan.is_empty():
        return false

    if has_learned_research(research_id):
        return false

    var cost: int = int(plan.get("cost", 0))

    if research_points < cost:
        return false

    if not has_required_buildings(plan, building_manager):
        return false

    if not has_required_research(plan):
        return false

    if not has_required_resources_seen(plan, inventory):
        return false

    return true


func buy_research_plan(
    research_id: String,
    building_manager: RegionBuildingManager,
    inventory: RegionInventory
) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": "",
        "plan": {},
        "unlocked_buildings": [],
        "unlocked_recipes": [],
        "global_bonuses": []
    }

    var plan: Dictionary = RegionResearchData.get_research_plan(research_id)

    if plan.is_empty():
        result["message"] = "Research plan not found: " + research_id
        return result

    if not can_buy_research_plan(
        research_id,
        building_manager,
        inventory
    ):
        result["message"] = "Research is not currently available: " + str(plan.get("name", research_id))
        return result

    var cost: int = int(plan.get("cost", 0))

    if not spend_research(cost):
        result["message"] = "Not enough Research."
        return result

    learn_research_plan(plan)

    result["success"] = true
    result["message"] = "Learned " + str(plan.get("name", research_id)) + "."
    result["plan"] = plan.duplicate(true)
    result["unlocked_buildings"] = get_array_copy(plan.get("unlocks_buildings", []))
    result["unlocked_recipes"] = get_array_copy(plan.get("unlocks_recipes", []))
    result["global_bonuses"] = get_array_copy(plan.get("global_bonuses", []))

    print(result["message"])

    return result


func learn_research_plan(plan: Dictionary) -> void:
    var research_id: String = str(plan.get("id", ""))

    if research_id == "":
        return

    if not learned_research.has(research_id):
        learned_research.append(research_id)

    add_unlocked_buildings(get_array_copy(plan.get("unlocks_buildings", [])))
    add_unlocked_recipes(get_array_copy(plan.get("unlocks_recipes", [])))
    add_global_bonuses(get_array_copy(plan.get("global_bonuses", [])))


func add_unlocked_buildings(building_ids: Array) -> void:
    for building_index in range(building_ids.size()):
        var building_id: String = str(building_ids[building_index])

        if building_id == "":
            continue

        if unlocked_buildings.has(building_id):
            continue

        unlocked_buildings.append(building_id)


func add_unlocked_recipes(recipe_ids: Array) -> void:
    for recipe_index in range(recipe_ids.size()):
        var recipe_id: String = str(recipe_ids[recipe_index])

        if recipe_id == "":
            continue

        if unlocked_recipes.has(recipe_id):
            continue

        unlocked_recipes.append(recipe_id)


func add_global_bonuses(bonus_list: Array) -> void:
    for bonus_index in range(bonus_list.size()):
        var bonus_variant: Variant = bonus_list[bonus_index]

        if typeof(bonus_variant) != TYPE_DICTIONARY:
            continue

        var bonus_data: Dictionary = bonus_variant
        var bonus_id: String = str(bonus_data.get("id", ""))
        var bonus_amount: float = float(bonus_data.get("amount", 0.0))

        if bonus_id == "":
            continue

        if not global_bonuses.has(bonus_id):
            global_bonuses[bonus_id] = 0.0

        global_bonuses[bonus_id] = float(global_bonuses[bonus_id]) + bonus_amount


func has_required_buildings(
    plan: Dictionary,
    building_manager: RegionBuildingManager
) -> bool:
    var required_buildings: Array = get_array_copy(plan.get("required_buildings", []))

    for required_index in range(required_buildings.size()):
        var required_building_id: String = str(required_buildings[required_index])

        if required_building_id == "":
            continue

        if not has_building_built(required_building_id, building_manager):
            return false

    return true


func has_building_built(
    building_id: String,
    building_manager: RegionBuildingManager
) -> bool:
    var buildings: Array = building_manager.get_buildings()

    for building_index in range(buildings.size()):
        var building_variant: Variant = buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var placed_building_id: String = str(building_data.get("id", ""))

        if placed_building_id == building_id:
            return true

    return false


func has_required_research(plan: Dictionary) -> bool:
    var required_research: Array = get_array_copy(plan.get("required_research", []))

    for required_index in range(required_research.size()):
        var required_research_id: String = str(required_research[required_index])

        if required_research_id == "":
            continue

        if not has_learned_research(required_research_id):
            return false

    return true


func has_required_resources_seen(
    plan: Dictionary,
    inventory: RegionInventory
) -> bool:
    var required_all_resources_seen: Array = get_array_copy(plan.get("required_all_resources_seen", []))

    for required_index in range(required_all_resources_seen.size()):
        var resource_name: String = str(required_all_resources_seen[required_index])

        if resource_name == "":
            continue

        if not has_resource_seen(resource_name, inventory):
            return false

    var required_any_resources_seen: Array = get_array_copy(plan.get("required_any_resources_seen", []))

    if required_any_resources_seen.is_empty():
        return true

    for any_index in range(required_any_resources_seen.size()):
        var any_resource_name: String = str(required_any_resources_seen[any_index])

        if any_resource_name == "":
            continue

        if has_resource_seen(any_resource_name, inventory):
            return true

    return false


func has_resource_seen(
    resource_name: String,
    inventory: RegionInventory
) -> bool:
    return inventory.get_amount(resource_name) > 0


func has_learned_research(research_id: String) -> bool:
    return learned_research.has(research_id)


func has_unlocked_recipe(recipe_id: String) -> bool:
    return unlocked_recipes.has(recipe_id)


func has_unlocked_building(building_id: String) -> bool:
    return unlocked_buildings.has(building_id)


func get_global_bonus_amount(bonus_id: String) -> float:
    return float(global_bonuses.get(bonus_id, 0.0))


func get_villager_move_speed_bonus() -> float:
    return get_global_bonus_amount(RegionResearchData.BONUS_VILLAGER_MOVE_SPEED)


func get_building_speed_bonus() -> float:
    return get_global_bonus_amount(RegionResearchData.BONUS_BUILDING_SPEED)


func get_learned_research() -> Array:
    return learned_research.duplicate(true)


func get_unlocked_recipes() -> Array:
    return unlocked_recipes.duplicate(true)


func get_unlocked_buildings() -> Array:
    return unlocked_buildings.duplicate(true)


func get_global_bonuses() -> Dictionary:
    return global_bonuses.duplicate(true)


func get_array_copy(value: Variant) -> Array:
    if typeof(value) != TYPE_ARRAY:
        return []

    var output: Array = []

    for value_index in range(value.size()):
        output.append(value[value_index])

    return output


func _sort_research_plans_by_cost_then_name(a: Dictionary, b: Dictionary) -> bool:
    var cost_a: int = int(a.get("cost", 0))
    var cost_b: int = int(b.get("cost", 0))

    if cost_a != cost_b:
        return cost_a < cost_b

    var name_a: String = str(a.get("name", ""))
    var name_b: String = str(b.get("name", ""))

    return name_a < name_b


func print_research_status(building_manager: RegionBuildingManager) -> void:
    print("")
    print("Research:")
    print("Stored Research: " + str(research_points))
    print("Research per Minute: " + str(get_total_research_per_minute(building_manager)))
    print("Learned Research: " + str(learned_research))
    print("Unlocked Recipes: " + str(unlocked_recipes))
    print("Unlocked Buildings: " + str(unlocked_buildings))
    print("Global Bonuses: " + str(global_bonuses))
    print("")
