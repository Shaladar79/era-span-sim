extends RefCounted
class_name VillagerManager

const STARTING_POPULATION: int = CoreTuning.STARTING_POPULATION
const POPULATION_GROWTH_INTERVAL: float = CoreTuning.POPULATION_GROWTH_INTERVAL
const POPULATION_GROWTH_CHANCE: float = CoreTuning.POPULATION_GROWTH_CHANCE

const VILLAGER_STATE_IDLE: String = "idle"
const VILLAGER_STATE_MOVING: String = "moving"
const VILLAGER_STATE_HARVESTING: String = "harvesting"
const VILLAGER_STATE_THINKING: String = "thinking"
const VILLAGER_STATE_WAITING_AT_BUILDING: String = "waiting_at_building"
const VILLAGER_STATE_PATROLLING: String = "patrolling"
const VILLAGER_STATE_MOVING_TO_HUNT: String = "moving_to_hunt"
const VILLAGER_STATE_HUNTING: String = "hunting"
const VILLAGER_STATE_RETURNING_FROM_HUNT: String = "returning_from_hunt"

const HUNTING_PHASE_NONE: String = ""
const HUNTING_PHASE_TRAVEL_TO_ANIMAL: String = "travel_to_animal"
const HUNTING_PHASE_HUNTING: String = "hunting"
const HUNTING_PHASE_RETURNING: String = "returning"

const VILLAGER_MOVE_INTERVAL: float = CoreTuning.VILLAGER_MOVE_INTERVAL
const DEFAULT_HARVEST_DURATION: float = CoreTuning.DEFAULT_HARVEST_DURATION

const NO_ASSIGNED_AREA: Vector2i = Vector2i(-1, -1)
const DEFAULT_ASSIGNED_WORK_RADIUS: int = CoreTuning.DEFAULT_ASSIGNED_WORK_RADIUS

const SAVE_KEY_VILLAGERS: String = "villagers"
const SAVE_KEY_NEXT_VILLAGER_ID: String = "next_villager_id"
const SAVE_KEY_POPULATION_GROWTH_TIMER: String = "population_growth_timer"
const SAVE_KEY_HARVEST_SPEED_MULTIPLIER: String = "harvest_speed_multiplier"
const SAVE_KEY_HARVEST_YIELD_MULTIPLIER: String = "harvest_yield_multiplier"
const SAVE_KEY_GLOBAL_MOVEMENT_SPEED_BONUS: String = "global_movement_speed_bonus"
const SAVE_KEY_GLOBAL_BELONGING_SLOT_BONUS: String = "global_belonging_slot_bonus"

const SAVE_TYPE_KEY: String = "__save_type"
const SAVE_TYPE_VECTOR2I: String = "Vector2i"
const SAVE_TYPE_VECTOR2: String = "Vector2"

const HEALTH_STATE_HEALTHY: String = "healthy"
const HEALTH_STATE_SICK: String = "sick"
const HEALTH_STATE_WEAKENED: String = "weakened"
const HEALTH_STATE_DEAD: String = "dead"

const BASE_HEALTH: int = CoreTuning.BASE_VILLAGER_HEALTH
const HUNGER_FULL: int = CoreTuning.HUNGER_FULL
const HUNGER_EAT_THRESHOLD: int = CoreTuning.HUNGER_EAT_THRESHOLD

const BASE_BELONGING_SLOTS: int = CoreTuning.BASE_BELONGING_SLOTS
const STONE_AGE_MAX_BELONGING_SLOTS: int = StoneAgeTuning.MAX_BELONGING_SLOTS
const CURRENT_NAME_ERA: String = VillagerNameGenerator.NAME_ERA_STONE

const BASE_SPEED: int = CoreTuning.BASE_SPEED
const MIN_BASE_SPEED: int = CoreTuning.MIN_BASE_SPEED
const MAX_BASE_SPEED: int = CoreTuning.MAX_BASE_SPEED
const MIN_SPEED: int = CoreTuning.MIN_SPEED

const BASE_SKILL_START_MIN: int = StoneAgeTuning.BASE_SKILL_START_MIN
const BASE_SKILL_START_MAX: int = StoneAgeTuning.BASE_SKILL_START_MAX
const ROLE_SKILL_START_MIN: int = StoneAgeTuning.ROLE_SKILL_START_MIN
const ROLE_SKILL_START_MAX: int = StoneAgeTuning.ROLE_SKILL_START_MAX

const HUNTER_HEALTH_PER_LEVEL: int = StoneAgeTuning.HUNTER_HEALTH_PER_LEVEL
const WARRIOR_HEALTH_PER_LEVEL: int = StoneAgeTuning.WARRIOR_HEALTH_PER_LEVEL

const HUNTER_BASE_ATTACK: int = StoneAgeTuning.HUNTER_BASE_ATTACK
const HUNTER_BASE_DEFENSE: int = StoneAgeTuning.HUNTER_BASE_DEFENSE
const WARRIOR_BASE_ATTACK: int = StoneAgeTuning.WARRIOR_BASE_ATTACK
const WARRIOR_BASE_DEFENSE: int = StoneAgeTuning.WARRIOR_BASE_DEFENSE

const THINKER_BASE_RESEARCH_PER_SECOND: float = StoneAgeTuning.THINKER_BASE_RESEARCH_PER_SECOND
const THINKER_RESEARCH_BONUS_PER_THINKING_LEVEL: float = StoneAgeTuning.THINKER_RESEARCH_BONUS_PER_THINKING_LEVEL

const DEFAULT_ROLE_TOOL_SLOTS: int = StoneAgeTuning.DEFAULT_ROLE_TOOL_SLOTS
const DEFAULT_COMBAT_TOOL_SLOTS: int = StoneAgeTuning.DEFAULT_COMBAT_TOOL_SLOTS
const DEFAULT_COMBAT_WEAPON_SLOTS: int = StoneAgeTuning.DEFAULT_COMBAT_WEAPON_SLOTS
const DEFAULT_COMBAT_ARMOR_SLOTS: int = StoneAgeTuning.DEFAULT_COMBAT_ARMOR_SLOTS

const SKILL_GATHERING: String = "gathering"
const SKILL_BUILDING: String = "building"
const SKILL_MINING: String = "mining"
const SKILL_WOODCUTTING: String = "woodcutting"

const SKILL_CRAFTING: String = "crafting"
const SKILL_THINKING: String = "thinking"
const SKILL_STONEWORKING: String = "stoneworking"
const SKILL_WOODWORKING: String = "woodworking"
const SKILL_RITUALS: String = "rituals"

const SKILL_HUNTING: String = "hunting"
const SKILL_RANGED_WEAPONS: String = "ranged_weapons"
const SKILL_MELEE_WEAPONS: String = "melee_weapons"
const SKILL_EVADE: String = "evade"
const SKILL_PARRY: String = "parry"

# Compatibility aliases for older references inside the project.
const SKILL_WOOD_WORKING: String = SKILL_WOODCUTTING
const SKILL_STONE_WORKING: String = SKILL_STONEWORKING

# Removed/legacy skill aliases kept so older Stone Age data files still parse.
const SKILL_HAULING: String = "hauling"
const SKILL_MEDICINE: String = "medicine"

const SKILL_HARVEST_SPEED_BONUS_PER_LEVEL: float = CoreTuning.SKILL_HARVEST_SPEED_BONUS_PER_LEVEL
const MAX_SKILL_LEVEL: int = CoreTuning.DEFAULT_SKILL_CAP

const BASE_SKILL_IDS: Array = [
    SKILL_GATHERING,
    SKILL_BUILDING,
    SKILL_MINING,
    SKILL_WOODCUTTING
]

const ROLE_SKILL_IDS: Array = [
    SKILL_CRAFTING,
    SKILL_THINKING,
    SKILL_STONEWORKING,
    SKILL_WOODWORKING,
    SKILL_RITUALS,
    SKILL_HUNTING,
    SKILL_RANGED_WEAPONS,
    SKILL_MELEE_WEAPONS,
    SKILL_EVADE,
    SKILL_PARRY
]

const SKILL_IDS: Array = [
    SKILL_GATHERING,
    SKILL_BUILDING,
    SKILL_MINING,
    SKILL_WOODCUTTING,
    SKILL_CRAFTING,
    SKILL_THINKING,
    SKILL_STONEWORKING,
    SKILL_WOODWORKING,
    SKILL_RITUALS,
    SKILL_HUNTING,
    SKILL_RANGED_WEAPONS,
    SKILL_MELEE_WEAPONS,
    SKILL_EVADE,
    SKILL_PARRY
]

const RESOURCE_WOOD: String = "wood"
const RESOURCE_BERRIES: String = "berries"
const RESOURCE_MUSHROOMS: String = "mushrooms"
const RESOURCE_STONE: String = "stone"
const RESOURCE_FLINT: String = "flint"
const RESOURCE_REEDS: String = "reeds"
const RESOURCE_CLAY: String = "clay"
const RESOURCE_FISH: String = "fish"
const RESOURCE_FIBER: String = "fiber"
const RESOURCE_HIDE: String = "hide"

const RESOURCE_HARVEST_RULES: Dictionary = {
    RESOURCE_WOOD: {
        "base_harvest_time": 2.5,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_STONE: {
        "base_harvest_time": 2.8,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_FLINT: {
        "base_harvest_time": 2.2,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_BERRIES: {
        "base_harvest_time": 1.2,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_MUSHROOMS: {
        "base_harvest_time": 1.4,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_REEDS: {
        "base_harvest_time": 1.6,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_CLAY: {
        "base_harvest_time": 2.0,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_FIBER: {
        "base_harvest_time": 1.4,
        "base_yield_multiplier": 1.0
    },
    RESOURCE_FISH: {
        "base_harvest_time": 2.0,
        "base_yield_multiplier": 1.0
    }
}

var villagers: Array = []
var next_villager_id: int = 1

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0
var region_tile_size: int = 16

var terrain_grass: String = ""
var terrain_water: String = ""
var feature_none: String = ""

var harvested_resources_this_frame: Dictionary = {}
var event_messages_this_frame: Array = []
var did_change_tiles: bool = false
var research_progress_this_frame: float = 0.0

var rng := RandomNumberGenerator.new()

var harvest_speed_multiplier: float = 1.0
var harvest_yield_multiplier: float = 1.0
var global_movement_speed_bonus: float = 0.0
var global_belonging_slot_bonus: int = 0
var population_growth_timer: float = 0.0


func setup(
    new_region_tiles: Array,
    new_region_width: int,
    new_region_height: int,
    new_region_tile_size: int,
    grass_terrain_id: String,
    water_terrain_id: String,
    none_feature_id: String
) -> void:
    region_tiles = new_region_tiles
    region_width = new_region_width
    region_height = new_region_height
    region_tile_size = new_region_tile_size
    terrain_grass = grass_terrain_id
    terrain_water = water_terrain_id
    feature_none = none_feature_id

    rng.randomize()

func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_VILLAGERS: get_save_safe_value(villagers),
        SAVE_KEY_NEXT_VILLAGER_ID: next_villager_id,
        SAVE_KEY_POPULATION_GROWTH_TIMER: population_growth_timer,
        SAVE_KEY_HARVEST_SPEED_MULTIPLIER: harvest_speed_multiplier,
        SAVE_KEY_HARVEST_YIELD_MULTIPLIER: harvest_yield_multiplier,
        SAVE_KEY_GLOBAL_MOVEMENT_SPEED_BONUS: global_movement_speed_bonus,
        SAVE_KEY_GLOBAL_BELONGING_SLOT_BONUS: global_belonging_slot_bonus
    }


func load_save_data(save_data: Dictionary) -> void:
    villagers.clear()
    next_villager_id = 1
    population_growth_timer = 0.0
    harvested_resources_this_frame.clear()
    event_messages_this_frame.clear()
    did_change_tiles = false
    research_progress_this_frame = 0.0
    harvest_speed_multiplier = 1.0
    harvest_yield_multiplier = 1.0
    global_movement_speed_bonus = 0.0
    global_belonging_slot_bonus = 0

    if save_data.is_empty():
        return

    next_villager_id = max(1, int(save_data.get(SAVE_KEY_NEXT_VILLAGER_ID, 1)))
    population_growth_timer = max(0.0, float(save_data.get(SAVE_KEY_POPULATION_GROWTH_TIMER, 0.0)))
    harvest_speed_multiplier = max(0.1, float(save_data.get(SAVE_KEY_HARVEST_SPEED_MULTIPLIER, 1.0)))
    harvest_yield_multiplier = max(0.1, float(save_data.get(SAVE_KEY_HARVEST_YIELD_MULTIPLIER, 1.0)))
    global_movement_speed_bonus = max(0.0, float(save_data.get(SAVE_KEY_GLOBAL_MOVEMENT_SPEED_BONUS, 0.0)))
    global_belonging_slot_bonus = max(0, int(save_data.get(SAVE_KEY_GLOBAL_BELONGING_SLOT_BONUS, 0)))

    var saved_villagers_variant: Variant = save_data.get(SAVE_KEY_VILLAGERS, [])
    var restored_villagers_variant: Variant = restore_save_safe_value(saved_villagers_variant)

    if typeof(restored_villagers_variant) != TYPE_ARRAY:
        return

    var restored_villagers: Array = restored_villagers_variant

    for villager_index in range(restored_villagers.size()):
        var villager_variant: Variant = restored_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_id: int = int(villager_data.get("id", 0))

        if villager_id <= 0:
            continue

        sanitize_loaded_villager_data(villager_data)
        villagers.append(villager_data)

        if villager_id >= next_villager_id:
            next_villager_id = villager_id + 1

    update_all_villager_speed_stats()
    update_all_villager_belonging_caps()


func sanitize_loaded_villager_data(villager_data: Dictionary) -> void:
    var fallback_tile := Vector2i(region_width / 2, region_height / 2)

    var tile: Vector2i = villager_data.get("tile", fallback_tile)

    if not is_tile_in_bounds(tile):
        tile = find_nearest_available_spawn_tile(fallback_tile)

        if not is_tile_in_bounds(tile):
            tile = fallback_tile

    villager_data["tile"] = tile
    villager_data["world_position"] = tile_to_world_center(tile)

    if not villager_data.has("state"):
        villager_data["state"] = VILLAGER_STATE_IDLE

    if not villager_data.has("role"):
        villager_data["role"] = StoneAgeVillagerAssignmentData.get_default_role()

    if not villager_data.has("assigned_building_instance_id"):
        villager_data["assigned_building_instance_id"] = 0

    if not villager_data.has("assigned_building_role"):
        villager_data["assigned_building_role"] = ""

    if not villager_data.has("assignment_replaces_shelter"):
        villager_data["assignment_replaces_shelter"] = false

    if not villager_data.has("assigned_work_anchor_tile"):
        villager_data["assigned_work_anchor_tile"] = NO_ASSIGNED_AREA

    if not villager_data.has("assigned_work_radius"):
        villager_data["assigned_work_radius"] = DEFAULT_ASSIGNED_WORK_RADIUS

    if not villager_data.has("target_tile"):
        villager_data["target_tile"] = Vector2i(-1, -1)

    if not villager_data.has("harvest_tile"):
        villager_data["harvest_tile"] = Vector2i(-1, -1)

    if not villager_data.has("assigned_harvest_center"):
        villager_data["assigned_harvest_center"] = NO_ASSIGNED_AREA

    if not villager_data.has("assigned_harvest_radius"):
        villager_data["assigned_harvest_radius"] = 0

    if not villager_data.has("skills"):
        villager_data["skills"] = {}

    if not villager_data.has("health"):
        villager_data["health"] = BASE_HEALTH

    if not villager_data.has("max_health"):
        villager_data["max_health"] = BASE_HEALTH

    if not villager_data.has("hunger"):
        villager_data["hunger"] = HUNGER_FULL

    if not villager_data.has("base_speed"):
        villager_data["base_speed"] = BASE_SPEED

    if not villager_data.has("belongings"):
        villager_data["belongings"] = []

    if not villager_data.has("statuses"):
        villager_data["statuses"] = []

    if not villager_data.has("health_state"):
        villager_data["health_state"] = HEALTH_STATE_HEALTHY

    if not villager_data.has("move_timer"):
        villager_data["move_timer"] = 0.0

    if not villager_data.has("harvest_timer"):
        villager_data["harvest_timer"] = 0.0

    if not villager_data.has("current_work_task"):
        villager_data["current_work_task"] = ""
        
    if not villager_data.has("hunting_animal_instance_id"):
        villager_data["hunting_animal_instance_id"] = 0

    if not villager_data.has("hunting_target_tile"):
        villager_data["hunting_target_tile"] = Vector2i(-1, -1)

    if not villager_data.has("hunting_return_tile"):
        villager_data["hunting_return_tile"] = Vector2i(-1, -1)

    if not villager_data.has("hunting_phase"):
        villager_data["hunting_phase"] = HUNTING_PHASE_NONE

    recalculate_villager_level(villager_data)
    apply_slot_counts_for_role(villager_data)
    refresh_role_stats_for_villager(villager_data)


func get_save_safe_value(value: Variant) -> Variant:
    match typeof(value):
        TYPE_VECTOR2I:
            var vector_i_value: Vector2i = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2I,
                "x": vector_i_value.x,
                "y": vector_i_value.y
            }

        TYPE_VECTOR2:
            var vector_value: Vector2 = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2,
                "x": vector_value.x,
                "y": vector_value.y
            }

        TYPE_DICTIONARY:
            var source_dict: Dictionary = value
            var output_dict: Dictionary = {}
            var keys: Array = source_dict.keys()

            for key_index in range(keys.size()):
                var key_variant: Variant = keys[key_index]
                var key_string: String = str(key_variant)

                output_dict[key_string] = get_save_safe_value(source_dict.get(key_variant))

            return output_dict

        TYPE_ARRAY:
            var source_array: Array = value
            var output_array: Array = []

            for value_index in range(source_array.size()):
                output_array.append(get_save_safe_value(source_array[value_index]))

            return output_array

        _:
            return value


func restore_save_safe_value(value: Variant) -> Variant:
    if typeof(value) == TYPE_DICTIONARY:
        var source_dict: Dictionary = value
        var save_type: String = str(source_dict.get(SAVE_TYPE_KEY, ""))

        if save_type == SAVE_TYPE_VECTOR2I:
            return Vector2i(
                int(source_dict.get("x", 0)),
                int(source_dict.get("y", 0))
            )

        if save_type == SAVE_TYPE_VECTOR2:
            return Vector2(
                float(source_dict.get("x", 0.0)),
                float(source_dict.get("y", 0.0))
            )

        var restored_dict: Dictionary = {}
        var keys: Array = source_dict.keys()

        for key_index in range(keys.size()):
            var key_variant: Variant = keys[key_index]
            var key_string: String = str(key_variant)

            restored_dict[key_string] = restore_save_safe_value(source_dict.get(key_variant))

        return restored_dict

    if typeof(value) == TYPE_ARRAY:
        var source_array: Array = value
        var restored_array: Array = []

        for value_index in range(source_array.size()):
            restored_array.append(restore_save_safe_value(source_array[value_index]))

        return restored_array

    return value

func reset_and_spawn_starting_villagers() -> void:
    villagers.clear()
    next_villager_id = 1
    population_growth_timer = 0.0
    event_messages_this_frame.clear()
    global_movement_speed_bonus = 0.0
    global_belonging_slot_bonus = 0
    research_progress_this_frame = 0.0

    var center := Vector2i(region_width / 2, region_height / 2)

    var spawn_offsets: Array = [
        Vector2i(0, 0),
        Vector2i(1, 0),
        Vector2i(-1, 0),
        Vector2i(0, 1),
        Vector2i(0, -1),
        Vector2i(1, 1),
        Vector2i(-1, 1),
        Vector2i(1, -1),
        Vector2i(-1, -1),
        Vector2i(2, 0),
        Vector2i(-2, 0),
        Vector2i(0, 2),
        Vector2i(0, -2)
    ]

    var spawned_count: int = 0

    for offset_index in range(spawn_offsets.size()):
        if spawned_count >= STARTING_POPULATION:
            break

        var offset_variant: Variant = spawn_offsets[offset_index]
        var offset: Vector2i = offset_variant
        var requested_tile: Vector2i = center + offset
        var spawn_tile: Vector2i = find_nearest_available_spawn_tile(requested_tile)

        if not is_tile_in_bounds(spawn_tile):
            continue

        spawn_villager_at_tile(spawn_tile)
        spawned_count += 1

    while spawned_count < STARTING_POPULATION:
        var fallback_tile: Vector2i = find_nearest_available_spawn_tile(center)

        if not is_tile_in_bounds(fallback_tile):
            break

        spawn_villager_at_tile(fallback_tile)
        spawned_count += 1

    update_all_villager_speed_stats()
    update_all_villager_belonging_caps()

    print("Starting Population: ", villagers.size())
    print_villager_roster()


func set_global_movement_speed_bonus(new_bonus: float) -> void:
    global_movement_speed_bonus = max(0.0, new_bonus)
    update_all_villager_speed_stats()


func get_current_max_belongings() -> int:
    return clampi(
        BASE_BELONGING_SLOTS + global_belonging_slot_bonus,
        BASE_BELONGING_SLOTS,
        STONE_AGE_MAX_BELONGING_SLOTS
    )


func set_global_belonging_slot_bonus(new_bonus: int) -> void:
    global_belonging_slot_bonus = max(0, new_bonus)
    update_all_villager_belonging_caps()


func update_all_villager_belonging_caps() -> void:
    var max_slots: int = get_current_max_belongings()

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        villager_data["max_belongings"] = max_slots
        villager_data["belonging_slots"] = max_slots
        villagers[villager_index] = villager_data


func get_movement_speed_multiplier_for_villager(villager_data: Dictionary) -> float:
    var speed: int = int(villager_data.get("speed", BASE_SPEED))

    return max(
        0.1,
        float(speed) / float(BASE_SPEED)
    )


func get_adjusted_move_interval_for_villager(villager_data: Dictionary) -> float:
    return VILLAGER_MOVE_INTERVAL / get_movement_speed_multiplier_for_villager(villager_data)


func update_all_villager_speed_stats() -> void:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        update_villager_speed_stat(villager_data)
        villagers[villager_index] = villager_data


func update_villager_speed_stat(villager_data: Dictionary) -> void:
    var base_speed: int = int(villager_data.get("base_speed", BASE_SPEED))
    var bonus_speed: int = int(round(float(BASE_SPEED) * global_movement_speed_bonus))

    villager_data["base_speed"] = base_speed
    villager_data["speed"] = max(MIN_SPEED, base_speed + bonus_speed)


func get_skill_cap(_villager_data: Dictionary, _skill_id: String) -> int:
    return MAX_SKILL_LEVEL


func clamp_skill_level(
    villager_data: Dictionary,
    skill_id: String,
    skill_level: int
) -> int:
    return clampi(
        skill_level,
        0,
        get_skill_cap(villager_data, skill_id)
    )


func get_villager_level_from_skills(skills: Dictionary) -> int:
    if skills.is_empty():
        return 0

    var total_skill_levels: int = 0
    var counted_skills: int = 0

    var skill_keys: Array = skills.keys()

    for skill_index in range(skill_keys.size()):
        var skill_id: String = str(skill_keys[skill_index])

        if not SKILL_IDS.has(skill_id):
            continue

        total_skill_levels += int(skills.get(skill_id, 0))
        counted_skills += 1

    if counted_skills <= 0:
        return 0

    return int(floor(float(total_skill_levels) / float(counted_skills)))


func recalculate_villager_level(villager_data: Dictionary) -> void:
    var skills: Dictionary = villager_data.get("skills", {})
    villager_data["level"] = get_villager_level_from_skills(skills)


func process_population_growth(
    delta: float,
    normal_housing_capacity: int
) -> void:
    population_growth_timer += delta

    if population_growth_timer < POPULATION_GROWTH_INTERVAL:
        return

    population_growth_timer -= POPULATION_GROWTH_INTERVAL

    var normal_shelter_demand: int = get_normal_shelter_demand_count()

    if normal_housing_capacity <= normal_shelter_demand:
        add_event_message(
            "Population growth skipped. Housing is full: "
            + str(normal_shelter_demand)
            + "/"
            + str(normal_housing_capacity)
        )
        return

    var roll: float = rng.randf()

    print("Population growth check. Roll: ", roll, " Chance: ", POPULATION_GROWTH_CHANCE)

    if roll > POPULATION_GROWTH_CHANCE:
        add_event_message("No new villager joined this time.")
        return

    spawn_new_villager_near_village_center()
    auto_assign_villager_housing(normal_housing_capacity)


func auto_assign_villager_housing(normal_housing_capacity: int) -> void:
    var housed_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if bool(villager_data.get("assignment_replaces_shelter", false)):
            villager_data["is_housed"] = true
            villagers[villager_index] = villager_data
            continue

        if housed_count < normal_housing_capacity:
            villager_data["is_housed"] = true
            housed_count += 1
        else:
            villager_data["is_housed"] = false

        villagers[villager_index] = villager_data


func get_housed_villager_count() -> int:
    var housed_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if bool(villager_data.get("is_housed", false)):
            housed_count += 1

    return housed_count


func spawn_new_villager_near_village_center() -> bool:
    var spawn_origin: Vector2i = get_village_spawn_center()
    var spawn_tile: Vector2i = find_nearest_available_spawn_tile(spawn_origin)

    if not is_tile_in_bounds(spawn_tile):
        add_event_message("Population growth succeeded, but no valid spawn tile was found.")
        return false

    spawn_villager_at_tile(spawn_tile)

    var newest_villager: Dictionary = villagers[villagers.size() - 1]
    var newest_name: String = str(newest_villager.get("name", "A villager"))

    add_event_message(
        newest_name + " joined the village. Population: " + str(villagers.size())
    )

    print_villager_summary(newest_villager)

    return true


func debug_add_villagers(
    requested_amount: int,
    normal_housing_capacity: int
) -> Dictionary:
    var result: Dictionary = {
        "requested": requested_amount,
        "spawned": 0,
        "message": ""
    }

    if requested_amount <= 0:
        result["message"] = "Debug: no villagers requested."
        return result

    var normal_shelter_demand: int = get_normal_shelter_demand_count()

    var open_shelter_slots: int = max(
        0,
        normal_housing_capacity - normal_shelter_demand
    )

    if open_shelter_slots <= 0:
        result["message"] = (
            "Debug: no open shelter available. Shelter demand "
            + str(normal_shelter_demand)
            + "/"
            + str(normal_housing_capacity)
            + "."
        )
        return result

    var amount_to_spawn: int = min(
        requested_amount,
        open_shelter_slots
    )

    var spawned_names: Array = []

    for spawn_index in range(amount_to_spawn):
        var did_spawn: bool = spawn_new_villager_near_village_center()

        if not did_spawn:
            break

        var newest_villager: Dictionary = villagers[villagers.size() - 1]
        spawned_names.append(str(newest_villager.get("name", "Villager")))

    auto_assign_villager_housing(normal_housing_capacity)
    update_all_villager_speed_stats()

    var spawned_count: int = spawned_names.size()
    result["spawned"] = spawned_count

    var new_normal_shelter_demand: int = get_normal_shelter_demand_count()

    if spawned_count <= 0:
        result["message"] = "Debug: no valid spawn tile was found."
        return result

    if spawned_count < requested_amount:
        result["message"] = (
            "Debug: added "
            + str(spawned_count)
            + " of "
            + str(requested_amount)
            + " requested villagers. Shelter demand "
            + str(new_normal_shelter_demand)
            + "/"
            + str(normal_housing_capacity)
            + "."
        )
        return result

    result["message"] = (
        "Debug: added "
        + str(spawned_count)
        + " villagers. Shelter demand "
        + str(new_normal_shelter_demand)
        + "/"
        + str(normal_housing_capacity)
        + "."
    )

    return result


func spawn_villager_at_tile(
    spawn_tile: Vector2i,
    _forced_specialist_skill: String = ""
) -> void:
    var used_names: Array = get_used_villager_names()
    var gender: String = VillagerNameGenerator.generate_gender(rng)
    var villager_name: String = VillagerNameGenerator.generate_name(
        rng,
        gender,
        used_names,
        CURRENT_NAME_ERA
    )

    var generated_skills: Dictionary = generate_villager_skills()
    var villager_level: int = get_villager_level_from_skills(generated_skills)
    var generated_base_speed: int = rng.randi_range(MIN_BASE_SPEED, MAX_BASE_SPEED)

    var villager_data := {
        "id": next_villager_id,
        "name": villager_name,
        "gender": gender,
        "tile": spawn_tile,
        "world_position": tile_to_world_center(spawn_tile),
        "state": VILLAGER_STATE_IDLE,
        "role": StoneAgeVillagerAssignmentData.get_default_role(),
        "assigned_building_instance_id": 0,
        "assigned_building_role": "",
        "assignment_replaces_shelter": false,
        "assigned_work_anchor_tile": NO_ASSIGNED_AREA,
        "assigned_work_radius": DEFAULT_ASSIGNED_WORK_RADIUS,
        "current_work_task": "",
        "hunting_animal_instance_id": 0,
        "hunting_target_tile": Vector2i(-1, -1),
        "hunting_return_tile": Vector2i(-1, -1),
        "hunting_phase": HUNTING_PHASE_NONE,
        "target_tile": Vector2i(-1, -1),
        "harvest_tile": Vector2i(-1, -1),
        "move_timer": 0.0,
        "harvest_timer": 0.0,
        "assigned_harvest_center": NO_ASSIGNED_AREA,
        "assigned_harvest_radius": 0,
        "is_housed": false,
        "skills": generated_skills,
        "level": villager_level,
        "health": BASE_HEALTH,
        "max_health": BASE_HEALTH,
        "hunger": HUNGER_FULL,
        "base_speed": generated_base_speed,
        "speed": generated_base_speed,
        "belongings": [],
        "max_belongings": get_current_max_belongings(),
        "belonging_slots": get_current_max_belongings(),
        "tool_slots": 0,
        "weapon_slots": 0,
        "armor_slots": 0,
        "statuses": [],
        "health_state": HEALTH_STATE_HEALTHY
    }

    update_villager_speed_stat(villager_data)
    villagers.append(villager_data)
    next_villager_id += 1


func generate_villager_skills(_forced_specialist_skill: String = "") -> Dictionary:
    var generated_skills: Dictionary = {}

    for skill_index in range(BASE_SKILL_IDS.size()):
        var skill_id: String = str(BASE_SKILL_IDS[skill_index])
        generated_skills[skill_id] = rng.randi_range(
            BASE_SKILL_START_MIN,
            BASE_SKILL_START_MAX
        )

    return generated_skills


func get_random_skill_excluding(excluded_skills: Array) -> String:
    var valid_skills: Array = []

    for skill_index in range(BASE_SKILL_IDS.size()):
        var skill_id: String = str(BASE_SKILL_IDS[skill_index])

        if excluded_skills.has(skill_id):
            continue

        valid_skills.append(skill_id)

    if valid_skills.is_empty():
        return str(BASE_SKILL_IDS[0])

    return str(valid_skills[rng.randi_range(0, valid_skills.size() - 1)])


func get_used_villager_names() -> Array:
    var used_names: Array = []

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        used_names.append(str(villager_data.get("name", "")))

    return used_names


func get_village_spawn_center() -> Vector2i:
    if villagers.is_empty():
        return Vector2i(region_width / 2, region_height / 2)

    var total_x: int = 0
    var total_y: int = 0
    var counted_villagers: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_tile: Vector2i = villager_data.get(
            "tile",
            Vector2i(region_width / 2, region_height / 2)
        )

        total_x += villager_tile.x
        total_y += villager_tile.y
        counted_villagers += 1

    if counted_villagers <= 0:
        return Vector2i(region_width / 2, region_height / 2)

    return Vector2i(
        int(round(float(total_x) / float(counted_villagers))),
        int(round(float(total_y) / float(counted_villagers)))
    )


func find_nearest_available_spawn_tile(origin_tile: Vector2i) -> Vector2i:
    if is_tile_in_bounds(origin_tile):
        if is_tile_walkable_for_villager(origin_tile) and not is_villager_on_tile(origin_tile):
            return origin_tile

    for radius in range(1, 20):
        for y in range(origin_tile.y - radius, origin_tile.y + radius + 1):
            for x in range(origin_tile.x - radius, origin_tile.x + radius + 1):
                var tile_position := Vector2i(x, y)

                if not is_tile_in_bounds(tile_position):
                    continue

                if not is_tile_walkable_for_villager(tile_position):
                    continue

                if is_villager_on_tile(tile_position):
                    continue

                return tile_position

    return Vector2i(-1, -1)


func update(
    delta: float,
    inventory: RegionInventory,
    normal_housing_capacity: int
) -> Dictionary:
    harvested_resources_this_frame.clear()
    event_messages_this_frame.clear()
    did_change_tiles = false
    research_progress_this_frame = 0.0

    update_all_villager_speed_stats()
    auto_assign_villager_housing(normal_housing_capacity)
    process_population_growth(delta, normal_housing_capacity)

    if villagers.is_empty():
        return harvested_resources_this_frame

    for villager_index in range(villagers.size()):
        process_villager(villager_index, delta, inventory)

    return harvested_resources_this_frame.duplicate(true)


func has_tile_changes() -> bool:
    return did_change_tiles


func get_event_messages() -> Array:
    return event_messages_this_frame.duplicate(true)


func get_research_progress_this_frame() -> float:
    return research_progress_this_frame


func add_event_message(message: String) -> void:
    if message == "":
        return

    event_messages_this_frame.append(message)
    print(message)


func get_population_count() -> int:
    return villagers.size()


func get_villagers() -> Array:
    return villagers


func get_villager_data_by_id(villager_id: int) -> Dictionary:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("id", 0)) == villager_id:
            return villager_data.duplicate(true)

    return {}


func get_villager_index_by_id(villager_id: int) -> int:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("id", 0)) == villager_id:
            return villager_index

    return -1


func get_unassigned_villagers() -> Array:
    var unassigned_villagers: Array = []

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if str(villager_data.get("health_state", HEALTH_STATE_HEALTHY)) == HEALTH_STATE_DEAD:
            continue

        var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

        if assigned_building_instance_id > 0:
            continue

        unassigned_villagers.append(villager_data.duplicate(true))

    return unassigned_villagers


func is_villager_assigned_to_building(villager_id: int) -> bool:
    var villager_data: Dictionary = get_villager_data_by_id(villager_id)

    if villager_data.is_empty():
        return false

    return int(villager_data.get("assigned_building_instance_id", 0)) > 0


func assign_villager_to_building_assignment(
    villager_id: int,
    building_instance_id: int,
    assignment_role: String,
    replaces_shelter: bool
) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": ""
    }

    if villager_id <= 0:
        result["message"] = "Invalid villager."
        return result

    if building_instance_id <= 0:
        result["message"] = "Invalid building."
        return result

    if assignment_role == "":
        result["message"] = "Building has no assignment role."
        return result

    var villager_index: int = get_villager_index_by_id(villager_id)

    if villager_index < 0:
        result["message"] = "Villager not found."
        return result

    var villager_data: Dictionary = villagers[villager_index]
    var villager_name: String = str(villager_data.get("name", "Villager"))
    var current_role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var default_role: String = StoneAgeVillagerAssignmentData.get_default_role()
    var display_role: String = StoneAgeVillagerAssignmentData.get_role_display_name(assignment_role)
    var current_display_role: String = StoneAgeVillagerAssignmentData.get_role_display_name(current_role)

    if current_role != default_role and current_role != assignment_role:
        result["message"] = (
            villager_name
            + " is already a "
            + current_display_role
            + " and can only be assigned to matching "
            + current_display_role
            + " buildings."
        )
        return result

    if current_role == default_role:
        apply_role_specialization_to_villager(
            villager_data,
            assignment_role
        )
    else:
        refresh_role_stats_for_villager(villager_data)

    villager_data["assigned_building_instance_id"] = building_instance_id
    villager_data["assigned_building_role"] = assignment_role
    villager_data["assignment_replaces_shelter"] = replaces_shelter
    villager_data["assigned_work_radius"] = DEFAULT_ASSIGNED_WORK_RADIUS

# Building assignments override manual harvest-area assignments.
    villager_data["assigned_harvest_center"] = NO_ASSIGNED_AREA
    villager_data["assigned_harvest_radius"] = 0

    villager_data["current_work_task"] = ""
    villager_data["target_tile"] = Vector2i(-1, -1)
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["move_timer"] = 0.0
    villager_data["harvest_timer"] = 0.0

    if not villager_data.has("assigned_work_anchor_tile"):
        villager_data["assigned_work_anchor_tile"] = NO_ASSIGNED_AREA

    if assignment_role == StoneAgeVillagerAssignmentData.ROLE_THINKER:
        villager_data["state"] = VILLAGER_STATE_THINKING
        villager_data["current_work_task"] = "thinking"
    elif assignment_role == StoneAgeVillagerAssignmentData.ROLE_HUNTER:
        villager_data["state"] = VILLAGER_STATE_PATROLLING
        villager_data["current_work_task"] = "hunting_placeholder"
    elif assignment_role == StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
        villager_data["state"] = VILLAGER_STATE_PATROLLING
        villager_data["current_work_task"] = "patrolling"
    else:
        villager_data["state"] = VILLAGER_STATE_WAITING_AT_BUILDING
        villager_data["current_work_task"] = "waiting_at_building"

    villagers[villager_index] = villager_data

    result["success"] = true
    result["message"] = (
        villager_name
        + " assigned as "
        + display_role
        + "."
    )

    return result


func clear_villager_building_assignment(villager_id: int) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": ""
    }

    if villager_id <= 0:
        result["message"] = "Invalid villager."
        return result

    var villager_index: int = get_villager_index_by_id(villager_id)

    if villager_index < 0:
        result["message"] = "Villager not found."
        return result

    var villager_data: Dictionary = villagers[villager_index]
    var villager_name: String = str(villager_data.get("name", "Villager"))

    villager_data["assigned_building_instance_id"] = 0
    villager_data["assigned_building_role"] = ""
    villager_data["assignment_replaces_shelter"] = false
    villager_data["assigned_work_anchor_tile"] = NO_ASSIGNED_AREA
    villager_data["assigned_work_radius"] = DEFAULT_ASSIGNED_WORK_RADIUS
    villager_data["current_work_task"] = ""
    villager_data["target_tile"] = Vector2i(-1, -1)
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["move_timer"] = 0.0
    villager_data["harvest_timer"] = 0.0
    villager_data["hunting_animal_instance_id"] = 0
    villager_data["hunting_target_tile"] = Vector2i(-1, -1)
    villager_data["hunting_return_tile"] = Vector2i(-1, -1)
    villager_data["hunting_phase"] = HUNTING_PHASE_NONE

    if str(villager_data.get("state", VILLAGER_STATE_IDLE)) in [
        VILLAGER_STATE_THINKING,
        
        VILLAGER_STATE_WAITING_AT_BUILDING,
        VILLAGER_STATE_PATROLLING
    ]:
        villager_data["state"] = VILLAGER_STATE_IDLE

    if not villager_data.has("role"):
        villager_data["role"] = StoneAgeVillagerAssignmentData.get_default_role()

    villagers[villager_index] = villager_data

    result["success"] = true
    result["message"] = villager_name + " is no longer assigned to a building."

    return result


func apply_role_specialization_to_villager(
    villager_data: Dictionary,
    new_role: String
) -> void:
    villager_data["role"] = new_role

    add_role_skills_if_missing(
        villager_data,
        get_skill_ids_for_role(new_role)
    )

    recalculate_villager_level(villager_data)
    apply_slot_counts_for_role(villager_data)
    refresh_role_stats_for_villager(villager_data)


func refresh_role_stats_for_villager(villager_data: Dictionary) -> void:
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))

    recalculate_villager_level(villager_data)

    var level: int = int(villager_data.get("level", 0))

    if role == StoneAgeVillagerAssignmentData.ROLE_HUNTER:
        villager_data["max_health"] = BASE_HEALTH + level * HUNTER_HEALTH_PER_LEVEL
        villager_data["health"] = int(villager_data.get("max_health", BASE_HEALTH))
        villager_data["attack"] = HUNTER_BASE_ATTACK + level
        villager_data["defense"] = HUNTER_BASE_DEFENSE + level
        return

    if role == StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
        villager_data["max_health"] = BASE_HEALTH + level * WARRIOR_HEALTH_PER_LEVEL
        villager_data["health"] = int(villager_data.get("max_health", BASE_HEALTH))
        villager_data["attack"] = WARRIOR_BASE_ATTACK + level
        villager_data["defense"] = WARRIOR_BASE_DEFENSE + level
        return

    villager_data["max_health"] = BASE_HEALTH
    villager_data["health"] = min(
        int(villager_data.get("health", BASE_HEALTH)),
        BASE_HEALTH
    )

    if villager_data.has("attack"):
        villager_data.erase("attack")

    if villager_data.has("defense"):
        villager_data.erase("defense")


func add_role_skills_if_missing(
    villager_data: Dictionary,
    role_skill_ids: Array
) -> void:
    var skills: Dictionary = villager_data.get("skills", {})

    for skill_index in range(role_skill_ids.size()):
        var skill_id: String = str(role_skill_ids[skill_index])

        if skills.has(skill_id):
            skills[skill_id] = clamp_skill_level(
                villager_data,
                skill_id,
                int(skills.get(skill_id, 0))
            )
            continue

        skills[skill_id] = rng.randi_range(
            ROLE_SKILL_START_MIN,
            ROLE_SKILL_START_MAX
        )

    villager_data["skills"] = skills


func get_skill_ids_for_role(role_id: String) -> Array:
    match role_id:
        StoneAgeVillagerAssignmentData.ROLE_MAKER:
            return [SKILL_CRAFTING]

        StoneAgeVillagerAssignmentData.ROLE_THINKER:
            return [SKILL_THINKING]

        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER:
            return [SKILL_STONEWORKING]

        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER:
            return [SKILL_WOODWORKING]

        StoneAgeVillagerAssignmentData.ROLE_HUNTER:
            return [
            SKILL_HUNTING,
            SKILL_RANGED_WEAPONS,
            SKILL_EVADE
    ]

        StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
            return [
                SKILL_MELEE_WEAPONS,
                SKILL_PARRY
            ]

        StoneAgeVillagerAssignmentData.ROLE_RITUALIST:
            return [SKILL_RITUALS]

        _:
            return []


func apply_slot_counts_for_role(villager_data: Dictionary) -> void:
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))

    villager_data["belonging_slots"] = get_current_max_belongings()
    villager_data["max_belongings"] = get_current_max_belongings()
    villager_data["tool_slots"] = 0
    villager_data["weapon_slots"] = 0
    villager_data["armor_slots"] = 0

    match role:
        StoneAgeVillagerAssignmentData.ROLE_MAKER:
            villager_data["tool_slots"] = DEFAULT_ROLE_TOOL_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_THINKER:
            villager_data["tool_slots"] = DEFAULT_ROLE_TOOL_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER:
            villager_data["tool_slots"] = DEFAULT_ROLE_TOOL_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER:
            villager_data["tool_slots"] = DEFAULT_ROLE_TOOL_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_RITUALIST:
            villager_data["tool_slots"] = DEFAULT_ROLE_TOOL_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_HUNTER:
            villager_data["tool_slots"] = DEFAULT_COMBAT_TOOL_SLOTS
            villager_data["weapon_slots"] = DEFAULT_COMBAT_WEAPON_SLOTS
            villager_data["armor_slots"] = DEFAULT_COMBAT_ARMOR_SLOTS

        StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
            villager_data["tool_slots"] = DEFAULT_COMBAT_TOOL_SLOTS
            villager_data["weapon_slots"] = DEFAULT_COMBAT_WEAPON_SLOTS
            villager_data["armor_slots"] = DEFAULT_COMBAT_ARMOR_SLOTS


func set_villager_assigned_work_anchor(
    villager_id: int,
    anchor_tile: Vector2i,
    work_radius: int = DEFAULT_ASSIGNED_WORK_RADIUS
) -> bool:
    var villager_index: int = get_villager_index_by_id(villager_id)

    if villager_index < 0:
        return false

    var villager_data: Dictionary = villagers[villager_index]
    villager_data["assigned_work_anchor_tile"] = anchor_tile
    villager_data["assigned_work_radius"] = max(0, work_radius)
    villagers[villager_index] = villager_data

    return true


func get_normal_shelter_demand_count() -> int:
    var shelter_demand_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if bool(villager_data.get("assignment_replaces_shelter", false)):
            continue

        shelter_demand_count += 1

    return shelter_demand_count


func get_villager_at_world_position(world_position: Vector2, hit_radius: float = 8.0) -> int:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_id: int = int(villager_data.get("id", 0))
        var villager_position: Vector2 = villager_data.get("world_position", Vector2.ZERO)

        if villager_position.distance_to(world_position) <= hit_radius:
            return villager_id

    return 0


func get_villager_data_at_world_position(world_position: Vector2, hit_radius: float = 8.0) -> Dictionary:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_position: Vector2 = villager_data.get("world_position", Vector2.ZERO)

        if villager_position.distance_to(world_position) <= hit_radius:
            return villager_data.duplicate(true)

    return {}


func assign_harvest_area(
    villager_id: int,
    center_tile: Vector2i,
    radius: int
) -> void:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("id", 0)) != villager_id:
            continue

        var villager_name: String = str(villager_data.get("name", "Villager"))

        if int(villager_data.get("assigned_building_instance_id", 0)) > 0:
            add_event_message(
                villager_name
                + " is assigned to a building and cannot be given a manual harvest area."
            )
            return

        if not is_tile_in_bounds(center_tile):
            add_event_message(
                villager_name
                + " could not be assigned a harvest area because the target tile is invalid."
            )
            return

        villager_data["assigned_harvest_center"] = center_tile
        villager_data["assigned_harvest_radius"] = max(0, radius)
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0
        villager_data["current_work_task"] = "manual_harvest_area"

        villagers[villager_index] = villager_data

        add_event_message(
            villager_name
            + " assigned to harvest near "
            + str(center_tile)
            + " with radius "
            + str(max(0, radius))
            + "."
        )
        return

    add_event_message("Could not assign harvest area. Villager not found.")


func clear_harvest_area_assignment(villager_id: int) -> void:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("id", 0)) != villager_id:
            continue

        villager_data["assigned_harvest_center"] = NO_ASSIGNED_AREA
        villager_data["assigned_harvest_radius"] = 0
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)

        villagers[villager_index] = villager_data

        add_event_message(str(villager_data.get("name", "Villager")) + " returned to free harvesting.")
        return


func is_villager_unavailable_for_work(villager_data: Dictionary) -> bool:
    var health_state: String = str(villager_data.get("health_state", HEALTH_STATE_HEALTHY))

    if health_state == HEALTH_STATE_DEAD:
        return true

    return false


func process_villager(villager_index: int, delta: float, inventory: RegionInventory) -> void:
    if villager_index < 0 or villager_index >= villagers.size():
        return

    var villager_variant: Variant = villagers[villager_index]

    if typeof(villager_variant) != TYPE_DICTIONARY:
        return

    var villager_data: Dictionary = villager_variant
    var villager_state: String = str(villager_data.get("state", VILLAGER_STATE_IDLE))
    var villager_id: int = int(villager_data.get("id", 0))

    if is_villager_unavailable_for_work(villager_data):
        process_unavailable_villager(villager_data)
        villagers[villager_index] = villager_data
        return

    if process_assigned_role_behavior(villager_data, villager_id, delta, inventory):
        villagers[villager_index] = villager_data
        return

    match villager_state:
        VILLAGER_STATE_IDLE:
            assign_next_harvest_target(villager_data, villager_id, inventory)

        VILLAGER_STATE_MOVING:
            process_moving_villager(villager_data, delta, inventory)

        VILLAGER_STATE_HARVESTING:
            process_harvesting_villager(villager_data, delta, inventory)

        VILLAGER_STATE_THINKING:
            process_thinking_villager(villager_data, delta)

        VILLAGER_STATE_WAITING_AT_BUILDING:
            process_assigned_building_wander(
                villager_data,
                delta,
                "waiting_at_building",
                VILLAGER_STATE_WAITING_AT_BUILDING
            )

        VILLAGER_STATE_PATROLLING:
            process_assigned_building_wander(
                villager_data,
                delta,
                "patrolling",
                VILLAGER_STATE_PATROLLING
            )

    villagers[villager_index] = villager_data


func process_unavailable_villager(villager_data: Dictionary) -> void:
    villager_data["state"] = VILLAGER_STATE_IDLE
    villager_data["current_work_task"] = "unavailable"
    villager_data["target_tile"] = Vector2i(-1, -1)
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["move_timer"] = 0.0
    villager_data["harvest_timer"] = 0.0


func process_assigned_role_behavior(
    villager_data: Dictionary,
    villager_id: int,
    delta: float,
    inventory: RegionInventory
) -> bool:
    var assigned_harvest_center: Vector2i = villager_data.get("assigned_harvest_center", NO_ASSIGNED_AREA)
    var assigned_harvest_radius: int = int(villager_data.get("assigned_harvest_radius", 0))

    if is_tile_in_bounds(assigned_harvest_center) and assigned_harvest_radius > 0:
        return false

    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

    if assigned_building_instance_id <= 0:
        return false

    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))

    if role == StoneAgeVillagerAssignmentData.get_default_role():
        return false

    if role == StoneAgeVillagerAssignmentData.ROLE_HUNTER:
        var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

        if hunting_phase != HUNTING_PHASE_NONE:
            process_hunting_villager(villager_data, delta)
            return true

    match role:
        StoneAgeVillagerAssignmentData.ROLE_THINKER:
            process_thinking_villager(villager_data, delta)
            return true

        StoneAgeVillagerAssignmentData.ROLE_MAKER:
            process_assigned_building_wander(
                villager_data,
                delta,
                "waiting_at_building",
                VILLAGER_STATE_WAITING_AT_BUILDING
            )
            return true

        StoneAgeVillagerAssignmentData.ROLE_WOODWORKER:
            process_assigned_building_wander(
                villager_data,
                delta,
                "waiting_at_building",
                VILLAGER_STATE_WAITING_AT_BUILDING
            )
            return true

        StoneAgeVillagerAssignmentData.ROLE_STONEWORKER:
            process_assigned_building_wander(
                villager_data,
                delta,
                "waiting_at_building",
                VILLAGER_STATE_WAITING_AT_BUILDING
            )
            return true

        StoneAgeVillagerAssignmentData.ROLE_RITUALIST:
            process_assigned_building_wander(
                villager_data,
                delta,
                "ritual_waiting",
                VILLAGER_STATE_WAITING_AT_BUILDING
            )
            return true

        StoneAgeVillagerAssignmentData.ROLE_HUNTER:
            process_assigned_building_wander(
                villager_data,
                delta,
                "hunting_placeholder",
                VILLAGER_STATE_PATROLLING
            )
            return true

        StoneAgeVillagerAssignmentData.ROLE_WARRIOR:
            process_assigned_building_wander(
                villager_data,
                delta,
                "patrolling",
                VILLAGER_STATE_PATROLLING
            )
            return true

    return false
    
func get_available_hunters_for_hunt(required_count: int) -> Array:
    var available_hunters: Array = []

    if required_count <= 0:
        return available_hunters

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if is_villager_unavailable_for_work(villager_data):
            continue

        var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))

        if role != StoneAgeVillagerAssignmentData.ROLE_HUNTER:
            continue

        var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

        if assigned_building_instance_id <= 0:
            continue

        var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

        if hunting_phase != HUNTING_PHASE_NONE:
            continue

        var return_tile: Vector2i = villager_data.get("assigned_work_anchor_tile", NO_ASSIGNED_AREA)

        if not is_tile_in_bounds(return_tile):
            continue

        available_hunters.append(villager_data.duplicate(true))

        if available_hunters.size() >= required_count:
            break

    return available_hunters


func get_available_hunter_count() -> int:
    var available_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if is_villager_unavailable_for_work(villager_data):
            continue

        var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))

        if role != StoneAgeVillagerAssignmentData.ROLE_HUNTER:
            continue

        if int(villager_data.get("assigned_building_instance_id", 0)) <= 0:
            continue

        if str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE)) != HUNTING_PHASE_NONE:
            continue

        if not is_tile_in_bounds(villager_data.get("assigned_work_anchor_tile", NO_ASSIGNED_AREA)):
            continue

        available_count += 1

    return available_count


func assign_hunters_to_animal_hunt(
    animal_instance_id: int,
    animal_tile: Vector2i,
    required_hunters: int
) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": "",
        "hunter_ids": []
    }

    if animal_instance_id <= 0:
        result["message"] = "Invalid hunting target."
        return result

    if not is_tile_in_bounds(animal_tile):
        result["message"] = "Invalid animal location."
        return result

    if required_hunters <= 0:
        result["message"] = "Invalid hunter requirement."
        return result

    var available_hunters: Array = get_available_hunters_for_hunt(required_hunters)

    if available_hunters.size() < required_hunters:
        result["message"] = (
            "Not enough available Hunters. Required: "
            + str(required_hunters)
            + ", Available: "
            + str(available_hunters.size())
            + "."
        )
        return result

    var assigned_hunt_positions: Array = []
    var assigned_names: Array = []
    var hunter_ids: Array = []

    for hunter_index in range(required_hunters):
        var hunter_data: Dictionary = available_hunters[hunter_index]
        var hunter_id: int = int(hunter_data.get("id", 0))
        var villager_index: int = get_villager_index_by_id(hunter_id)

        if villager_index < 0:
            continue

        var villager_data: Dictionary = villagers[villager_index]
        var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))

        var hunt_position: Vector2i = find_hunt_position_for_hunter(
            animal_tile,
            current_tile,
            assigned_hunt_positions
        )

        if not is_tile_in_bounds(hunt_position):
            continue

        var return_tile: Vector2i = villager_data.get("assigned_work_anchor_tile", NO_ASSIGNED_AREA)

        villager_data["hunting_animal_instance_id"] = animal_instance_id
        villager_data["hunting_target_tile"] = hunt_position
        villager_data["hunting_return_tile"] = return_tile
        villager_data["hunting_phase"] = HUNTING_PHASE_TRAVEL_TO_ANIMAL
        villager_data["state"] = VILLAGER_STATE_MOVING_TO_HUNT
        villager_data["current_work_task"] = "traveling_to_hunt"
        villager_data["target_tile"] = hunt_position
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0

        villagers[villager_index] = villager_data

        assigned_hunt_positions.append(hunt_position)
        hunter_ids.append(hunter_id)
        assigned_names.append(str(villager_data.get("name", "Hunter")))

    if hunter_ids.size() < required_hunters:
        for assigned_hunter_index in range(hunter_ids.size()):
            clear_hunting_assignment_by_villager_id(int(hunter_ids[assigned_hunter_index]))

        result["message"] = (
            "Could not find enough open hunt positions around the animal. Required: "
            + str(required_hunters)
            + ", Positions found: "
            + str(hunter_ids.size())
            + "."
        )
        return result

    result["success"] = true
    result["hunter_ids"] = hunter_ids
    result["message"] = "Hunters sent: " + ", ".join(assigned_names) + "."

    return result
    
func find_hunt_position_for_hunter(
    animal_tile: Vector2i,
    hunter_current_tile: Vector2i,
    reserved_hunt_positions: Array
) -> Vector2i:
    var candidates: Array = get_hunt_approach_candidates(animal_tile)

    var best_tile := Vector2i(-1, -1)
    var best_distance: int = 999999

    for candidate_index in range(candidates.size()):
        var candidate_tile: Vector2i = candidates[candidate_index]

        if not is_tile_in_bounds(candidate_tile):
            continue

        if not is_tile_walkable_for_villager(candidate_tile):
            continue

        if is_hunt_position_reserved(candidate_tile, reserved_hunt_positions):
            continue

        if is_villager_on_tile(candidate_tile) and candidate_tile != hunter_current_tile:
            continue

        var distance: int = abs(candidate_tile.x - hunter_current_tile.x) + abs(candidate_tile.y - hunter_current_tile.y)

        if distance < best_distance:
            best_distance = distance
            best_tile = candidate_tile

    return best_tile


func get_hunt_approach_candidates(animal_tile: Vector2i) -> Array:
    return [
        Vector2i(animal_tile.x + 1, animal_tile.y),
        Vector2i(animal_tile.x - 1, animal_tile.y),
        Vector2i(animal_tile.x, animal_tile.y + 1),
        Vector2i(animal_tile.x, animal_tile.y - 1),
        Vector2i(animal_tile.x + 1, animal_tile.y + 1),
        Vector2i(animal_tile.x - 1, animal_tile.y + 1),
        Vector2i(animal_tile.x + 1, animal_tile.y - 1),
        Vector2i(animal_tile.x - 1, animal_tile.y - 1),
        Vector2i(animal_tile.x + 2, animal_tile.y),
        Vector2i(animal_tile.x - 2, animal_tile.y),
        Vector2i(animal_tile.x, animal_tile.y + 2),
        Vector2i(animal_tile.x, animal_tile.y - 2)
    ]


func is_hunt_position_reserved(
    tile_position: Vector2i,
    reserved_hunt_positions: Array
) -> bool:
    for reserved_index in range(reserved_hunt_positions.size()):
        var reserved_tile: Vector2i = reserved_hunt_positions[reserved_index]

        if reserved_tile == tile_position:
            return true

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

        if hunting_phase == HUNTING_PHASE_NONE:
            continue

        var hunter_target_tile: Vector2i = villager_data.get("hunting_target_tile", Vector2i(-1, -1))

        if hunter_target_tile == tile_position:
            return true

    return false


func clear_hunting_assignment_by_villager_id(villager_id: int) -> void:
    var villager_index: int = get_villager_index_by_id(villager_id)

    if villager_index < 0:
        return

    var villager_data: Dictionary = villagers[villager_index]

    clear_hunting_fields_for_villager(villager_data)

    if str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role())) == StoneAgeVillagerAssignmentData.ROLE_HUNTER:
        villager_data["state"] = VILLAGER_STATE_PATROLLING
        villager_data["current_work_task"] = "hunting_placeholder"
    else:
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["current_work_task"] = ""

    villagers[villager_index] = villager_data


func process_hunting_villager(
    villager_data: Dictionary,
    delta: float
) -> void:
    var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

    if hunting_phase == HUNTING_PHASE_NONE:
        return

    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))

    if not is_tile_in_bounds(current_tile):
        clear_hunting_fields_for_villager(villager_data)
        return

    if hunting_phase == HUNTING_PHASE_TRAVEL_TO_ANIMAL:
        process_hunter_travel_to_animal(villager_data, delta)
        return

    if hunting_phase == HUNTING_PHASE_HUNTING:
        villager_data["state"] = VILLAGER_STATE_HUNTING
        villager_data["current_work_task"] = "hunting"
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0
        return

    if hunting_phase == HUNTING_PHASE_RETURNING:
        process_hunter_returning_from_hunt(villager_data, delta)
        return


func process_hunter_travel_to_animal(
    villager_data: Dictionary,
    delta: float
) -> void:
    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))
    var target_tile: Vector2i = villager_data.get("hunting_target_tile", Vector2i(-1, -1))

    if not is_tile_in_bounds(target_tile):
        clear_hunting_fields_for_villager(villager_data)
        return

    villager_data["state"] = VILLAGER_STATE_MOVING_TO_HUNT
    villager_data["current_work_task"] = "traveling_to_hunt"
    villager_data["target_tile"] = target_tile
    villager_data["harvest_tile"] = Vector2i(-1, -1)

    if current_tile == target_tile:
        villager_data["state"] = VILLAGER_STATE_HUNTING
        villager_data["current_work_task"] = "hunting"
        villager_data["hunting_phase"] = HUNTING_PHASE_HUNTING
        villager_data["move_timer"] = 0.0
        return

    var move_timer: float = float(villager_data.get("move_timer", 0.0))
    move_timer -= delta
    villager_data["move_timer"] = move_timer

    if move_timer > 0.0:
        return

    var next_tile: Vector2i = get_next_step_toward_tile(current_tile, target_tile)

    if next_tile == current_tile:
        next_tile = get_next_open_step_toward_tile(current_tile, target_tile)

    if is_tile_in_bounds(next_tile) and is_tile_walkable_for_villager(next_tile):
        if not is_villager_on_tile(next_tile) or next_tile == target_tile:
            villager_data["tile"] = next_tile
            villager_data["world_position"] = tile_to_world_center(next_tile)
            villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)
            return

    villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)


func process_hunter_returning_from_hunt(
    villager_data: Dictionary,
    delta: float
) -> void:
    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))
    var return_tile: Vector2i = villager_data.get("hunting_return_tile", Vector2i(-1, -1))

    if not is_tile_in_bounds(return_tile):
        clear_hunting_fields_for_villager(villager_data)
        return

    villager_data["state"] = VILLAGER_STATE_RETURNING_FROM_HUNT
    villager_data["current_work_task"] = "returning_from_hunt"
    villager_data["target_tile"] = return_tile
    villager_data["harvest_tile"] = Vector2i(-1, -1)

    if current_tile == return_tile:
        clear_hunting_fields_for_villager(villager_data)
        villager_data["state"] = VILLAGER_STATE_PATROLLING
        villager_data["current_work_task"] = "hunting_placeholder"
        return

    var move_timer: float = float(villager_data.get("move_timer", 0.0))
    move_timer -= delta
    villager_data["move_timer"] = move_timer

    if move_timer > 0.0:
        return

    var next_tile: Vector2i = get_next_step_toward_tile(current_tile, return_tile)

    if is_tile_in_bounds(next_tile) and is_tile_walkable_for_villager(next_tile):
        villager_data["tile"] = next_tile
        villager_data["world_position"] = tile_to_world_center(next_tile)
        villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)
        return

    villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)


func get_hunt_status_for_animal(
    animal_instance_id: int,
    required_hunters: int
) -> Dictionary:
    var assigned_count: int = 0
    var arrived_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("hunting_animal_instance_id", 0)) != animal_instance_id:
            continue

        var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

        if hunting_phase == HUNTING_PHASE_NONE:
            continue

        assigned_count += 1

        if hunting_phase == HUNTING_PHASE_HUNTING:
            arrived_count += 1

    return {
        "assigned_count": assigned_count,
        "arrived_count": arrived_count,
        "required_hunters": required_hunters,
        "all_arrived": assigned_count >= required_hunters and arrived_count >= required_hunters
    }
    
func get_average_hunting_skill_for_animal(animal_instance_id: int) -> float:
    if animal_instance_id <= 0:
        return 0.0

    var total_hunting_skill: int = 0
    var hunter_count: int = 0

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("hunting_animal_instance_id", 0)) != animal_instance_id:
            continue

        var hunting_phase: String = str(villager_data.get("hunting_phase", HUNTING_PHASE_NONE))

        if hunting_phase == HUNTING_PHASE_NONE:
            continue

        if is_villager_unavailable_for_work(villager_data):
            continue

        total_hunting_skill += get_villager_skill_level(
            villager_data,
            SKILL_HUNTING
        )

        hunter_count += 1

    if hunter_count <= 0:
        return 0.0

    return float(total_hunting_skill) / float(hunter_count)


func send_hunt_party_home(animal_instance_id: int) -> void:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("hunting_animal_instance_id", 0)) != animal_instance_id:
            continue

        villager_data["hunting_phase"] = HUNTING_PHASE_RETURNING
        villager_data["state"] = VILLAGER_STATE_RETURNING_FROM_HUNT
        villager_data["current_work_task"] = "returning_from_hunt"
        villager_data["target_tile"] = villager_data.get("hunting_return_tile", Vector2i(-1, -1))
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0

        villagers[villager_index] = villager_data


func apply_hunting_result_to_party(
    animal_instance_id: int,
    injury_occurred: bool,
    death_occurred: bool
) -> Array:
    var result_messages: Array = []
    var hunter_indexes: Array = []

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if int(villager_data.get("hunting_animal_instance_id", 0)) != animal_instance_id:
            continue

        hunter_indexes.append(villager_index)

    if hunter_indexes.is_empty():
        return result_messages

    if injury_occurred:
        var injured_index: int = int(hunter_indexes[rng.randi_range(0, hunter_indexes.size() - 1)])
        var injured_villager: Dictionary = villagers[injured_index]
        var injured_name: String = str(injured_villager.get("name", "Hunter"))

        injured_villager["health"] = max(1, int(injured_villager.get("health", BASE_HEALTH)) - 1)
        injured_villager["health_state"] = HEALTH_STATE_WEAKENED
        villagers[injured_index] = injured_villager

        result_messages.append(injured_name + " was injured during the hunt.")

    if death_occurred:
        var dead_index: int = int(hunter_indexes[rng.randi_range(0, hunter_indexes.size() - 1)])
        var dead_villager: Dictionary = villagers[dead_index]
        var dead_name: String = str(dead_villager.get("name", "Hunter"))

        dead_villager["health"] = 0
        dead_villager["health_state"] = HEALTH_STATE_DEAD
        dead_villager["state"] = VILLAGER_STATE_IDLE
        dead_villager["current_work_task"] = "dead"
        villagers[dead_index] = dead_villager

        result_messages.append(dead_name + " was killed during the hunt.")

    return result_messages


func clear_hunting_fields_for_villager(villager_data: Dictionary) -> void:
    villager_data["hunting_animal_instance_id"] = 0
    villager_data["hunting_target_tile"] = Vector2i(-1, -1)
    villager_data["hunting_return_tile"] = Vector2i(-1, -1)
    villager_data["hunting_phase"] = HUNTING_PHASE_NONE
    villager_data["target_tile"] = Vector2i(-1, -1)
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["move_timer"] = 0.0
    villager_data["harvest_timer"] = 0.0


func process_thinking_villager(
    villager_data: Dictionary,
    delta: float
) -> void:
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

    if assigned_building_instance_id <= 0:
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["current_work_task"] = ""
        return

    var thinking_level: int = get_villager_skill_level(
        villager_data,
        SKILL_THINKING
    )

    var skill_multiplier: float = 1.0 + float(thinking_level) * THINKER_RESEARCH_BONUS_PER_THINKING_LEVEL
    var generated_research: float = THINKER_BASE_RESEARCH_PER_SECOND * skill_multiplier * delta

    research_progress_this_frame += generated_research

    process_assigned_building_wander(
        villager_data,
        delta,
        "thinking",
        VILLAGER_STATE_THINKING
    )

func process_assigned_building_wander(
    villager_data: Dictionary,
    delta: float,
    task_name: String,
    desired_state: String
) -> void:
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

    if assigned_building_instance_id <= 0:
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["current_work_task"] = ""
        return

    var anchor_tile: Vector2i = villager_data.get("assigned_work_anchor_tile", NO_ASSIGNED_AREA)
    var work_radius: int = int(villager_data.get("assigned_work_radius", DEFAULT_ASSIGNED_WORK_RADIUS))

    if not is_tile_in_bounds(anchor_tile):
        villager_data["state"] = desired_state
        villager_data["current_work_task"] = task_name
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0
        return

    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))
    var target_tile: Vector2i = villager_data.get("target_tile", Vector2i(-1, -1))
    var move_timer: float = float(villager_data.get("move_timer", 0.0))

    villager_data["state"] = desired_state
    villager_data["current_work_task"] = task_name
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["harvest_timer"] = 0.0

    if is_tile_in_bounds(target_tile) and current_tile != target_tile:
        move_timer -= delta
        villager_data["move_timer"] = move_timer

        if move_timer > 0.0:
            return

        var next_tile: Vector2i = get_next_step_toward_tile(current_tile, target_tile)

        if is_tile_in_bounds(next_tile) and is_tile_walkable_for_villager(next_tile):
            villager_data["tile"] = next_tile
            villager_data["world_position"] = tile_to_world_center(next_tile)
            villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)
            return

        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        return

    if current_tile == target_tile:
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0

    var distance_from_anchor: int = abs(current_tile.x - anchor_tile.x) + abs(current_tile.y - anchor_tile.y)

    if distance_from_anchor > work_radius:
        var nearest_anchor_tile: Vector2i = find_nearest_walkable_tile_in_area(
            current_tile,
            anchor_tile,
            work_radius
        )

        if is_tile_in_bounds(nearest_anchor_tile):
            villager_data["target_tile"] = nearest_anchor_tile
            villager_data["move_timer"] = 0.0

        return

    var should_pick_new_target: bool = false

    if not is_tile_in_bounds(target_tile):
        should_pick_new_target = rng.randf() < 0.25

    if not should_pick_new_target:
        return

    var wander_tile: Vector2i = find_random_walkable_tile_in_area(
        anchor_tile,
        work_radius
    )

    if not is_tile_in_bounds(wander_tile):
        return

    if wander_tile == current_tile:
        return

    villager_data["target_tile"] = wander_tile
    villager_data["move_timer"] = 0.0


func find_nearest_walkable_tile_in_area(
    origin_tile: Vector2i,
    center_tile: Vector2i,
    radius: int
) -> Vector2i:
    var best_tile := Vector2i(-1, -1)
    var best_distance: int = 999999

    for y in range(center_tile.y - radius, center_tile.y + radius + 1):
        for x in range(center_tile.x - radius, center_tile.x + radius + 1):
            var tile_position := Vector2i(x, y)

            if not is_tile_in_bounds(tile_position):
                continue

            var distance_from_center: int = abs(tile_position.x - center_tile.x) + abs(tile_position.y - center_tile.y)

            if distance_from_center > radius:
                continue

            if not is_tile_walkable_for_villager(tile_position):
                continue

            if is_villager_on_tile(tile_position) and tile_position != origin_tile:
                continue

            var distance_from_origin: int = abs(tile_position.x - origin_tile.x) + abs(tile_position.y - origin_tile.y)

            if distance_from_origin < best_distance:
                best_distance = distance_from_origin
                best_tile = tile_position

    return best_tile


func find_random_walkable_tile_in_area(
    center_tile: Vector2i,
    radius: int
) -> Vector2i:
    var candidates: Array = []

    for y in range(center_tile.y - radius, center_tile.y + radius + 1):
        for x in range(center_tile.x - radius, center_tile.x + radius + 1):
            var tile_position := Vector2i(x, y)

            if not is_tile_in_bounds(tile_position):
                continue

            var distance: int = abs(tile_position.x - center_tile.x) + abs(tile_position.y - center_tile.y)

            if distance > radius:
                continue

            if not is_tile_walkable_for_villager(tile_position):
                continue

            if is_villager_on_tile(tile_position):
                continue

            candidates.append(tile_position)

    if candidates.is_empty():
        return Vector2i(-1, -1)

    var selected_index: int = rng.randi_range(0, candidates.size() - 1)
    return candidates[selected_index]


func assign_next_harvest_target(
    villager_data: Dictionary,
    villager_id: int,
    inventory: RegionInventory
) -> void:
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))

    if role == StoneAgeVillagerAssignmentData.ROLE_THINKER and assigned_building_instance_id > 0:
        villager_data["state"] = VILLAGER_STATE_THINKING
        villager_data["current_work_task"] = "thinking"
        return

    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))
    var resource_tile: Vector2i = find_harvest_target_for_villager(
        current_tile,
        villager_id,
        villager_data,
        inventory
    )

    if not is_tile_in_bounds(resource_tile):
        return

    var work_tile: Vector2i = get_work_tile_for_resource(current_tile, resource_tile)

    if not is_tile_in_bounds(work_tile):
        return

    villager_data["state"] = VILLAGER_STATE_MOVING
    villager_data["target_tile"] = work_tile
    villager_data["harvest_tile"] = resource_tile
    villager_data["move_timer"] = 0.0


func process_moving_villager(
    villager_data: Dictionary,
    delta: float,
    inventory: RegionInventory
) -> void:
    var move_timer: float = float(villager_data.get("move_timer", 0.0))
    move_timer -= delta
    villager_data["move_timer"] = move_timer

    if move_timer > 0.0:
        return

    var current_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))
    var target_tile: Vector2i = villager_data.get("target_tile", Vector2i(-1, -1))
    var harvest_tile: Vector2i = villager_data.get("harvest_tile", Vector2i(-1, -1))

    if not is_tile_in_bounds(target_tile) or not is_tile_in_bounds(harvest_tile):
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        return

    if not is_tile_harvestable_at_position(harvest_tile, inventory):
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        return

    if current_tile == target_tile:
        villager_data["state"] = VILLAGER_STATE_HARVESTING
        villager_data["harvest_timer"] = get_harvest_duration_for_tile(
            harvest_tile,
            villager_data
        )
        return

    var next_tile: Vector2i = get_next_step_toward_tile(current_tile, target_tile)

    if is_tile_in_bounds(next_tile) and is_tile_walkable_for_villager(next_tile):
        villager_data["tile"] = next_tile
        villager_data["world_position"] = tile_to_world_center(next_tile)
        villager_data["move_timer"] = get_adjusted_move_interval_for_villager(villager_data)
    else:
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)


func process_harvesting_villager(
    villager_data: Dictionary,
    delta: float,
    inventory: RegionInventory
) -> void:
    var harvest_timer: float = float(villager_data.get("harvest_timer", DEFAULT_HARVEST_DURATION))
    harvest_timer -= delta
    villager_data["harvest_timer"] = harvest_timer

    if harvest_timer > 0.0:
        return

    var harvest_target: Vector2i = villager_data.get("harvest_tile", Vector2i(-1, -1))
    var villager_name: String = str(villager_data.get("name", "Villager"))

    harvest_resource_at_tile(
        harvest_target,
        villager_name,
        inventory
    )

    villager_data["state"] = VILLAGER_STATE_IDLE
    villager_data["target_tile"] = Vector2i(-1, -1)
    villager_data["harvest_tile"] = Vector2i(-1, -1)
    villager_data["harvest_timer"] = 0.0


func find_harvest_target_for_villager(
    origin_tile: Vector2i,
    villager_id: int,
    villager_data: Dictionary,
    inventory: RegionInventory
) -> Vector2i:
    var assigned_center: Vector2i = villager_data.get("assigned_harvest_center", NO_ASSIGNED_AREA)
    var assigned_radius: int = int(villager_data.get("assigned_harvest_radius", 0))

    if is_tile_in_bounds(assigned_center) and assigned_radius > 0:
        return find_random_harvestable_tile_in_area(
            origin_tile,
            assigned_center,
            assigned_radius,
            villager_id,
            inventory
        )

    return find_random_harvestable_tile_global(origin_tile, villager_id, inventory)


func find_random_harvestable_tile_in_area(
    origin_tile: Vector2i,
    center_tile: Vector2i,
    radius: int,
    villager_id: int,
    inventory: RegionInventory
) -> Vector2i:
    var candidates: Array = []

    for y in range(center_tile.y - radius, center_tile.y + radius + 1):
        for x in range(center_tile.x - radius, center_tile.x + radius + 1):
            var tile_position := Vector2i(x, y)

            if not is_tile_in_bounds(tile_position):
                continue

            var distance: int = abs(tile_position.x - center_tile.x) + abs(tile_position.y - center_tile.y)

            if distance > radius:
                continue

            if not is_tile_harvestable_at_position(tile_position, inventory):
                continue

            if is_resource_tile_reserved(tile_position, villager_id):
                continue

            var work_tile: Vector2i = get_work_tile_for_resource(origin_tile, tile_position)

            if not is_tile_in_bounds(work_tile):
                continue

            candidates.append(tile_position)

    if candidates.is_empty():
        return Vector2i(-1, -1)

    var selected_index: int = rng.randi_range(0, candidates.size() - 1)
    return candidates[selected_index]


func find_random_harvestable_tile_global(
    origin_tile: Vector2i,
    villager_id: int,
    inventory: RegionInventory
) -> Vector2i:
    var candidates: Array = []

    for y in range(region_height):
        for x in range(region_width):
            var tile_position := Vector2i(x, y)

            if not is_tile_harvestable_at_position(tile_position, inventory):
                continue

            if is_resource_tile_reserved(tile_position, villager_id):
                continue

            var work_tile: Vector2i = get_work_tile_for_resource(origin_tile, tile_position)

            if not is_tile_in_bounds(work_tile):
                continue

            candidates.append(tile_position)

    if candidates.is_empty():
        return Vector2i(-1, -1)

    var selected_index: int = rng.randi_range(0, candidates.size() - 1)
    return candidates[selected_index]


func get_work_tile_for_resource(origin_tile: Vector2i, resource_tile: Vector2i) -> Vector2i:
    if is_tile_walkable_for_villager(resource_tile):
        return resource_tile

    var adjacent_tiles: Array = [
        Vector2i(resource_tile.x + 1, resource_tile.y),
        Vector2i(resource_tile.x - 1, resource_tile.y),
        Vector2i(resource_tile.x, resource_tile.y + 1),
        Vector2i(resource_tile.x, resource_tile.y - 1),
        Vector2i(resource_tile.x + 1, resource_tile.y + 1),
        Vector2i(resource_tile.x - 1, resource_tile.y + 1),
        Vector2i(resource_tile.x + 1, resource_tile.y - 1),
        Vector2i(resource_tile.x - 1, resource_tile.y - 1)
    ]

    var best_tile := Vector2i(-1, -1)
    var best_distance: int = 999999

    for tile_index in range(adjacent_tiles.size()):
        var adjacent_variant: Variant = adjacent_tiles[tile_index]
        var adjacent_tile: Vector2i = adjacent_variant

        if not is_tile_walkable_for_villager(adjacent_tile):
            continue

        var distance: int = abs(adjacent_tile.x - origin_tile.x) + abs(adjacent_tile.y - origin_tile.y)

        if distance < best_distance:
            best_distance = distance
            best_tile = adjacent_tile

    return best_tile


func get_harvest_duration_for_tile(
    tile_position: Vector2i,
    villager_data: Dictionary
) -> float:
    if not is_tile_in_bounds(tile_position):
        return DEFAULT_HARVEST_DURATION

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return DEFAULT_HARVEST_DURATION

    var longest_adjusted_time: float = 0.0

    for resource_index in range(resources.size()):
        var resource_variant: Variant = resources[resource_index]

        if typeof(resource_variant) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource_variant
        var resource_id: String = str(resource_dict.get("id", "unknown"))

        var base_time: float = get_base_harvest_time(resource_id)
        var skill_id: String = get_harvest_skill_for_resource(resource_id)
        var skill_level: int = get_villager_skill_level(
            villager_data,
            skill_id
        )

        var skill_speed_multiplier: float = get_skill_speed_multiplier(skill_level)
        var total_speed_multiplier: float = harvest_speed_multiplier * skill_speed_multiplier

        var adjusted_time: float = base_time / max(0.1, total_speed_multiplier)

        longest_adjusted_time = max(
            longest_adjusted_time,
            adjusted_time
        )

    if longest_adjusted_time <= 0.0:
        return DEFAULT_HARVEST_DURATION

    return longest_adjusted_time


func get_harvest_skill_for_resource(resource_id: String) -> String:
    if resource_id == RESOURCE_WOOD:
        return SKILL_WOODCUTTING

    if resource_id == RESOURCE_STONE:
        return SKILL_MINING

    if resource_id == RESOURCE_FLINT:
        return SKILL_MINING

    if resource_id == RESOURCE_CLAY:
        return SKILL_MINING

    if resource_id == RESOURCE_BERRIES:
        return SKILL_GATHERING

    if resource_id == RESOURCE_MUSHROOMS:
        return SKILL_GATHERING

    if resource_id == RESOURCE_REEDS:
        return SKILL_GATHERING

    if resource_id == RESOURCE_FIBER:
        return SKILL_GATHERING

    if resource_id == RESOURCE_FISH:
        return SKILL_GATHERING

    if resource_id == RESOURCE_HIDE:
        return SKILL_GATHERING

    return SKILL_GATHERING


func get_villager_skill_level(
    villager_data: Dictionary,
    skill_id: String
) -> int:
    var skills: Dictionary = villager_data.get("skills", {})
    var skill_level: int = int(skills.get(skill_id, 0))

    return clamp_skill_level(
        villager_data,
        skill_id,
        skill_level
    )


func get_skill_speed_multiplier(skill_level: int) -> float:
    return 1.0 + float(skill_level) * SKILL_HARVEST_SPEED_BONUS_PER_LEVEL


func get_base_harvest_time(resource_id: String) -> float:
    if not RESOURCE_HARVEST_RULES.has(resource_id):
        return DEFAULT_HARVEST_DURATION

    var rule: Dictionary = RESOURCE_HARVEST_RULES[resource_id]
    return float(rule.get("base_harvest_time", DEFAULT_HARVEST_DURATION))


func get_resource_yield_multiplier(resource_id: String) -> float:
    if not RESOURCE_HARVEST_RULES.has(resource_id):
        return harvest_yield_multiplier

    var rule: Dictionary = RESOURCE_HARVEST_RULES[resource_id]
    var base_multiplier: float = float(rule.get("base_yield_multiplier", 1.0))

    return base_multiplier * harvest_yield_multiplier


func is_villager_on_tile(tile_position: Vector2i) -> bool:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_tile: Vector2i = villager_data.get("tile", Vector2i(-1, -1))

        if villager_tile == tile_position:
            return true

    return false


func find_nearest_walkable_tile(origin_tile: Vector2i) -> Vector2i:
    if is_tile_in_bounds(origin_tile) and is_tile_walkable_for_villager(origin_tile):
        return origin_tile

    for radius in range(1, 12):
        for y in range(origin_tile.y - radius, origin_tile.y + radius + 1):
            for x in range(origin_tile.x - radius, origin_tile.x + radius + 1):
                var tile_position := Vector2i(x, y)

                if not is_tile_in_bounds(tile_position):
                    continue

                if is_tile_walkable_for_villager(tile_position):
                    return tile_position

    return Vector2i(-1, -1)


func is_tile_walkable_for_villager(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
    var terrain: String = str(tile_data.get("terrain", ""))

    if terrain == terrain_water:
        return false

    if bool(tile_data.get("occupied", false)):
        return false

    if bool(tile_data.get("walkable", false)):
        return true

    if is_tree_wood_tile(tile_data):
        return true

    if is_stone_pathable_resource_tile(tile_data):
        return true

    return false


func is_tree_wood_tile(tile_data: Dictionary) -> bool:
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return false

    for resource_index in range(resources.size()):
        var resource_variant: Variant = resources[resource_index]

        if typeof(resource_variant) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource_variant
        var resource_id: String = str(resource_dict.get("id", ""))

        if resource_id == RESOURCE_WOOD:
            return true

    return false


func is_stone_pathable_resource_tile(tile_data: Dictionary) -> bool:
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return false

    for resource_index in range(resources.size()):
        var resource_variant: Variant = resources[resource_index]

        if typeof(resource_variant) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource_variant
        var resource_id: String = str(resource_dict.get("id", ""))

        if resource_id == RESOURCE_STONE:
            return true

        if resource_id == RESOURCE_FLINT:
            return true

        if resource_id == RESOURCE_CLAY:
            return true

    return false


func is_tile_harvestable_at_position(
    tile_position: Vector2i,
    inventory: RegionInventory
) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

    return is_tile_harvestable(tile_data, inventory)


func is_tile_harvestable(
    tile_data: Dictionary,
    inventory: RegionInventory
) -> bool:
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return false

    var terrain: String = str(tile_data.get("terrain", ""))

    if terrain == terrain_water:
        return false

    for resource_index in range(resources.size()):
        var resource_variant: Variant = resources[resource_index]

        if typeof(resource_variant) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource_variant
        var resource_name: String = str(resource_dict.get("name", "Unknown"))

        if can_accept_resource_after_pending(resource_name, inventory):
            return true

    return false


func can_accept_resource_after_pending(
    resource_name: String,
    inventory: RegionInventory
) -> bool:
    var current_amount: int = inventory.get_amount(resource_name)
    var cap_amount: int = inventory.get_resource_cap(resource_name)
    var pending_amount: int = int(harvested_resources_this_frame.get(resource_name, 0))

    return current_amount + pending_amount < cap_amount


func get_available_space_after_pending(
    resource_name: String,
    inventory: RegionInventory
) -> int:
    var current_amount: int = inventory.get_amount(resource_name)
    var cap_amount: int = inventory.get_resource_cap(resource_name)
    var pending_amount: int = int(harvested_resources_this_frame.get(resource_name, 0))

    return max(0, cap_amount - current_amount - pending_amount)


func is_resource_tile_reserved(tile_position: Vector2i, except_villager_id: int) -> bool:
    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_id: int = int(villager_data.get("id", 0))

        if villager_id == except_villager_id:
            continue

        var villager_state: String = str(villager_data.get("state", VILLAGER_STATE_IDLE))

        if villager_state != VILLAGER_STATE_MOVING and villager_state != VILLAGER_STATE_HARVESTING:
            continue

        var target_tile: Vector2i = villager_data.get("target_tile", Vector2i(-1, -1))
        var harvest_tile: Vector2i = villager_data.get("harvest_tile", Vector2i(-1, -1))

        if target_tile == tile_position:
            return true

        if harvest_tile == tile_position:
            return true

    return false


func get_next_step_toward_tile(from_tile: Vector2i, to_tile: Vector2i) -> Vector2i:
    var delta_x: int = to_tile.x - from_tile.x
    var delta_y: int = to_tile.y - from_tile.y

    var step_x: int = int(sign(delta_x))
    var step_y: int = int(sign(delta_y))

    var primary_step := from_tile
    var secondary_step := from_tile

    if abs(delta_x) >= abs(delta_y):
        primary_step = Vector2i(from_tile.x + step_x, from_tile.y)
        secondary_step = Vector2i(from_tile.x, from_tile.y + step_y)
    else:
        primary_step = Vector2i(from_tile.x, from_tile.y + step_y)
        secondary_step = Vector2i(from_tile.x + step_x, from_tile.y)

    if step_x != 0 or step_y != 0:
        if is_tile_in_bounds(primary_step) and is_tile_walkable_for_villager(primary_step):
            return primary_step

        if is_tile_in_bounds(secondary_step) and is_tile_walkable_for_villager(secondary_step):
            return secondary_step

    return from_tile
    
func get_next_open_step_toward_tile(
    from_tile: Vector2i,
    to_tile: Vector2i
) -> Vector2i:
    var candidate_steps: Array = [
        Vector2i(from_tile.x + 1, from_tile.y),
        Vector2i(from_tile.x - 1, from_tile.y),
        Vector2i(from_tile.x, from_tile.y + 1),
        Vector2i(from_tile.x, from_tile.y - 1),
        Vector2i(from_tile.x + 1, from_tile.y + 1),
        Vector2i(from_tile.x - 1, from_tile.y + 1),
        Vector2i(from_tile.x + 1, from_tile.y - 1),
        Vector2i(from_tile.x - 1, from_tile.y - 1)
    ]

    var best_tile := from_tile
    var best_distance: int = abs(to_tile.x - from_tile.x) + abs(to_tile.y - from_tile.y)

    for candidate_index in range(candidate_steps.size()):
        var candidate_tile: Vector2i = candidate_steps[candidate_index]

        if not is_tile_in_bounds(candidate_tile):
            continue

        if not is_tile_walkable_for_villager(candidate_tile):
            continue

        if is_villager_on_tile(candidate_tile) and candidate_tile != to_tile:
            continue

        var candidate_distance: int = abs(to_tile.x - candidate_tile.x) + abs(to_tile.y - candidate_tile.y)

        if candidate_distance < best_distance:
            best_distance = candidate_distance
            best_tile = candidate_tile

    return best_tile


func harvest_resource_at_tile(
    tile_position: Vector2i,
    villager_name: String,
    inventory: RegionInventory
) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return false

    var harvested_parts: Array = []
    var remaining_resources: Array = []

    for resource_index in range(resources.size()):
        var resource_variant: Variant = resources[resource_index]

        if typeof(resource_variant) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource_variant
        var resource_id: String = str(resource_dict.get("id", "unknown"))
        var resource_name: String = str(resource_dict.get("name", "Unknown"))
        var resource_amount: int = int(resource_dict.get("amount", 0))

        if resource_amount <= 0:
            continue

        var adjusted_amount: int = max(
            1,
            int(round(float(resource_amount) * get_resource_yield_multiplier(resource_id)))
        )

        var available_space: int = get_available_space_after_pending(
            resource_name,
            inventory
        )

        if available_space <= 0:
            remaining_resources.append(resource_dict)
            continue

        var accepted_amount: int = mini(adjusted_amount, available_space)

        if not harvested_resources_this_frame.has(resource_name):
            harvested_resources_this_frame[resource_name] = 0

        harvested_resources_this_frame[resource_name] = int(harvested_resources_this_frame[resource_name]) + accepted_amount
        harvested_parts.append(resource_name + " " + str(accepted_amount))

        if accepted_amount < adjusted_amount:
            var remaining_resource: Dictionary = resource_dict.duplicate(true)
            remaining_resource["amount"] = adjusted_amount - accepted_amount
            remaining_resource["max_amount"] = int(remaining_resource.get("max_amount", remaining_resource["amount"]))
            remaining_resources.append(remaining_resource)

    if harvested_parts.is_empty():
        return false

    if remaining_resources.is_empty():
        tile_data["resources"] = []
        tile_data["feature"] = feature_none
        tile_data["walkable"] = true
        tile_data["buildable"] = true
        tile_data["terrain"] = terrain_grass
    else:
        tile_data["resources"] = remaining_resources

    did_change_tiles = true

    add_event_message(
        villager_name + " harvested " + ", ".join(harvested_parts) + "."
    )

    return true


func print_villager_roster() -> void:
    print("")
    print("Villager Roster:")

    for villager_index in range(villagers.size()):
        var villager_variant: Variant = villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        print_villager_summary(villager_data)

    print("")


func print_villager_summary(villager_data: Dictionary) -> void:
    var villager_name: String = str(villager_data.get("name", "Villager"))
    var gender: String = str(villager_data.get("gender", "unknown"))
    var level: int = int(villager_data.get("level", 0))
    var speed: int = int(villager_data.get("speed", BASE_SPEED))
    var health: int = int(villager_data.get("health", BASE_HEALTH))
    var max_health: int = int(villager_data.get("max_health", BASE_HEALTH))
    var hunger: int = int(villager_data.get("hunger", HUNGER_FULL))
    var skills: Dictionary = villager_data.get("skills", {})
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(role)
    var assigned_role: String = str(villager_data.get("assigned_building_role", ""))
    var assigned_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assigned_role)
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))
    var current_work_task: String = str(villager_data.get("current_work_task", ""))
    var attack_text: String = "-"

    if villager_data.has("attack"):
        attack_text = str(int(villager_data.get("attack", 0)))

    var defense_text: String = "-"

    if villager_data.has("defense"):
        defense_text = str(int(villager_data.get("defense", 0)))

    print(
        "- ",
        villager_name,
        " (",
        gender,
        ") ",
        "Level ",
        level,
        ", Speed ",
        speed,
        ", Health ",
        health,
        "/",
        max_health,
        ", Hunger ",
        hunger,
        ", Core Skills [Gathering ",
        int(skills.get(SKILL_GATHERING, 0)),
        ", Building ",
        int(skills.get(SKILL_BUILDING, 0)),
        ", Mining ",
        int(skills.get(SKILL_MINING, 0)),
        ", WoodCutting ",
        int(skills.get(SKILL_WOODCUTTING, 0)),
        "]",
        ", Role Skills [Crafting ",
        int(skills.get(SKILL_CRAFTING, 0)),
        ", Thinking ",
        int(skills.get(SKILL_THINKING, 0)),
        ", Stoneworking ",
        int(skills.get(SKILL_STONEWORKING, 0)),
        ", Woodworking ",
        int(skills.get(SKILL_WOODWORKING, 0)),
        ", Rituals ",
        int(skills.get(SKILL_RITUALS, 0)),
        "]",
        ", Combat [Attack ",
        attack_text,
        ", Defense ",
        defense_text,
        ", Hunting ",
        int(skills.get(SKILL_HUNTING, 0)),
        ", Ranged ",
        int(skills.get(SKILL_RANGED_WEAPONS, 0)),
        ", Melee ",
        int(skills.get(SKILL_MELEE_WEAPONS, 0)),
        ", Evade ",
        int(skills.get(SKILL_EVADE, 0)),
        ", Parry ",
        int(skills.get(SKILL_PARRY, 0)),
        "]",
        ", Role ",
        role_name,
        ", Assigned Role ",
        assigned_role_name,
        ", Assigned Building ",
        assigned_building_instance_id,
        ", Task ",
        current_work_task
    )


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < region_width
        and tile_position.y < region_height
    )


func tile_to_world_center(tile_position: Vector2i) -> Vector2:
    return Vector2(
        tile_position.x * region_tile_size + region_tile_size / 2.0,
        tile_position.y * region_tile_size + region_tile_size / 2.0
    )
