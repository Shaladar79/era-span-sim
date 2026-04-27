extends RefCounted
class_name WorldGenerator

const TERRAIN_GRASS: String = "grass"
const TERRAIN_FOREST: String = "forest"
const TERRAIN_HILLS: String = "hills"
const TERRAIN_MOUNTAIN: String = "mountain"
const TERRAIN_WATER: String = "water"
const TERRAIN_SWAMP: String = "swamp"

const SUB_BIOME_NONE: String = "none"
const SUB_BIOME_BASE_MOUNTAIN: String = "base_mountain"
const SUB_BIOME_SNOWY_PEAK: String = "snowy_peak"


static func generate_noise_world(
    grid_width: int,
    grid_height: int,
    world_seed: int
) -> Array:
    var elevation_noise := FastNoiseLite.new()
    var moisture_noise := FastNoiseLite.new()

    setup_elevation_noise(elevation_noise, world_seed)
    setup_moisture_noise(moisture_noise, world_seed)

    var generated_tiles: Array = []

    for y in range(grid_height):
        var row: Array = []

        for x in range(grid_width):
            var elevation := get_normalized_noise(elevation_noise, x, y)
            var moisture := get_normalized_noise(moisture_noise, x, y)
            var terrain := get_terrain_from_noise(elevation, moisture)

            var tile_data := {
                "x": x,
                "y": y,
                "terrain": terrain,
                "biome": get_biome_from_terrain(terrain),
                "sub_biome": get_sub_biome_from_noise(terrain, elevation, moisture),
                "elevation": elevation,
                "moisture": moisture,
                "resources": [],
                "walkable": terrain != TERRAIN_WATER,
                "buildable": terrain != TERRAIN_WATER and terrain != TERRAIN_MOUNTAIN
            }

            row.append(tile_data)

        generated_tiles.append(row)

    return generated_tiles


static func setup_elevation_noise(noise: FastNoiseLite, world_seed: int) -> void:
    noise.seed = world_seed
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.045
    noise.fractal_octaves = 4
    noise.fractal_gain = 0.5


static func setup_moisture_noise(noise: FastNoiseLite, world_seed: int) -> void:
    noise.seed = world_seed + 9999
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.065
    noise.fractal_octaves = 3
    noise.fractal_gain = 0.5


static func get_normalized_noise(noise: FastNoiseLite, x: int, y: int) -> float:
    var raw_value := noise.get_noise_2d(float(x), float(y))

    return (raw_value + 1.0) / 2.0


static func get_terrain_from_noise(elevation: float, moisture: float) -> String:
    if elevation < 0.28:
        return TERRAIN_WATER

    if elevation > 0.80:
        return TERRAIN_MOUNTAIN

    if elevation > 0.64:
        return TERRAIN_HILLS

    if moisture > 0.70 and elevation < 0.44:
        return TERRAIN_SWAMP

    if moisture > 0.58:
        return TERRAIN_FOREST

    return TERRAIN_GRASS


static func get_biome_from_terrain(terrain: String) -> String:
    match terrain:
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
        if elevation > 0.84:
            return SUB_BIOME_SNOWY_PEAK

        return SUB_BIOME_BASE_MOUNTAIN

    return SUB_BIOME_NONE
