extends RefCounted
class_name HeroManager

const SAVE_KEY_HEROES: String = "heroes"
const SAVE_KEY_NEXT_HERO_ID: String = "next_hero_id"
const SAVE_KEY_WANDER_SEED: String = "wander_seed"

const SAVE_TYPE_KEY: String = "__save_type"
const SAVE_TYPE_VECTOR2I: String = "Vector2i"
const SAVE_TYPE_VECTOR2: String = "Vector2"

const KEY_ID: String = "id"
const KEY_HERO_TYPE: String = "hero_type"
const KEY_NAME: String = "name"
const KEY_DISPLAY_TYPE: String = "display_type"
const KEY_TILE: String = "tile"
const KEY_WORLD_POSITION: String = "world_position"
const KEY_VISUAL_PIECE: String = "visual_piece"
const KEY_VISUAL_COLOR: String = "visual_color"
const KEY_STATE: String = "state"
const KEY_SOURCE_BUILDING_INSTANCE_ID: String = "source_building_instance_id"
const KEY_SOURCE_BUILDING_ID: String = "source_building_id"
const KEY_WANDER_TIMER: String = "wander_timer"

const HERO_HIT_RADIUS: float = 8.0

const WANDER_INTERVAL_MIN: float = 1.8
const WANDER_INTERVAL_MAX: float = 4.0
const WANDER_CHANCE: float = 0.70

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

var heroes: Array = []
var next_hero_id: int = 1

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0
var region_tile_size: int = 16

var wander_rng := RandomNumberGenerator.new()
var name_rng := RandomNumberGenerator.new()
var wander_seed: int = 0


func setup(
    new_region_tiles: Array,
    new_region_width: int,
    new_region_height: int,
    new_region_tile_size: int
) -> void:
    region_tiles = new_region_tiles
    region_width = new_region_width
    region_height = new_region_height
    region_tile_size = new_region_tile_size

    if wander_seed == 0:
        wander_seed = randi()

    if wander_rng.seed == 0:
        wander_rng.seed = wander_seed

    if name_rng.seed == 0:
        name_rng.seed = wander_seed + 7717


func reset() -> void:
    heroes.clear()
    next_hero_id = 1
    wander_seed = randi()
    wander_rng.seed = wander_seed
    name_rng.seed = wander_seed + 7717


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_HEROES: get_save_safe_value(heroes),
        SAVE_KEY_NEXT_HERO_ID: next_hero_id,
        SAVE_KEY_WANDER_SEED: wander_seed
    }


func load_save_data(save_data: Dictionary) -> void:
    heroes.clear()
    next_hero_id = 1

    if save_data.is_empty():
        return

    next_hero_id = max(1, int(save_data.get(SAVE_KEY_NEXT_HERO_ID, 1)))
    wander_seed = int(save_data.get(SAVE_KEY_WANDER_SEED, 0))

    if wander_seed == 0:
        wander_seed = randi()

    wander_rng.seed = wander_seed
    name_rng.seed = wander_seed + 7717

    var restored_heroes_variant: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_HEROES, [])
    )

    if typeof(restored_heroes_variant) != TYPE_ARRAY:
        return

    var restored_heroes: Array = restored_heroes_variant

    for hero_index in range(restored_heroes.size()):
        var hero_variant: Variant = restored_heroes[hero_index]

        if typeof(hero_variant) != TYPE_DICTIONARY:
            continue

        var hero_data: Dictionary = hero_variant
        sanitize_loaded_hero_data(hero_data)

        if int(hero_data.get(KEY_ID, 0)) <= 0:
            continue

        heroes.append(hero_data)

        var hero_id: int = int(hero_data.get(KEY_ID, 0))

        if hero_id >= next_hero_id:
            next_hero_id = hero_id + 1


func sanitize_loaded_hero_data(hero_data: Dictionary) -> void:
    var hero_type: String = str(hero_data.get(KEY_HERO_TYPE, ""))
    var hero_definition: Dictionary = HeroData.get_hero_definition(hero_type)

    if hero_definition.is_empty():
        return

    hero_data[KEY_HERO_TYPE] = hero_type
    hero_data[KEY_NAME] = str(hero_data.get(KEY_NAME, HeroData.generate_hero_name(name_rng)))
    hero_data[KEY_DISPLAY_TYPE] = HeroData.get_hero_display_name(hero_type)
    hero_data[KEY_VISUAL_PIECE] = HeroData.get_hero_visual_piece(hero_type)
    hero_data[KEY_VISUAL_COLOR] = HeroData.get_hero_visual_color(hero_type)
    hero_data[KEY_STATE] = str(hero_data.get(KEY_STATE, HeroData.HERO_STATE_WANDERING))
    hero_data[KEY_SOURCE_BUILDING_INSTANCE_ID] = int(hero_data.get(KEY_SOURCE_BUILDING_INSTANCE_ID, 0))
    hero_data[KEY_SOURCE_BUILDING_ID] = str(hero_data.get(KEY_SOURCE_BUILDING_ID, ""))
    hero_data[KEY_WANDER_TIMER] = max(0.0, float(hero_data.get(KEY_WANDER_TIMER, get_random_wander_interval())))

    var tile_variant: Variant = hero_data.get(KEY_TILE, Vector2i(-1, -1))

    if typeof(tile_variant) == TYPE_VECTOR2I and is_tile_in_bounds(tile_variant):
        hero_data[KEY_TILE] = tile_variant
    else:
        hero_data[KEY_TILE] = Vector2i(-1, -1)

    var world_position_variant: Variant = hero_data.get(KEY_WORLD_POSITION, Vector2.ZERO)

    if typeof(world_position_variant) == TYPE_VECTOR2:
        hero_data[KEY_WORLD_POSITION] = world_position_variant
    else:
        hero_data[KEY_WORLD_POSITION] = get_world_position_for_tile(hero_data.get(KEY_TILE, Vector2i(-1, -1)))


func try_spawn_hero_from_building(building_data: Dictionary) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": "",
        "hero": {}
    }

    if building_data.is_empty():
        result["message"] = "Cannot spawn hero. Building data is empty."
        return result

    var building_id: String = str(building_data.get("id", ""))
    var hero_type: String = HeroData.get_hero_type_for_building(building_id)

    if hero_type == "":
        result["message"] = ""
        return result

    if has_hero_type(hero_type):
        result["message"] = "The village already has a " + HeroData.get_hero_display_name(hero_type) + "."
        return result

    var building_instance_id: int = int(building_data.get("instance_id", 0))
    var spawn_tile: Vector2i = get_building_center_tile(building_data)

    var hero_data: Dictionary = create_hero(
        hero_type,
        spawn_tile,
        building_instance_id,
        building_id
    )

    heroes.append(hero_data)

    result["success"] = true
    result["hero"] = hero_data.duplicate(true)
    result["message"] = (
        hero_data.get(KEY_NAME, "Hero")
        + " has risen as "
        + HeroData.get_hero_display_name(hero_type)
        + "."
    )

    return result


func create_hero(
    hero_type: String,
    spawn_tile: Vector2i,
    source_building_instance_id: int,
    source_building_id: String
) -> Dictionary:
    var hero_name: String = HeroData.generate_hero_name(name_rng)
    var hero_data := {
        KEY_ID: next_hero_id,
        KEY_HERO_TYPE: hero_type,
        KEY_NAME: hero_name,
        KEY_DISPLAY_TYPE: HeroData.get_hero_display_name(hero_type),
        KEY_TILE: spawn_tile,
        KEY_WORLD_POSITION: get_world_position_for_tile(spawn_tile),
        KEY_VISUAL_PIECE: HeroData.get_hero_visual_piece(hero_type),
        KEY_VISUAL_COLOR: HeroData.get_hero_visual_color(hero_type),
        KEY_STATE: HeroData.HERO_STATE_WANDERING,
        KEY_SOURCE_BUILDING_INSTANCE_ID: source_building_instance_id,
        KEY_SOURCE_BUILDING_ID: source_building_id,
        KEY_WANDER_TIMER: get_random_wander_interval()
    }

    next_hero_id += 1

    return hero_data


func update(delta: float) -> bool:
    if heroes.is_empty():
        return false

    var moved_any: bool = false

    for hero_index in range(heroes.size()):
        var hero_variant: Variant = heroes[hero_index]

        if typeof(hero_variant) != TYPE_DICTIONARY:
            continue

        var hero_data: Dictionary = hero_variant
        var current_timer: float = float(hero_data.get(KEY_WANDER_TIMER, 0.0))
        current_timer -= delta

        if current_timer > 0.0:
            hero_data[KEY_WANDER_TIMER] = current_timer
            heroes[hero_index] = hero_data
            continue

        hero_data[KEY_WANDER_TIMER] = get_random_wander_interval()

        if wander_rng.randf() <= WANDER_CHANCE:
            var did_move: bool = try_wander_hero(hero_data)

            if did_move:
                moved_any = true

        heroes[hero_index] = hero_data

    return moved_any


func try_wander_hero(hero_data: Dictionary) -> bool:
    var current_tile: Vector2i = hero_data.get(KEY_TILE, Vector2i(-1, -1))

    if not is_tile_in_bounds(current_tile):
        return false

    var shuffled_directions: Array = WANDER_DIRECTIONS.duplicate()
    shuffled_directions.shuffle()

    for direction_index in range(shuffled_directions.size()):
        var direction: Vector2i = shuffled_directions[direction_index]
        var target_tile: Vector2i = current_tile + direction

        if not is_tile_walkable_for_hero(target_tile):
            continue

        hero_data[KEY_TILE] = target_tile
        hero_data[KEY_WORLD_POSITION] = get_world_position_for_tile(target_tile)
        return true

    return false


func is_tile_walkable_for_hero(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

    if not bool(tile_data.get("walkable", false)):
        return false

    return true


func has_hero_type(hero_type: String) -> bool:
    for hero_index in range(heroes.size()):
        var hero_variant: Variant = heroes[hero_index]

        if typeof(hero_variant) != TYPE_DICTIONARY:
            continue

        var hero_data: Dictionary = hero_variant

        if str(hero_data.get(KEY_HERO_TYPE, "")) == hero_type:
            return true

    return false


func get_heroes() -> Array:
    return heroes.duplicate(true)


func get_hero_at_world_position(
    world_position: Vector2,
    hit_radius: float = HERO_HIT_RADIUS
) -> Dictionary:
    for hero_index in range(heroes.size()):
        var hero_variant: Variant = heroes[hero_index]

        if typeof(hero_variant) != TYPE_DICTIONARY:
            continue

        var hero_data: Dictionary = hero_variant
        var hero_position: Vector2 = hero_data.get(KEY_WORLD_POSITION, Vector2.ZERO)

        if hero_position.distance_to(world_position) <= hit_radius:
            return hero_data.duplicate(true)

    return {}


func get_hero_at_tile(tile_position: Vector2i) -> Dictionary:
    for hero_index in range(heroes.size()):
        var hero_variant: Variant = heroes[hero_index]

        if typeof(hero_variant) != TYPE_DICTIONARY:
            continue

        var hero_data: Dictionary = hero_variant
        var hero_tile: Vector2i = hero_data.get(KEY_TILE, Vector2i(-1, -1))

        if hero_tile == tile_position:
            return hero_data.duplicate(true)

    return {}


func get_building_center_tile(building_data: Dictionary) -> Vector2i:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 1))
    var height: int = int(building_data.get("height", 1))

    return Vector2i(
        tile_x + int(floor(float(width) / 2.0)),
        tile_y + int(floor(float(height) / 2.0))
    )


func get_world_position_for_tile(tile_position: Vector2i) -> Vector2:
    if not is_tile_in_bounds(tile_position):
        return Vector2.ZERO

    return Vector2(
        tile_position.x * region_tile_size + region_tile_size / 2.0,
        tile_position.y * region_tile_size + region_tile_size / 2.0
    )


func get_random_wander_interval() -> float:
    return wander_rng.randf_range(WANDER_INTERVAL_MIN, WANDER_INTERVAL_MAX)


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < region_width
        and tile_position.y < region_height
    )


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
