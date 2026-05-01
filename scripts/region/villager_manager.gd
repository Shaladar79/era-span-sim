extends RefCounted
class_name VillagerManager

const STARTING_POPULATION: int = 5
const POPULATION_GROWTH_INTERVAL: float = 300.0
const POPULATION_GROWTH_CHANCE: float = 0.25

const VILLAGER_STATE_IDLE: String = "idle"
const VILLAGER_STATE_MOVING: String = "moving"
const VILLAGER_STATE_HARVESTING: String = "harvesting"

const VILLAGER_MOVE_INTERVAL: float = 0.18
const DEFAULT_HARVEST_DURATION: float = 1.0

const NO_ASSIGNED_AREA: Vector2i = Vector2i(-1, -1)

const HEALTH_STATE_HEALTHY: String = "healthy"
const HEALTH_STATE_SICK: String = "sick"
const HEALTH_STATE_WEAKENED: String = "weakened"
const HEALTH_STATE_DEAD: String = "dead"

const BASE_BELONGING_SLOTS: int = 1
const STONE_AGE_MAX_BELONGING_SLOTS: int = 2
const CURRENT_NAME_ERA: String = VillagerNameGenerator.NAME_ERA_STONE

const BASE_SPEED: int = 100
const MIN_SPEED: int = 10

const SKILL_GATHERING: String = "gathering"
const SKILL_WOOD_WORKING: String = "wood_working"
const SKILL_STONE_WORKING: String = "stone_working"
const SKILL_BUILDING: String = "building"
const SKILL_HAULING: String = "hauling"
const SKILL_MEDICINE: String = "medicine"
const SKILL_THINKING: String = "thinking"

const SKILL_HARVEST_SPEED_BONUS_PER_LEVEL: float = 0.02
const MAX_SKILL_LEVEL: int = 10

const SKILL_IDS: Array = [
    SKILL_GATHERING,
    SKILL_WOOD_WORKING,
    SKILL_STONE_WORKING,
    SKILL_BUILDING,
    SKILL_HAULING,
    SKILL_MEDICINE,
    SKILL_THINKING
]

const STARTING_SPECIALIST_SKILLS: Array = [
    SKILL_GATHERING,
    SKILL_WOOD_WORKING,
    SKILL_STONE_WORKING,
    SKILL_BUILDING,
    SKILL_HAULING
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


func reset_and_spawn_starting_villagers() -> void:
    villagers.clear()
    next_villager_id = 1
    population_growth_timer = 0.0
    event_messages_this_frame.clear()
    global_movement_speed_bonus = 0.0
    global_belonging_slot_bonus = 0

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

        var forced_skill: String = ""

        if spawned_count < STARTING_SPECIALIST_SKILLS.size():
            forced_skill = str(STARTING_SPECIALIST_SKILLS[spawned_count])

        spawn_villager_at_tile(
            spawn_tile,
            forced_skill
        )

        spawned_count += 1

    while spawned_count < STARTING_POPULATION:
        var fallback_tile: Vector2i = find_nearest_available_spawn_tile(center)

        if not is_tile_in_bounds(fallback_tile):
            break

        var forced_fallback_skill: String = ""

        if spawned_count < STARTING_SPECIALIST_SKILLS.size():
            forced_fallback_skill = str(STARTING_SPECIALIST_SKILLS[spawned_count])

        spawn_villager_at_tile(
            fallback_tile,
            forced_fallback_skill
        )

        spawned_count += 1

    update_all_villager_speed_stats()

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


func get_villager_level_from_skills(skills: Dictionary) -> float:
    if SKILL_IDS.is_empty():
        return 0.0

    var total_skill_levels: int = 0

    for skill_index in range(SKILL_IDS.size()):
        var skill_id: String = str(SKILL_IDS[skill_index])
        total_skill_levels += int(skills.get(skill_id, 0))

    return float(total_skill_levels) / float(SKILL_IDS.size())


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
    forced_specialist_skill: String = ""
) -> void:
    var used_names: Array = get_used_villager_names()
    var gender: String = VillagerNameGenerator.generate_gender(rng)
    var villager_name: String = VillagerNameGenerator.generate_name(
        rng,
        gender,
        used_names,
        CURRENT_NAME_ERA
    )

    var generated_skills: Dictionary = generate_villager_skills(forced_specialist_skill)
    var villager_level: float = get_villager_level_from_skills(generated_skills)

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
        "target_tile": Vector2i(-1, -1),
        "harvest_tile": Vector2i(-1, -1),
        "move_timer": 0.0,
        "harvest_timer": 0.0,
        "assigned_harvest_center": NO_ASSIGNED_AREA,
        "assigned_harvest_radius": 0,
        "is_housed": false,
        "skills": generated_skills,
        "level": villager_level,
        "base_speed": BASE_SPEED,
        "speed": BASE_SPEED,
        "belongings": [],
        "max_belongings": get_current_max_belongings(),
        "statuses": [],
        "health_state": HEALTH_STATE_HEALTHY
    }

    update_all_villager_speed_stats()
    update_all_villager_belonging_caps()

    villagers.append(villager_data)
    next_villager_id += 1


func generate_villager_skills(forced_specialist_skill: String = "") -> Dictionary:
    var generated_skills: Dictionary = {}

    var valid_forced_skill: String = ""

    if SKILL_IDS.has(forced_specialist_skill):
        valid_forced_skill = forced_specialist_skill

    var zero_skill: String = get_random_skill_excluding([valid_forced_skill])
    var high_skill: String = valid_forced_skill

    if high_skill == "":
        high_skill = get_random_skill_excluding([zero_skill])

    for skill_index in range(SKILL_IDS.size()):
        var skill_id: String = str(SKILL_IDS[skill_index])

        if skill_id == zero_skill:
            generated_skills[skill_id] = 0
            continue

        if skill_id == high_skill:
            generated_skills[skill_id] = 3
            continue

        if rng.randf() < 0.35:
            generated_skills[skill_id] = 2
        else:
            generated_skills[skill_id] = 1

    return generated_skills


func get_random_skill_excluding(excluded_skills: Array) -> String:
    var valid_skills: Array = []

    for skill_index in range(SKILL_IDS.size()):
        var skill_id: String = str(SKILL_IDS[skill_index])

        if excluded_skills.has(skill_id):
            continue

        valid_skills.append(skill_id)

    if valid_skills.is_empty():
        return str(SKILL_IDS[0])

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

    var villager_index: int = get_villager_index_by_id(villager_id)

    if villager_index < 0:
        result["message"] = "Villager not found."
        return result

    var villager_data: Dictionary = villagers[villager_index]
    var villager_name: String = str(villager_data.get("name", "Villager"))
    var display_role: String = StoneAgeVillagerAssignmentData.get_role_display_name(assignment_role)

    villager_data["assigned_building_instance_id"] = building_instance_id
    villager_data["assigned_building_role"] = assignment_role
    villager_data["assignment_replaces_shelter"] = replaces_shelter

    if not villager_data.has("role"):
        villager_data["role"] = StoneAgeVillagerAssignmentData.get_default_role()

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

    if not villager_data.has("role"):
        villager_data["role"] = StoneAgeVillagerAssignmentData.get_default_role()

    villagers[villager_index] = villager_data

    result["success"] = true
    result["message"] = villager_name + " is no longer assigned to a building."

    return result


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

        villager_data["assigned_harvest_center"] = center_tile
        villager_data["assigned_harvest_radius"] = radius
        villager_data["state"] = VILLAGER_STATE_IDLE
        villager_data["target_tile"] = Vector2i(-1, -1)
        villager_data["harvest_tile"] = Vector2i(-1, -1)
        villager_data["move_timer"] = 0.0
        villager_data["harvest_timer"] = 0.0

        villagers[villager_index] = villager_data

        add_event_message(
            str(villager_data.get("name", "Villager"))
            + " assigned to harvest near "
            + str(center_tile)
            + "."
        )
        return


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


func process_villager(villager_index: int, delta: float, inventory: RegionInventory) -> void:
    if villager_index < 0 or villager_index >= villagers.size():
        return

    var villager_variant: Variant = villagers[villager_index]

    if typeof(villager_variant) != TYPE_DICTIONARY:
        return

    var villager_data: Dictionary = villager_variant
    var villager_state: String = str(villager_data.get("state", VILLAGER_STATE_IDLE))
    var villager_id: int = int(villager_data.get("id", 0))

    match villager_state:
        VILLAGER_STATE_IDLE:
            assign_next_harvest_target(villager_data, villager_id, inventory)

        VILLAGER_STATE_MOVING:
            process_moving_villager(villager_data, delta, inventory)

        VILLAGER_STATE_HARVESTING:
            process_harvesting_villager(villager_data, delta, inventory)

    villagers[villager_index] = villager_data


func assign_next_harvest_target(
    villager_data: Dictionary,
    villager_id: int,
    inventory: RegionInventory
) -> void:
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
        return SKILL_WOOD_WORKING

    if resource_id == RESOURCE_STONE:
        return SKILL_STONE_WORKING

    if resource_id == RESOURCE_FLINT:
        return SKILL_STONE_WORKING

    if resource_id == RESOURCE_BERRIES:
        return SKILL_GATHERING

    if resource_id == RESOURCE_MUSHROOMS:
        return SKILL_GATHERING

    if resource_id == RESOURCE_REEDS:
        return SKILL_GATHERING

    if resource_id == RESOURCE_CLAY:
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

    return clampi(
        skill_level,
        0,
        MAX_SKILL_LEVEL
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
    var level: float = float(villager_data.get("level", 0.0))
    var speed: int = int(villager_data.get("speed", BASE_SPEED))
    var skills: Dictionary = villager_data.get("skills", {})
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var assigned_role: String = str(villager_data.get("assigned_building_role", ""))
    var assigned_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assigned_role)
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))
    print(
        "- ",
        villager_name,
        " (",
        gender,
        ") ",
        "Level ",
        snappedf(level, 0.1),
        ", Speed ",
        speed,
        ", Gathering ",
        int(skills.get(SKILL_GATHERING, 0)),
        ", Wood ",
        int(skills.get(SKILL_WOOD_WORKING, 0)),
        ", Stone ",
        int(skills.get(SKILL_STONE_WORKING, 0)),
        ", Building ",
        int(skills.get(SKILL_BUILDING, 0)),
        ", Hauling ",
        int(skills.get(SKILL_HAULING, 0)),
        ", Medicine ",
        int(skills.get(SKILL_MEDICINE, 0)),
        ", Thinking ",
        int(skills.get(SKILL_THINKING, 0))
        ,
        ", Role ",
           role,
        ", Assigned Role ",
           assigned_role_name,
        ", Assigned Building ",
           assigned_building_instance_id
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
