extends RefCounted
class_name ResourceSpawner

const RESOURCE_WOOD: String = "wood"
const RESOURCE_BERRIES: String = "berries"
const RESOURCE_MUSHROOMS: String = "mushrooms"
const RESOURCE_STONE: String = "stone"
const RESOURCE_FLINT: String = "flint"
const RESOURCE_REEDS: String = "reeds"
const RESOURCE_CLAY: String = "clay"
const RESOURCE_FISH: String = "fish"
const RESOURCE_FIBER: String = "fiber"

const TERRAIN_GRASS: String = "grass"
const TERRAIN_FOREST: String = "forest"
const TERRAIN_HILLS: String = "hills"
const TERRAIN_MOUNTAIN: String = "mountain"
const TERRAIN_WATER: String = "water"
const TERRAIN_OCEAN: String = "ocean"
const TERRAIN_SWAMP: String = "swamp"


static func add_resources_to_tile(tile_data: Dictionary, rng: RandomNumberGenerator) -> Dictionary:
    var terrain: String = str(tile_data.get("terrain", TERRAIN_GRASS))
    var elevation: float = float(tile_data.get("elevation", 0.0))
    var moisture: float = float(tile_data.get("moisture", 0.0))

    tile_data["resources"] = []

    match terrain:
        TERRAIN_FOREST:
            add_forest_resources(tile_data, rng, elevation, moisture)
        TERRAIN_GRASS:
            add_plains_resources(tile_data, rng, elevation, moisture)
        TERRAIN_HILLS:
            add_hills_resources(tile_data, rng, elevation, moisture)
        TERRAIN_MOUNTAIN:
            add_mountain_resources(tile_data, rng, elevation, moisture)
        TERRAIN_SWAMP:
            add_swamp_resources(tile_data, rng, elevation, moisture)
        TERRAIN_WATER:
            add_water_resources(tile_data, rng, elevation, moisture)
        TERRAIN_OCEAN:
            add_ocean_resources(tile_data, rng, elevation, moisture)
        _:
            pass

    return tile_data


static func add_forest_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_WOOD, "Wood", 0.90, 25, 80)
    try_add_resource(tile_data, rng, RESOURCE_BERRIES, "Berries", 0.35, 8, 30)
    try_add_resource(tile_data, rng, RESOURCE_MUSHROOMS, "Mushrooms", 0.25, 5, 20)
    try_add_resource(tile_data, rng, RESOURCE_FIBER, "Fiber", 0.30, 8, 24)


static func add_plains_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_BERRIES, "Berries", 0.25, 6, 20)
    try_add_resource(tile_data, rng, RESOURCE_FIBER, "Fiber", 0.45, 10, 35)


static func add_hills_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_STONE, "Stone", 0.70, 20, 70)
    try_add_resource(tile_data, rng, RESOURCE_FLINT, "Flint", 0.25, 5, 20)


static func add_mountain_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_STONE, "Stone", 0.85, 35, 120)
    try_add_resource(tile_data, rng, RESOURCE_FLINT, "Flint", 0.35, 8, 30)


static func add_swamp_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_REEDS, "Reeds", 0.55, 10, 40)
    try_add_resource(tile_data, rng, RESOURCE_CLAY, "Clay", 0.45, 10, 45)
    try_add_resource(tile_data, rng, RESOURCE_MUSHROOMS, "Mushrooms", 0.25, 5, 20)


static func add_water_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_FISH, "Fish", 0.55, 8, 35)


static func add_ocean_resources(tile_data: Dictionary, rng: RandomNumberGenerator, elevation: float, moisture: float) -> void:
    try_add_resource(tile_data, rng, RESOURCE_FISH, "Fish", 0.45, 10, 45)


static func try_add_resource(
    tile_data: Dictionary,
    rng: RandomNumberGenerator,
    resource_id: String,
    display_name: String,
    spawn_chance: float,
    amount_min: int,
    amount_max: int
) -> void:
    if rng.randf() > spawn_chance:
        return

    var amount := rng.randi_range(amount_min, amount_max)

    var resource_data := {
        "id": resource_id,
        "name": display_name,
        "amount": amount,
        "max_amount": amount,
        "tech_level_min": 0
    }

    tile_data["resources"].append(resource_data)
