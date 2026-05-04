extends RefCounted
class_name RegionResearch

const RESEARCH_TICK_INTERVAL: float = 30.0

const THINKERS_SPOT_BASE_IDEAS_PER_TICK: float = 0.5
const THINKERS_SPOT_IDEAS_PER_THINKING_LEVEL: float = 0.25

const SAVE_KEY_RESEARCH_POINTS: String = "research_points"
const SAVE_KEY_RESEARCH_TIMER: String = "research_timer"
const SAVE_KEY_LEARNED_RESEARCH: String = "learned_research"
const SAVE_KEY_UNLOCKED_RECIPES: String = "unlocked_recipes"
const SAVE_KEY_UNLOCKED_BUILDINGS: String = "unlocked_buildings"
const SAVE_KEY_GLOBAL_BONUSES: String = "global_bonuses"

var research_points: float = 0.0
var research_timer: float = 0.0

var learned_research: Array = []
var unlocked_recipes: Array = []
var unlocked_buildings: Array = []
var global_bonuses: Dictionary = {}


func reset() -> void:
    research_points = 0.0
    research_timer = 0.0
    learned_research.clear()
    unlocked_recipes.clear()
    unlocked_buildings.clear()
    global_bonuses.clear()


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_RESEARCH_POINTS: research_points,
        SAVE_KEY_RESEARCH_TIMER: research_timer,
        SAVE_KEY_LEARNED_RESEARCH: learned_research.duplicate(true),
        SAVE_KEY_UNLOCKED_RECIPES: unlocked_recipes.duplicate(true),
        SAVE_KEY_UNLOCKED_BUILDINGS: unlocked_buildings.duplicate(true),
        SAVE_KEY_GLOBAL_BONUSES: global_bonuses.duplicate(true)
    }


func load_save_data(save_data: Dictionary) -> void:
    reset()

    if save_data.is_empty():
        return

    research_points = max(0.0, float(save_data.get(SAVE_KEY_RESEARCH_POINTS, 0.0)))
    research_timer = max(0.0, float(save_data.get(SAVE_KEY_RESEARCH_TIMER, 0.0)))

    var saved_learned_research: Variant = save_data.get(SAVE_KEY_LEARNED_RESEARCH, [])
    var saved_unlocked_recipes: Variant = save_data.get(SAVE_KEY_UNLOCKED_RECIPES, [])
    var saved_unlocked_buildings: Variant = save_data.get(SAVE_KEY_UNLOCKED_BUILDINGS, [])
    var saved_global_bonuses: Variant = save_data.get(SAVE_KEY_GLOBAL_BONUSES, {})

    learned_research = get_unique_string_array(saved_learned_research)
    unlocked_recipes = get_unique_string_array(saved_unlocked_recipes)
    unlocked_buildings = get_unique_string_array(saved_unlocked_buildings)

    if typeof(saved_global_bonuses) == TYPE_DICTIONARY:
        var bonus_dict: Dictionary = saved_global_bonuses
        var bonus_ids: Array = bonus_dict.keys()

        for bonus_index in range(bonus_ids.size()):
            var bonus_id: String = str(bonus_ids[bonus_index])

            if bonus_id == "":
                continue

            global_bonuses[bonus_id] = float(bonus_dict.get(bonus_id, 0.0))


func get_unique_string_array(value: Variant) -> Array:
    var output: Array = []

    if typeof(value) != TYPE_ARRAY:
        return output

    var input_array: Array = value

    for value_index in range(input_array.size()):
        var entry: String = str(input_array[value_index])

        if entry == "":
            continue

        if output.has(entry):
            continue

        output.append(entry)

    return output


func update(
    delta: float,
    building_manager: RegionBuildingManager,
    villager_manager: VillagerManager = null
) -> void:
    research_timer += delta

    var did_gain_research: bool = false

    while research_timer >= RESEARCH_TICK_INTERVAL:
        research_timer -= RESEARCH_TICK_INTERVAL

        var ideas_per_tick: float = get_total_ideas_per_tick(
            building_manager,
            villager_manager
        )

        if ideas_per_tick <= 0.0:
            continue

        add_research(ideas_per_tick)
        did_gain_research = true

        print(
            "Ideas gained: ",
            get_display_amount(ideas_per_tick),
            ". Total Ideas: ",
            get_display_amount(research_points)
        )

    if did_gain_research:
        return


func get_total_ideas_per_tick(
    building_manager: RegionBuildingManager,
    villager_manager: VillagerManager = null
) -> float:
    var total_ideas: float = 0.0
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

        total_ideas += get_thinkers_spot_ideas_per_tick(
            building_data,
            villager_manager
        )

    return total_ideas


func get_thinkers_spot_ideas_per_tick(
    building_data: Dictionary,
    villager_manager: VillagerManager = null
) -> float:
    var assigned_villagers: Array = building_data.get("assigned_villagers", [])

    if assigned_villagers.is_empty():
        return THINKERS_SPOT_BASE_IDEAS_PER_TICK

    if villager_manager == null:
        return THINKERS_SPOT_BASE_IDEAS_PER_TICK

    var total_ideas: float = 0.0
    var counted_assigned_villagers: int = 0

    for assigned_index in range(assigned_villagers.size()):
        var villager_id: int = int(assigned_villagers[assigned_index])

        if villager_id <= 0:
            continue

        var villager_data: Dictionary = villager_manager.get_villager_data_by_id(villager_id)

        if villager_data.is_empty():
            continue

        if str(villager_data.get("health_state", VillagerManager.HEALTH_STATE_HEALTHY)) == VillagerManager.HEALTH_STATE_DEAD:
            continue

        var thinking_level: int = villager_manager.get_villager_skill_level(
            villager_data,
            VillagerManager.SKILL_THINKING
        )

        total_ideas += THINKERS_SPOT_BASE_IDEAS_PER_TICK
        total_ideas += float(thinking_level) * THINKERS_SPOT_IDEAS_PER_THINKING_LEVEL
        counted_assigned_villagers += 1

    if counted_assigned_villagers <= 0:
        return THINKERS_SPOT_BASE_IDEAS_PER_TICK

    return total_ideas


func get_total_research_per_minute(building_manager: RegionBuildingManager) -> float:
    return get_total_ideas_per_tick(building_manager, null) * 2.0


func add_research(amount: float) -> void:
    if amount <= 0.0:
        return

    research_points += amount


func spend_research(amount: float) -> bool:
    if amount <= 0.0:
        return true

    if research_points < amount:
        return false

    research_points -= amount
    return true


func get_research_points() -> float:
    return research_points


func get_research_points_display_text() -> String:
    return get_display_amount(research_points)


func set_research_points(amount: float) -> void:
    research_points = max(0.0, amount)


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

    var cost: float = float(plan.get("cost", 0))

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
        result["message"] = "Idea not found: " + research_id
        return result

    if not can_buy_research_plan(
        research_id,
        building_manager,
        inventory
    ):
        result["message"] = "Idea is not currently available: " + str(plan.get("name", research_id))
        return result

    var cost: float = float(plan.get("cost", 0))

    if not spend_research(cost):
        result["message"] = "Not enough Ideas."
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


func get_display_amount(amount: float) -> String:
    if is_equal_approx(amount, round(amount)):
        return str(int(round(amount)))

    return "%.1f" % amount


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
    print("Ideas:")
    print("Stored Ideas: " + get_display_amount(research_points))
    print("Ideas per 30 seconds: " + get_display_amount(get_total_ideas_per_tick(building_manager, null)))
    print("Learned Ideas: " + str(learned_research))
    print("Unlocked Recipes: " + str(unlocked_recipes))
    print("Unlocked Buildings: " + str(unlocked_buildings))
    print("Global Bonuses: " + str(global_bonuses))
    print("")
