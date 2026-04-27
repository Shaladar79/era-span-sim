extends RefCounted
class_name RegionGenerator

const REGION_TERRAIN_GRASS: String = "grass_floor"
const REGION_TERRAIN_FOREST: String = "forest_floor"
const REGION_TERRAIN_DIRT: String = "dirt_patch"
const REGION_TERRAIN_ROCK: String = "rocky_ground"
const REGION_TERRAIN_WATER: String = "shallow_water"
const REGION_TERRAIN_MUD: String = "mud"
const REGION_TERRAIN_SHORE: String = "shoreline"

const FEATURE_NONE: String = "none"
const FEATURE_TREE: String = "tree"
const FEATURE_BUSH: String = "bush"
const FEATURE_STONE: String = "stone_node"
const FEATURE_REEDS: String = "reeds"

const WORLD_TERRAIN_GRASS: String = "grass"
const WORLD_TERRAIN_FOREST: String = "forest"
const WORLD_TERRAIN_HILLS: String = "hills"
const WORLD_TERRAIN_MOUNTAIN: String = "mountain"
const WORLD_TERRAIN_WATER: String = "water"
const WORLD_TERRAIN_OCEAN: String = "ocean"
const WORLD_TERRAIN_SWAMP: String = "swamp"

const RESOURCE_WOOD: String = "wood"
const RESOURCE_BERRIES: String = "berries"
const RESOURCE_MUSHROOMS: String = "mushrooms"
const RESOURCE_STONE: String = "stone"
const RESOURCE_FLINT: String = "flint"
const RESOURCE_REEDS: String = "reeds"
const RESOURCE_CLAY: String = "clay"
const RESOURCE_FISH: String = "fish"
const RESOURCE_FIBER: String = "fiber"


static func generate_region(
    region_width: int,
    region_height: int,
    region_seed: int
) -> Array:
    var fallback_world_tiles: Array = create_fallback_world_selection()

    return generate_region_from_world_selection(
        region_width,
        region_height,
        region_seed,
        fallback_world_tiles
    )


static func generate_region_from_world_selection(
    region_width: int,
    region_height: int,
    region_seed: int,
    selected_world_tiles: Array
) -> Array:
    var rng := RandomNumberGenerator.new()
    rng.seed = region_seed

    var terrain_noise := FastNoiseLite.new()
    var feature_noise := FastNoiseLite.new()
    var contour_noise := FastNoiseLite.new()

    setup_terrain_noise(terrain_noise, region_seed)
    setup_feature_noise(feature_noise, region_seed)
    setup_contour_noise(contour_noise, region_seed)

    var world_selection_height: int = selected_world_tiles.size()
    var world_selection_width: int = 1

    if world_selection_height > 0:
        var first_row_variant: Variant = selected_world_tiles[0]

        if typeof(first_row_variant) == TYPE_ARRAY:
            var first_row: Array = first_row_variant
            world_selection_width = first_row.size()

    var generated_tiles: Array = []

    for y in range(region_height):
        var row: Array = []

        for x in range(region_width):
            var sample_x: float = ((float(x) + 0.5) / float(region_width)) * float(world_selection_width) - 0.5
            var sample_y: float = ((float(y) + 0.5) / float(region_height)) * float(world_selection_height) - 0.5

            var terrain_influences: Dictionary = calculate_terrain_influences(
                selected_world_tiles,
                sample_x,
                sample_y,
                world_selection_width,
                world_selection_height
            )

            var nearest_world_x: int = clampi(int(round(sample_x)), 0, world_selection_width - 1)
            var nearest_world_y: int = clampi(int(round(sample_y)), 0, world_selection_height - 1)
            var source_world_tile: Dictionary = get_world_tile(
                selected_world_tiles,
                nearest_world_x,
                nearest_world_y
            )

            var terrain_value: float = get_normalized_noise(terrain_noise, x, y)
            var feature_value: float = get_normalized_noise(feature_noise, x, y)
            var contour_value: float = get_normalized_noise(contour_noise, x, y)

            var terrain: String = get_regional_terrain_from_influences(
                terrain_influences,
                terrain_value,
                contour_value
            )

            var dominant_world_terrain: String = get_dominant_world_terrain(terrain_influences)

            var feature: String = get_feature_from_influences(
                terrain_influences,
                dominant_world_terrain,
                terrain,
                feature_value,
                rng
            )

            var resources: Array = get_resources_for_region_tile(
                source_world_tile,
                terrain_influences,
                dominant_world_terrain,
                terrain,
                feature,
                rng
            )

            var tile_data := {
                "x": x,
                "y": y,
                "terrain": terrain,
                "feature": feature,
                "source_world_x": int(source_world_tile.get("x", -1)),
                "source_world_y": int(source_world_tile.get("y", -1)),
                "source_world_terrain": dominant_world_terrain,
                "resources": resources,
                "walkable": is_walkable(terrain, feature),
                "buildable": is_buildable(terrain, feature),
                "occupied": false
            }

            row.append(tile_data)

        generated_tiles.append(row)

    return generated_tiles


static func create_fallback_world_selection() -> Array:
    var selected_world_tiles: Array = []

    for y in range(6):
        var row: Array = []

        for x in range(6):
            row.append({
                "x": x,
                "y": y,
                "terrain": WORLD_TERRAIN_FOREST,
                "biome": "forest",
                "sub_biome": "none",
                "elevation": 0.55,
                "moisture": 0.65,
                "resources": [],
                "walkable": true,
                "buildable": true
            })

        selected_world_tiles.append(row)

    return selected_world_tiles


static func setup_terrain_noise(noise: FastNoiseLite, region_seed: int) -> void:
    noise.seed = region_seed
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.085
    noise.fractal_octaves = 3
    noise.fractal_gain = 0.5


static func setup_feature_noise(noise: FastNoiseLite, region_seed: int) -> void:
    noise.seed = region_seed + 7777
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.12
    noise.fractal_octaves = 2
    noise.fractal_gain = 0.5


static func setup_contour_noise(noise: FastNoiseLite, region_seed: int) -> void:
    noise.seed = region_seed + 13337
    noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
    noise.frequency = 0.055
    noise.fractal_octaves = 3
    noise.fractal_gain = 0.5


static func calculate_terrain_influences(
    selected_world_tiles: Array,
    sample_x: float,
    sample_y: float,
    world_selection_width: int,
    world_selection_height: int
) -> Dictionary:
    var terrain_influences: Dictionary = {}

    var base_x: int = int(floor(sample_x))
    var base_y: int = int(floor(sample_y))

    var x0: int = clampi(base_x, 0, world_selection_width - 1)
    var y0: int = clampi(base_y, 0, world_selection_height - 1)
    var x1: int = clampi(base_x + 1, 0, world_selection_width - 1)
    var y1: int = clampi(base_y + 1, 0, world_selection_height - 1)

    var tx: float = clampf(sample_x - floor(sample_x), 0.0, 1.0)
    var ty: float = clampf(sample_y - floor(sample_y), 0.0, 1.0)

    accumulate_world_tile_influence(selected_world_tiles, terrain_influences, x0, y0, (1.0 - tx) * (1.0 - ty))
    accumulate_world_tile_influence(selected_world_tiles, terrain_influences, x1, y0, tx * (1.0 - ty))
    accumulate_world_tile_influence(selected_world_tiles, terrain_influences, x0, y1, (1.0 - tx) * ty)
    accumulate_world_tile_influence(selected_world_tiles, terrain_influences, x1, y1, tx * ty)

    return terrain_influences


static func accumulate_world_tile_influence(
    selected_world_tiles: Array,
    terrain_influences: Dictionary,
    tile_x: int,
    tile_y: int,
    weight: float
) -> void:
    if weight <= 0.0:
        return

    var world_tile: Dictionary = get_world_tile(selected_world_tiles, tile_x, tile_y)
    var terrain_key: String = str(world_tile.get("terrain", WORLD_TERRAIN_GRASS))

    if not terrain_influences.has(terrain_key):
        terrain_influences[terrain_key] = 0.0

    terrain_influences[terrain_key] = float(terrain_influences[terrain_key]) + weight


static func get_world_tile(selected_world_tiles: Array, tile_x: int, tile_y: int) -> Dictionary:
    if selected_world_tiles.is_empty():
        return {}

    var row_variant: Variant = selected_world_tiles[tile_y]

    if typeof(row_variant) != TYPE_ARRAY:
        return {}

    var row: Array = row_variant
    var tile_variant: Variant = row[tile_x]

    if typeof(tile_variant) != TYPE_DICTIONARY:
        return {}

    var world_tile: Dictionary = tile_variant
    return world_tile


static func get_dominant_world_terrain(terrain_influences: Dictionary) -> String:
    if terrain_influences.is_empty():
        return WORLD_TERRAIN_GRASS

    var keys: Array = terrain_influences.keys()
    var best_key: String = WORLD_TERRAIN_GRASS
    var best_value: float = -1.0

    for key_index in range(keys.size()):
        var key_variant: Variant = keys[key_index]
        var key: String = str(key_variant)
        var value: float = float(terrain_influences.get(key, 0.0))

        if value > best_value:
            best_value = value
            best_key = key

    return best_key


static func get_terrain_influence(terrain_influences: Dictionary, terrain_key: String) -> float:
    return float(terrain_influences.get(terrain_key, 0.0))


static func get_normalized_noise(noise: FastNoiseLite, x: int, y: int) -> float:
    var raw_value: float = noise.get_noise_2d(float(x), float(y))

    return (raw_value + 1.0) / 2.0


static func get_regional_terrain_from_influences(
    terrain_influences: Dictionary,
    terrain_value: float,
    contour_value: float
) -> String:
    var ocean_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_OCEAN)
    var lake_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_WATER)
    var swamp_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_SWAMP)
    var forest_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_FOREST)
    var hills_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_HILLS)
    var mountain_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_MOUNTAIN)
    var grass_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_GRASS)

    var water_influence: float = ocean_influence + lake_influence
    var rocky_influence: float = hills_influence + mountain_influence

    var coastline_shift: float = (contour_value - 0.5) * 0.24
    var water_threshold: float = 0.58 + coastline_shift
    var shore_threshold: float = 0.34 + coastline_shift

    if ocean_influence > 0.82:
        if contour_value > 0.94 and water_influence < 0.98:
            return REGION_TERRAIN_SHORE

        return REGION_TERRAIN_WATER

    if water_influence > water_threshold:
        return REGION_TERRAIN_WATER

    if water_influence > shore_threshold:
        if swamp_influence > 0.22:
            return REGION_TERRAIN_MUD

        if rocky_influence > 0.42 and terrain_value > 0.62:
            return REGION_TERRAIN_ROCK

        if forest_influence > 0.30 and contour_value > 0.82:
            return REGION_TERRAIN_GRASS

        return REGION_TERRAIN_SHORE

    if mountain_influence > 0.50:
        if terrain_value > 0.28:
            return REGION_TERRAIN_ROCK

        return REGION_TERRAIN_DIRT

    if hills_influence > 0.42:
        if terrain_value > 0.64:
            return REGION_TERRAIN_ROCK

        if terrain_value < 0.24:
            return REGION_TERRAIN_DIRT

        return REGION_TERRAIN_GRASS

    if swamp_influence > 0.48:
        if terrain_value < 0.30:
            return REGION_TERRAIN_WATER

        if terrain_value < 0.76:
            return REGION_TERRAIN_MUD

        return REGION_TERRAIN_GRASS

    if forest_influence > 0.42:
        if terrain_value > 0.58:
            return REGION_TERRAIN_FOREST

        if terrain_value < 0.20:
            return REGION_TERRAIN_DIRT

        return REGION_TERRAIN_GRASS

    if grass_influence > 0.0:
        if terrain_value < 0.18:
            return REGION_TERRAIN_DIRT

        return REGION_TERRAIN_GRASS

    return REGION_TERRAIN_GRASS


static func get_feature_from_influences(
    terrain_influences: Dictionary,
    dominant_world_terrain: String,
    terrain: String,
    feature_value: float,
    rng: RandomNumberGenerator
) -> String:
    var water_influence: float = (
        get_terrain_influence(terrain_influences, WORLD_TERRAIN_OCEAN)
        + get_terrain_influence(terrain_influences, WORLD_TERRAIN_WATER)
    )

    var swamp_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_SWAMP)
    var forest_influence: float = get_terrain_influence(terrain_influences, WORLD_TERRAIN_FOREST)
    var rocky_influence: float = (
        get_terrain_influence(terrain_influences, WORLD_TERRAIN_HILLS)
        + get_terrain_influence(terrain_influences, WORLD_TERRAIN_MOUNTAIN)
    )

    if terrain == REGION_TERRAIN_WATER:
        return FEATURE_NONE

    if terrain == REGION_TERRAIN_SHORE:
        if swamp_influence > 0.20 and rng.randf() < 0.10:
            return FEATURE_REEDS

        return FEATURE_NONE

    if terrain == REGION_TERRAIN_MUD:
        if water_influence > 0.20 or swamp_influence > 0.20:
            if rng.randf() < 0.38:
                return FEATURE_REEDS

        return FEATURE_NONE

    if terrain == REGION_TERRAIN_ROCK:
        if rocky_influence > 0.25 and rng.randf() < 0.45:
            return FEATURE_STONE

        return FEATURE_NONE

    if terrain == REGION_TERRAIN_DIRT:
        if swamp_influence > 0.25 and rng.randf() < 0.16:
            return FEATURE_REEDS

        return FEATURE_NONE

    if dominant_world_terrain == WORLD_TERRAIN_FOREST or terrain == REGION_TERRAIN_FOREST:
        if feature_value > 0.42:
            return FEATURE_TREE

        if forest_influence > 0.25 and rng.randf() < 0.22:
            return FEATURE_BUSH

        return FEATURE_NONE

    if dominant_world_terrain == WORLD_TERRAIN_GRASS:
        if rng.randf() < 0.16:
            return FEATURE_BUSH

    if dominant_world_terrain == WORLD_TERRAIN_SWAMP:
        if rng.randf() < 0.25:
            return FEATURE_REEDS

    return FEATURE_NONE


static func get_resources_for_region_tile(
    source_world_tile: Dictionary,
    terrain_influences: Dictionary,
    dominant_world_terrain: String,
    terrain: String,
    feature: String,
    rng: RandomNumberGenerator
) -> Array:
    var resources: Array = []

    if feature == FEATURE_TREE:
        try_add_region_resource(resources, rng, RESOURCE_WOOD, "Wood", 1.0, 25, 70)

    if feature == FEATURE_BUSH:
        try_add_region_resource(resources, rng, RESOURCE_BERRIES, "Berries", 0.65, 5, 20)
        try_add_region_resource(resources, rng, RESOURCE_FIBER, "Fiber", 0.35, 4, 14)

    if feature == FEATURE_STONE:
        try_add_region_resource(resources, rng, RESOURCE_STONE, "Stone", 0.90, 18, 55)
        try_add_region_resource(resources, rng, RESOURCE_FLINT, "Flint", 0.25, 3, 12)

    if feature == FEATURE_REEDS:
        try_add_region_resource(resources, rng, RESOURCE_REEDS, "Reeds", 0.90, 8, 28)
        try_add_region_resource(resources, rng, RESOURCE_FIBER, "Fiber", 0.30, 4, 12)

    if terrain == REGION_TERRAIN_WATER:
        var water_influence: float = (
            get_terrain_influence(terrain_influences, WORLD_TERRAIN_OCEAN)
            + get_terrain_influence(terrain_influences, WORLD_TERRAIN_WATER)
        )

        if water_influence > 0.25:
            try_add_region_resource(resources, rng, RESOURCE_FISH, "Fish", 0.35, 5, 22)

    if terrain == REGION_TERRAIN_MUD:
        try_add_region_resource(resources, rng, RESOURCE_CLAY, "Clay", 0.35, 6, 24)
        try_add_region_resource(resources, rng, RESOURCE_MUSHROOMS, "Mushrooms", 0.18, 3, 12)

    if terrain == REGION_TERRAIN_FOREST:
        try_add_region_resource(resources, rng, RESOURCE_MUSHROOMS, "Mushrooms", 0.10, 3, 10)
        try_add_region_resource(resources, rng, RESOURCE_FIBER, "Fiber", 0.12, 3, 12)

    if terrain == REGION_TERRAIN_GRASS:
        if dominant_world_terrain == WORLD_TERRAIN_GRASS:
            try_add_region_resource(resources, rng, RESOURCE_FIBER, "Fiber", 0.10, 3, 10)

    if terrain == REGION_TERRAIN_ROCK:
        var rocky_influence: float = (
            get_terrain_influence(terrain_influences, WORLD_TERRAIN_HILLS)
            + get_terrain_influence(terrain_influences, WORLD_TERRAIN_MOUNTAIN)
        )

        if rocky_influence > 0.40:
            try_add_region_resource(resources, rng, RESOURCE_STONE, "Stone", 0.18, 10, 28)

    return resources


static func try_add_region_resource(
    resources: Array,
    rng: RandomNumberGenerator,
    resource_id: String,
    display_name: String,
    spawn_chance: float,
    amount_min: int,
    amount_max: int
) -> void:
    if rng.randf() > spawn_chance:
        return

    var amount: int = rng.randi_range(amount_min, amount_max)

    var resource_data := {
        "id": resource_id,
        "name": display_name,
        "amount": amount,
        "max_amount": amount,
        "tech_level_min": 0
    }

    resources.append(resource_data)


static func is_walkable(terrain: String, feature: String) -> bool:
    if terrain == REGION_TERRAIN_WATER:
        return false

    if feature == FEATURE_TREE:
        return false

    if feature == FEATURE_STONE:
        return false

    return true


static func is_buildable(terrain: String, feature: String) -> bool:
    if terrain == REGION_TERRAIN_WATER:
        return false

    if terrain == REGION_TERRAIN_ROCK:
        return false

    if terrain == REGION_TERRAIN_MUD:
        return false

    if feature != FEATURE_NONE:
        return false

    return true
