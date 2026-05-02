extends RefCounted
class_name RegionWildAnimalManager

const SAVE_KEY_WILD_ANIMALS: String = "wild_animals"
const SAVE_KEY_NEXT_INSTANCE_ID: String = "next_instance_id"

const KEY_INSTANCE_ID: String = "instance_id"
const KEY_ANIMAL_ID: String = "animal_id"
const KEY_NAME: String = "name"
const KEY_TILE: String = "tile"
const KEY_DANGEROUS: String = "dangerous"
const KEY_DANGER_LEVEL: String = "danger_level"
const KEY_REQUIRED_HUNTERS: String = "required_hunters"
const KEY_YIELDS: String = "yields"
const KEY_CAN_INJURE_HUNTERS: String = "can_injure_hunters"
const KEY_CAN_KILL_HUNTERS: String = "can_kill_hunters"
const KEY_INJURY_CHANCE: String = "injury_chance"
const KEY_DEATH_CHANCE: String = "death_chance"
const KEY_ACTIVE: String = "active"
const KEY_WANDER_TIMER: String = "wander_timer"

const SAVE_TYPE_KEY: String = "__save_type"
const SAVE_TYPE_VECTOR2I: String = "Vector2i"

const WANDER_DIRECTIONS: Array[Vector2i] = [
    Vector2i(1, 0),
    Vector2i(-1, 0),
    Vector2i(0, 1),
    Vector2i(0, -1),
    Vector2i(1, 1),
    Vector2i(1, -1),
    Vector2i(-1, 1),
    Vector2i(-1, -1)
]

var wild_animals: Array = []
var next_instance_id: int = 1

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0

var wander_rng := RandomNumberGenerator.new()


func setup(
    new_region_tiles: Array,
    new_region_width: int,
    new_region_height: int
) -> void:
    region_tiles = new_region_tiles
    region_width = new_region_width
    region_height = new_region_height

    if wander_rng.seed == 0:
        wander_rng.randomize()


func reset() -> void:
    wild_animals.clear()
    next_instance_id = 1


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_WILD_ANIMALS: get_save_safe_value(wild_animals),
        SAVE_KEY_NEXT_INSTANCE_ID: next_instance_id
    }


func load_save_data(save_data: Dictionary) -> void:
    reset()

    if save_data.is_empty():
        return

    next_instance_id = max(1, int(save_data.get(SAVE_KEY_NEXT_INSTANCE_ID, 1)))

    var saved_animals_variant: Variant = save_data.get(SAVE_KEY_WILD_ANIMALS, [])
    var restored_animals_variant: Variant = restore_save_safe_value(saved_animals_variant)

    if typeof(restored_animals_variant) != TYPE_ARRAY:
        return

    var restored_animals: Array = restored_animals_variant

    for animal_index in range(restored_animals.size()):
        var animal_variant: Variant = restored_animals[animal_index]

        if typeof(animal_variant) != TYPE_DICTIONARY:
            continue

        var animal_data: Dictionary = animal_variant
        sanitize_loaded_animal_data(animal_data)

        if int(animal_data.get(KEY_INSTANCE_ID, 0)) <= 0:
            continue

        wild_animals.append(animal_data)

        var instance_id: int = int(animal_data.get(KEY_INSTANCE_ID, 0))

        if instance_id >= next_instance_id:
            next_instance_id = instance_id + 1


func sanitize_loaded_animal_data(animal_data: Dictionary) -> void:
    var animal_id: String = str(animal_data.get(KEY_ANIMAL_ID, ""))
    var base_data: Dictionary = RegionWildAnimalData.get_animal(animal_id)

    if base_data.is_empty():
        return

    animal_data[KEY_ANIMAL_ID] = animal_id
    animal_data[KEY_NAME] = str(animal_data.get(KEY_NAME, base_data.get(RegionWildAnimalData.KEY_NAME, animal_id)))
    animal_data[KEY_DANGEROUS] = bool(animal_data.get(KEY_DANGEROUS, base_data.get(RegionWildAnimalData.KEY_DANGEROUS, false)))
    animal_data[KEY_DANGER_LEVEL] = str(animal_data.get(KEY_DANGER_LEVEL, base_data.get(RegionWildAnimalData.KEY_DANGER_LEVEL, RegionWildAnimalData.DANGER_NONE)))
    animal_data[KEY_REQUIRED_HUNTERS] = max(1, int(animal_data.get(KEY_REQUIRED_HUNTERS, base_data.get(RegionWildAnimalData.KEY_REQUIRED_HUNTERS, 1))))
    animal_data[KEY_YIELDS] = get_dictionary_from_variant(animal_data.get(KEY_YIELDS, base_data.get(RegionWildAnimalData.KEY_YIELDS, {}))).duplicate(true)
    animal_data[KEY_CAN_INJURE_HUNTERS] = bool(animal_data.get(KEY_CAN_INJURE_HUNTERS, base_data.get(RegionWildAnimalData.KEY_CAN_INJURE_HUNTERS, false)))
    animal_data[KEY_CAN_KILL_HUNTERS] = bool(animal_data.get(KEY_CAN_KILL_HUNTERS, base_data.get(RegionWildAnimalData.KEY_CAN_KILL_HUNTERS, false)))
    animal_data[KEY_INJURY_CHANCE] = float(animal_data.get(KEY_INJURY_CHANCE, base_data.get(RegionWildAnimalData.KEY_INJURY_CHANCE, 0.0)))
    animal_data[KEY_DEATH_CHANCE] = float(animal_data.get(KEY_DEATH_CHANCE, base_data.get(RegionWildAnimalData.KEY_DEATH_CHANCE, 0.0)))
    animal_data[KEY_ACTIVE] = bool(animal_data.get(KEY_ACTIVE, true))

    var tile_variant: Variant = animal_data.get(KEY_TILE, Vector2i(-1, -1))

    if typeof(tile_variant) == TYPE_VECTOR2I:
        var tile: Vector2i = tile_variant

        if is_tile_in_bounds(tile):
            animal_data[KEY_TILE] = tile
        else:
            animal_data[KEY_TILE] = Vector2i(-1, -1)
    else:
        animal_data[KEY_TILE] = Vector2i(-1, -1)

    var existing_wander_timer: float = float(animal_data.get(KEY_WANDER_TIMER, -1.0))

    if existing_wander_timer < 0.0:
        animal_data[KEY_WANDER_TIMER] = get_random_wander_interval(
            bool(animal_data.get(KEY_DANGEROUS, false))
        )
    else:
        animal_data[KEY_WANDER_TIMER] = existing_wander_timer


func spawn_stone_age_animals(
    region_seed: int,
    campfire_tiles: Array = []
) -> void:
    reset()

    var rng := RandomNumberGenerator.new()
    rng.seed = region_seed + 94031
    wander_rng.seed = region_seed + 59317

    var spawn_count: int = rng.randi_range(
        StoneAgeTuning.WILD_ANIMAL_REGION_SPAWN_MIN,
        StoneAgeTuning.WILD_ANIMAL_REGION_SPAWN_MAX
    )

    var dangerous_count: int = 0

    for spawn_index in range(spawn_count):
        var wants_dangerous: bool = rng.randf() < StoneAgeTuning.WILD_ANIMAL_DANGEROUS_SPAWN_CHANCE

        if dangerous_count >= StoneAgeTuning.WILD_ANIMAL_MAX_DANGEROUS_SPAWNS:
            wants_dangerous = false

        var animal_pool: Array = []

        if wants_dangerous:
            animal_pool = RegionWildAnimalData.get_dangerous_animals_for_age(RegionWildAnimalData.AGE_STONE)
        else:
            animal_pool = RegionWildAnimalData.get_normal_animals_for_age(RegionWildAnimalData.AGE_STONE)

        if animal_pool.is_empty():
            animal_pool = RegionWildAnimalData.get_stone_age_animals()

        if animal_pool.is_empty():
            continue

        var animal_data: Dictionary = pick_weighted_animal(animal_pool, rng)

        if animal_data.is_empty():
            continue

        var spawn_tile: Vector2i = find_spawn_tile_for_animal(
            animal_data,
            rng,
            campfire_tiles
        )

        if not is_tile_in_bounds(spawn_tile):
            continue

        add_animal_instance(animal_data, spawn_tile)

        if bool(animal_data.get(RegionWildAnimalData.KEY_DANGEROUS, false)):
            dangerous_count += 1


func update_wild_animals(delta: float, campfire_tiles: Array = []) -> bool:
    if wild_animals.is_empty():
        return false

    var moved_any: bool = false

    for animal_index in range(wild_animals.size()):
        var animal_data: Dictionary = wild_animals[animal_index]

        if not bool(animal_data.get(KEY_ACTIVE, true)):
            continue

        var current_timer: float = float(animal_data.get(KEY_WANDER_TIMER, 0.0))
        current_timer -= delta

        if current_timer > 0.0:
            animal_data[KEY_WANDER_TIMER] = current_timer
            wild_animals[animal_index] = animal_data
            continue

        var dangerous: bool = bool(animal_data.get(KEY_DANGEROUS, false))
        animal_data[KEY_WANDER_TIMER] = get_random_wander_interval(dangerous)

        if should_animal_wander(dangerous):
            var did_move: bool = try_wander_animal(animal_index, campfire_tiles)

            if did_move:
                moved_any = true
                continue

        wild_animals[animal_index] = animal_data

    return moved_any


func should_animal_wander(dangerous: bool) -> bool:
    if dangerous:
        return wander_rng.randf() <= StoneAgeTuning.WILD_ANIMAL_DANGEROUS_WANDER_CHANCE

    return wander_rng.randf() <= StoneAgeTuning.WILD_ANIMAL_WANDER_CHANCE


func get_random_wander_interval(dangerous: bool) -> float:
    if dangerous:
        return wander_rng.randf_range(
            StoneAgeTuning.WILD_ANIMAL_DANGEROUS_WANDER_INTERVAL_MIN,
            StoneAgeTuning.WILD_ANIMAL_DANGEROUS_WANDER_INTERVAL_MAX
        )

    return wander_rng.randf_range(
        StoneAgeTuning.WILD_ANIMAL_WANDER_INTERVAL_MIN,
        StoneAgeTuning.WILD_ANIMAL_WANDER_INTERVAL_MAX
    )


func try_wander_animal(
    animal_index: int,
    campfire_tiles: Array
) -> bool:
    if animal_index < 0 or animal_index >= wild_animals.size():
        return false

    var animal_data: Dictionary = wild_animals[animal_index]
    var current_tile: Vector2i = animal_data.get(KEY_TILE, Vector2i(-1, -1))

    if not is_tile_in_bounds(current_tile):
        return false

    var base_data: Dictionary = RegionWildAnimalData.get_animal(
        str(animal_data.get(KEY_ANIMAL_ID, ""))
    )

    if base_data.is_empty():
        return false

    var shuffled_directions: Array = WANDER_DIRECTIONS.duplicate()
    shuffled_directions.shuffle()

    var attempts: int = min(
        StoneAgeTuning.WILD_ANIMAL_WANDER_ATTEMPTS,
        shuffled_directions.size()
    )

    for attempt_index in range(attempts):
        var direction: Vector2i = shuffled_directions[attempt_index]
        var target_tile: Vector2i = current_tile + direction

        if not can_animal_move_to_tile(
            base_data,
            target_tile,
            campfire_tiles,
            int(animal_data.get(KEY_INSTANCE_ID, 0))
        ):
            continue

        animal_data[KEY_TILE] = target_tile
        wild_animals[animal_index] = animal_data
        return true

    wild_animals[animal_index] = animal_data
    return false


func can_animal_move_to_tile(
    animal_data: Dictionary,
    tile: Vector2i,
    campfire_tiles: Array,
    ignored_instance_id: int
) -> bool:
    if not is_tile_in_bounds(tile):
        return false

    if is_tile_too_close_to_other_animals(tile, ignored_instance_id):
        return false

    var tile_data: Dictionary = get_tile_data(tile)

    if tile_data.is_empty():
        return false

    if not bool(tile_data.get("walkable", false)):
        return false

    if bool(tile_data.get("occupied", false)):
        return false

    if is_tile_inside_campfire_avoidance(tile, campfire_tiles):
        return false

    return is_tile_valid_for_animal_terrain(animal_data, tile_data)


func pick_weighted_animal(
    animal_pool: Array,
    rng: RandomNumberGenerator
) -> Dictionary:
    var total_weight: int = 0

    for animal_index in range(animal_pool.size()):
        var animal_variant: Variant = animal_pool[animal_index]

        if typeof(animal_variant) != TYPE_DICTIONARY:
            continue

        var animal_data: Dictionary = animal_variant
        total_weight += max(0, int(animal_data.get(RegionWildAnimalData.KEY_SPAWN_WEIGHT, 0)))

    if total_weight <= 0:
        var fallback_index: int = rng.randi_range(0, animal_pool.size() - 1)
        var fallback_variant: Variant = animal_pool[fallback_index]

        if typeof(fallback_variant) == TYPE_DICTIONARY:
            var fallback_data: Dictionary = fallback_variant
            return fallback_data.duplicate(true)

        return {}

    var roll: int = rng.randi_range(1, total_weight)
    var running_total: int = 0

    for animal_index in range(animal_pool.size()):
        var animal_variant: Variant = animal_pool[animal_index]

        if typeof(animal_variant) != TYPE_DICTIONARY:
            continue

        var animal_data: Dictionary = animal_variant
        running_total += max(0, int(animal_data.get(RegionWildAnimalData.KEY_SPAWN_WEIGHT, 0)))

        if roll <= running_total:
            return animal_data.duplicate(true)

    return {}


func find_spawn_tile_for_animal(
    animal_data: Dictionary,
    rng: RandomNumberGenerator,
    campfire_tiles: Array
) -> Vector2i:
    for attempt_index in range(StoneAgeTuning.WILD_ANIMAL_SPAWN_ATTEMPTS_PER_ANIMAL):
        var x: int = rng.randi_range(
            StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE,
            max(StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE, region_width - StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE - 1)
        )

        var y: int = rng.randi_range(
            StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE,
            max(StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE, region_height - StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE - 1)
        )

        var tile := Vector2i(x, y)

        if not can_animal_spawn_at_tile(animal_data, tile, campfire_tiles):
            continue

        return tile

    return Vector2i(-1, -1)


func can_animal_spawn_at_tile(
    animal_data: Dictionary,
    tile: Vector2i,
    campfire_tiles: Array
) -> bool:
    if not is_tile_in_bounds(tile):
        return false

    var tile_data: Dictionary = get_tile_data(tile)

    if tile_data.is_empty():
        return false

    if not bool(tile_data.get("walkable", false)):
        return false

    if bool(tile_data.get("occupied", false)):
        return false

    if is_tile_too_close_to_other_animals(tile):
        return false

    if is_tile_inside_campfire_avoidance(tile, campfire_tiles):
        return false

    return is_tile_valid_for_animal_terrain(animal_data, tile_data)


func is_tile_valid_for_animal_terrain(
    animal_data: Dictionary,
    tile_data: Dictionary
) -> bool:
    var terrain_bias: Array = animal_data.get(RegionWildAnimalData.KEY_TERRAIN_BIAS, [])

    if terrain_bias.is_empty():
        return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_ANY):
        return true

    var terrain: String = str(tile_data.get("terrain", ""))
    var source_world_terrain: String = str(tile_data.get("source_world_terrain", ""))

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_GRASS):
        if terrain == RegionGenerator.REGION_TERRAIN_GRASS or source_world_terrain == RegionGenerator.WORLD_TERRAIN_GRASS:
            return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_FOREST):
        if terrain == RegionGenerator.REGION_TERRAIN_FOREST or source_world_terrain == RegionGenerator.WORLD_TERRAIN_FOREST:
            return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_HILLS):
        if source_world_terrain == RegionGenerator.WORLD_TERRAIN_HILLS:
            return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_MOUNTAIN_EDGE):
        if source_world_terrain == RegionGenerator.WORLD_TERRAIN_MOUNTAIN or terrain == RegionGenerator.REGION_TERRAIN_ROCK:
            return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_TUNDRA):
        if terrain == RegionGenerator.REGION_TERRAIN_TUNDRA or source_world_terrain == RegionGenerator.WORLD_TERRAIN_TUNDRA:
            return true

    if terrain_bias.has(RegionWildAnimalData.TERRAIN_WATER_EDGE):
        if terrain == RegionGenerator.REGION_TERRAIN_SHORE:
            return true

    return false


func is_tile_too_close_to_other_animals(
    tile: Vector2i,
    ignored_instance_id: int = 0
) -> bool:
    for animal_index in range(wild_animals.size()):
        var animal_data: Dictionary = wild_animals[animal_index]

        if not bool(animal_data.get(KEY_ACTIVE, true)):
            continue

        var instance_id: int = int(animal_data.get(KEY_INSTANCE_ID, 0))

        if ignored_instance_id > 0 and instance_id == ignored_instance_id:
            continue

        var animal_tile: Vector2i = animal_data.get(KEY_TILE, Vector2i(-1, -1))

        if animal_tile == Vector2i(-1, -1):
            continue

        var distance: int = abs(animal_tile.x - tile.x) + abs(animal_tile.y - tile.y)

        if distance < StoneAgeTuning.WILD_ANIMAL_MIN_DISTANCE_BETWEEN_ANIMALS:
            return true

    return false


func is_tile_inside_campfire_avoidance(
    tile: Vector2i,
    campfire_tiles: Array
) -> bool:
    if campfire_tiles.is_empty():
        return false

    var avoid_radius: int = get_campfire_avoidance_radius()

    for campfire_index in range(campfire_tiles.size()):
        var campfire_variant: Variant = campfire_tiles[campfire_index]

        if typeof(campfire_variant) != TYPE_VECTOR2I:
            continue

        var campfire_tile: Vector2i = campfire_variant
        var distance: int = abs(campfire_tile.x - tile.x) + abs(campfire_tile.y - tile.y)

        if distance <= avoid_radius:
            return true

    return false


func get_campfire_avoidance_radius() -> int:
    return 6 + StoneAgeTuning.WILD_ANIMAL_CAMPFIRE_AVOIDANCE_RADIUS_BONUS


func add_animal_instance(
    animal_base_data: Dictionary,
    tile: Vector2i
) -> Dictionary:
    var dangerous: bool = bool(animal_base_data.get(RegionWildAnimalData.KEY_DANGEROUS, false))

    var animal_instance := {
        KEY_INSTANCE_ID: next_instance_id,
        KEY_ANIMAL_ID: str(animal_base_data.get(RegionWildAnimalData.KEY_ID, "")),
        KEY_NAME: str(animal_base_data.get(RegionWildAnimalData.KEY_NAME, "Animal")),
        KEY_TILE: tile,
        KEY_DANGEROUS: dangerous,
        KEY_DANGER_LEVEL: str(animal_base_data.get(RegionWildAnimalData.KEY_DANGER_LEVEL, RegionWildAnimalData.DANGER_NONE)),
        KEY_REQUIRED_HUNTERS: int(animal_base_data.get(RegionWildAnimalData.KEY_REQUIRED_HUNTERS, 1)),
        KEY_YIELDS: get_dictionary_from_variant(animal_base_data.get(RegionWildAnimalData.KEY_YIELDS, {})).duplicate(true),
        KEY_CAN_INJURE_HUNTERS: bool(animal_base_data.get(RegionWildAnimalData.KEY_CAN_INJURE_HUNTERS, false)),
        KEY_CAN_KILL_HUNTERS: bool(animal_base_data.get(RegionWildAnimalData.KEY_CAN_KILL_HUNTERS, false)),
        KEY_INJURY_CHANCE: float(animal_base_data.get(RegionWildAnimalData.KEY_INJURY_CHANCE, 0.0)),
        KEY_DEATH_CHANCE: float(animal_base_data.get(RegionWildAnimalData.KEY_DEATH_CHANCE, 0.0)),
        KEY_ACTIVE: true,
        KEY_WANDER_TIMER: get_random_wander_interval(dangerous)
    }

    next_instance_id += 1
    wild_animals.append(animal_instance)

    return animal_instance


func relocate_animals_away_from_campfires(campfire_tiles: Array) -> int:
    if campfire_tiles.is_empty():
        return 0

    var rng := RandomNumberGenerator.new()
    rng.randomize()

    var moved_count: int = 0

    for animal_index in range(wild_animals.size()):
        var animal_data: Dictionary = wild_animals[animal_index]

        if not bool(animal_data.get(KEY_ACTIVE, true)):
            continue

        var current_tile: Vector2i = animal_data.get(KEY_TILE, Vector2i(-1, -1))

        if not is_tile_inside_campfire_avoidance(current_tile, campfire_tiles):
            continue

        var base_data: Dictionary = RegionWildAnimalData.get_animal(
            str(animal_data.get(KEY_ANIMAL_ID, ""))
        )

        if base_data.is_empty():
            continue

        var new_tile: Vector2i = find_spawn_tile_for_animal(
            base_data,
            rng,
            campfire_tiles
        )

        if not is_tile_in_bounds(new_tile):
            continue

        animal_data[KEY_TILE] = new_tile
        animal_data[KEY_WANDER_TIMER] = get_random_wander_interval(
            bool(animal_data.get(KEY_DANGEROUS, false))
        )
        wild_animals[animal_index] = animal_data
        moved_count += 1

    return moved_count


func get_active_animals() -> Array:
    var active_animals: Array = []

    for animal_index in range(wild_animals.size()):
        var animal_data: Dictionary = wild_animals[animal_index]

        if not bool(animal_data.get(KEY_ACTIVE, true)):
            continue

        active_animals.append(animal_data)

    return active_animals


func get_animal_at_tile(tile: Vector2i) -> Dictionary:
    for animal_index in range(wild_animals.size()):
        var animal_data: Dictionary = wild_animals[animal_index]

        if not bool(animal_data.get(KEY_ACTIVE, true)):
            continue

        var animal_tile: Vector2i = animal_data.get(KEY_TILE, Vector2i(-1, -1))

        if animal_tile == tile:
            return animal_data

    return {}


func get_tile_data(tile: Vector2i) -> Dictionary:
    if not is_tile_in_bounds(tile):
        return {}

    var row_variant: Variant = region_tiles[tile.y]

    if typeof(row_variant) != TYPE_ARRAY:
        return {}

    var row: Array = row_variant
    var tile_variant: Variant = row[tile.x]

    if typeof(tile_variant) != TYPE_DICTIONARY:
        return {}

    return tile_variant


func is_tile_in_bounds(tile: Vector2i) -> bool:
    return (
        tile.x >= 0
        and tile.y >= 0
        and tile.x < region_width
        and tile.y < region_height
    )


func get_dictionary_from_variant(value: Variant) -> Dictionary:
    if typeof(value) != TYPE_DICTIONARY:
        return {}

    var dictionary_value: Dictionary = value
    return dictionary_value


func get_save_safe_value(value: Variant) -> Variant:
    match typeof(value):
        TYPE_VECTOR2I:
            var vector_i_value: Vector2i = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2I,
                "x": vector_i_value.x,
                "y": vector_i_value.y
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
