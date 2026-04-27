extends RefCounted
class_name WorldGenerator

const TERRAIN_GRASS: String = "grass"
const TERRAIN_FOREST: String = "forest"
const TERRAIN_HILLS: String = "hills"
const TERRAIN_MOUNTAIN: String = "mountain"
const TERRAIN_WATER: String = "water"
const TERRAIN_OCEAN: String = "ocean"
const TERRAIN_SWAMP: String = "swamp"

const SUB_BIOME_NONE: String = "none"
const SUB_BIOME_BASE_MOUNTAIN: String = "base_mountain"
const SUB_BIOME_SNOWY_PEAK: String = "snowy_peak"

const OCEAN_EDGE_WIDTH: int = 8
const ADDITIONAL_OCEAN_TARGET_RATIO: float = 0.20
const OCEAN_MIN_BODY_SIZE: int = 120


static func generate_noise_world(
    grid_width: int,
    grid_height: int,
    world_seed: int
) -> Array:
    var rng := RandomNumberGenerator.new()
    rng.seed = world_seed + 2222

    var elevation_noise := FastNoiseLite.new()
    var moisture_noise := FastNoiseLite.new()

    setup_elevation_noise(elevation_noise, world_seed)
    setup_moisture_noise(moisture_noise, world_seed)

    var elevation_map := generate_elevation_map(grid_width, grid_height, elevation_noise)
    var moisture_map := generate_moisture_map(grid_width, grid_height, moisture_noise)
    var ocean_map := generate_ocean_map(grid_width, grid_height, elevation_map)

    var generated_tiles: Array = []

    for y in range(grid_height):
        var row: Array = []

        for x in range(grid_width):
            var elevation: float = elevation_map[y][x]
            var moisture: float = moisture_map[y][x]
            var is_ocean: bool = ocean_map[y][x]
            var terrain := get_terrain_from_noise(elevation, moisture, is_ocean)

            var tile_data := {
                "x": x,
                "y": y,
                "terrain": terrain,
                "biome": get_biome_from_terrain(terrain),
                "sub_biome": get_sub_biome_from_noise(terrain, elevation, moisture),
                "elevation": elevation,
                "moisture": moisture,
                "resources": [],
                "walkable": terrain != TERRAIN_WATER and terrain != TERRAIN_OCEAN,
                "buildable": terrain != TERRAIN_WATER and terrain != TERRAIN_OCEAN and terrain != TERRAIN_MOUNTAIN
            }

            tile_data = ResourceSpawner.add_resources_to_tile(tile_data, rng)

            row.append(tile_data)

        generated_tiles.append(row)

    return generated_tiles


static func setup_elevation_noise(noise: FastNoiseLite, world_seed: int) -> void:
    noise.seed = world_seed
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.035
    noise.fractal_octaves = 4
    noise.fractal_gain = 0.5


static func setup_moisture_noise(noise: FastNoiseLite, world_seed: int) -> void:
    noise.seed = world_seed + 9999
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.065
    noise.fractal_octaves = 3
    noise.fractal_gain = 0.5


static func generate_elevation_map(grid_width: int, grid_height: int, elevation_noise: FastNoiseLite) -> Array:
    var elevation_map: Array = []

    for y in range(grid_height):
        var row: Array = []

        for x in range(grid_width):
            row.append(get_normalized_noise(elevation_noise, x, y))

        elevation_map.append(row)

    return elevation_map


static func generate_moisture_map(grid_width: int, grid_height: int, moisture_noise: FastNoiseLite) -> Array:
    var moisture_map: Array = []

    for y in range(grid_height):
        var row: Array = []

        for x in range(grid_width):
            row.append(get_normalized_noise(moisture_noise, x, y))

        moisture_map.append(row)

    return moisture_map


static func generate_ocean_map(grid_width: int, grid_height: int, elevation_map: Array) -> Array:
    var water_candidate_map := create_bool_map(grid_width, grid_height, false)

    for y in range(grid_height):
        for x in range(grid_width):
            if is_forced_ocean_edge(x, y, grid_width, grid_height):
                water_candidate_map[y][x] = true

    add_low_elevation_ocean_candidates(
        water_candidate_map,
        elevation_map,
        grid_width,
        grid_height
    )

    return classify_ocean_bodies(water_candidate_map, grid_width, grid_height)


static func create_bool_map(grid_width: int, grid_height: int, default_value: bool) -> Array:
    var map_data: Array = []

    for y in range(grid_height):
        var row: Array = []

        for x in range(grid_width):
            row.append(default_value)

        map_data.append(row)

    return map_data


static func is_forced_ocean_edge(x: int, y: int, grid_width: int, grid_height: int) -> bool:
    return (
        x < OCEAN_EDGE_WIDTH
        or y < OCEAN_EDGE_WIDTH
        or x >= grid_width - OCEAN_EDGE_WIDTH
        or y >= grid_height - OCEAN_EDGE_WIDTH
    )


static func add_low_elevation_ocean_candidates(
    water_candidate_map: Array,
    elevation_map: Array,
    grid_width: int,
    grid_height: int
) -> void:
    var candidates: Array = []

    for y in range(grid_height):
        for x in range(grid_width):
            if water_candidate_map[y][x]:
                continue

            candidates.append({
                "x": x,
                "y": y,
                "elevation": float(elevation_map[y][x])
            })

    candidates.sort_custom(compare_elevation_candidates)

    var additional_ocean_tiles: int = int(float(grid_width * grid_height) * ADDITIONAL_OCEAN_TARGET_RATIO)
    var tiles_to_mark: int = mini(additional_ocean_tiles, candidates.size())

    for i in range(tiles_to_mark):
        var candidate: Dictionary = candidates[i]
        var tile_x: int = int(candidate["x"])
        var tile_y: int = int(candidate["y"])

        water_candidate_map[tile_y][tile_x] = true


static func compare_elevation_candidates(a: Dictionary, b: Dictionary) -> bool:
    return float(a["elevation"]) < float(b["elevation"])


static func classify_ocean_bodies(water_candidate_map: Array, grid_width: int, grid_height: int) -> Array:
    var ocean_map := create_bool_map(grid_width, grid_height, false)
    var visited_map := create_bool_map(grid_width, grid_height, false)

    for y in range(grid_height):
        for x in range(grid_width):
            if visited_map[y][x]:
                continue

            if not water_candidate_map[y][x]:
                continue

            var body_tiles := flood_fill_water_body(
                x,
                y,
                water_candidate_map,
                visited_map,
                grid_width,
                grid_height
            )

            var body_touches_edge := water_body_touches_forced_edge(body_tiles, grid_width, grid_height)
            var body_is_large_enough := body_tiles.size() >= OCEAN_MIN_BODY_SIZE

            if body_touches_edge or body_is_large_enough:
                mark_body_as_ocean(body_tiles, ocean_map)

    return ocean_map


static func flood_fill_water_body(
    start_x: int,
    start_y: int,
    water_candidate_map: Array,
    visited_map: Array,
    grid_width: int,
    grid_height: int
) -> Array:
    var body_tiles: Array = []
    var open_tiles: Array = [Vector2i(start_x, start_y)]

    visited_map[start_y][start_x] = true

    while not open_tiles.is_empty():
        var current: Vector2i = open_tiles.pop_back()
        body_tiles.append(current)

        var neighbors := [
            Vector2i(current.x + 1, current.y),
            Vector2i(current.x - 1, current.y),
            Vector2i(current.x, current.y + 1),
            Vector2i(current.x, current.y - 1)
        ]

        for neighbor in neighbors:
            if not is_position_in_bounds(neighbor, grid_width, grid_height):
                continue

            if visited_map[neighbor.y][neighbor.x]:
                continue

            if not water_candidate_map[neighbor.y][neighbor.x]:
                continue

            visited_map[neighbor.y][neighbor.x] = true
            open_tiles.append(neighbor)

    return body_tiles


static func is_position_in_bounds(position: Vector2i, grid_width: int, grid_height: int) -> bool:
    return (
        position.x >= 0
        and position.y >= 0
        and position.x < grid_width
        and position.y < grid_height
    )


static func water_body_touches_forced_edge(body_tiles: Array, grid_width: int, grid_height: int) -> bool:
    for tile_index in range(body_tiles.size()):
        var tile_position: Vector2i = body_tiles[tile_index]

        if is_forced_ocean_edge(tile_position.x, tile_position.y, grid_width, grid_height):
            return true

    return false


static func mark_body_as_ocean(body_tiles: Array, ocean_map: Array) -> void:
    for tile_index in range(body_tiles.size()):
        var tile_position: Vector2i = body_tiles[tile_index]
        ocean_map[tile_position.y][tile_position.x] = true


static func get_normalized_noise(noise: FastNoiseLite, x: int, y: int) -> float:
    var raw_value := noise.get_noise_2d(float(x), float(y))

    return (raw_value + 1.0) / 2.0


static func get_terrain_from_noise(elevation: float, moisture: float, is_ocean: bool) -> String:
    if is_ocean:
        return TERRAIN_OCEAN

    if elevation < 0.46 and moisture > 0.72:
        return TERRAIN_WATER

    if elevation > 0.82:
        return TERRAIN_MOUNTAIN

    if elevation > 0.66:
        return TERRAIN_HILLS

    if moisture > 0.72 and elevation < 0.52:
        return TERRAIN_SWAMP

    if moisture > 0.58:
        return TERRAIN_FOREST

    return TERRAIN_GRASS


static func get_biome_from_terrain(terrain: String) -> String:
    match terrain:
        TERRAIN_OCEAN:
            return "ocean"
        TERRAIN_WATER:
            return "water"
        TERRAIN_MOUNTAIN:
            return "mountain"
        TERRAIN_HILLS:
            return "hills"
        TERRAIN_SWAMP:
            return "swamp"
        TERRAIN_FOREST:
            return "forest"
        TERRAIN_GRASS:
            return "plains"
        _:
            return "unknown"


static func get_sub_biome_from_noise(terrain: String, elevation: float, moisture: float) -> String:
    if terrain == TERRAIN_MOUNTAIN:
        if elevation > 0.86:
            return SUB_BIOME_SNOWY_PEAK

        return SUB_BIOME_BASE_MOUNTAIN

    return SUB_BIOME_NONE
