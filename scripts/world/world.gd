extends Node2D

const GRID_WIDTH: int = 60
const GRID_HEIGHT: int = 40
const TILE_SIZE: int = 16

const TERRAIN_GRASS: String = WorldGenerator.TERRAIN_GRASS
const TERRAIN_FOREST: String = WorldGenerator.TERRAIN_FOREST
const TERRAIN_HILLS: String = WorldGenerator.TERRAIN_HILLS
const TERRAIN_MOUNTAIN: String = WorldGenerator.TERRAIN_MOUNTAIN
const TERRAIN_WATER: String = WorldGenerator.TERRAIN_WATER
const TERRAIN_SWAMP: String = WorldGenerator.TERRAIN_SWAMP

const SUB_BIOME_BASE_MOUNTAIN: String = WorldGenerator.SUB_BIOME_BASE_MOUNTAIN
const SUB_BIOME_SNOWY_PEAK: String = WorldGenerator.SUB_BIOME_SNOWY_PEAK

@export var world_seed: int = 12345
@export var use_random_seed: bool = false
@export var tile_info_label_path: NodePath

var rng := RandomNumberGenerator.new()
var tiles: Array = []
var hovered_tile: Vector2i = Vector2i(-1, -1)
var tile_info_label: Label = null


func _ready() -> void:
    if tile_info_label_path != NodePath(""):
        var found_node := get_node_or_null(tile_info_label_path)

        if found_node is Label:
            tile_info_label = found_node
        else:
            push_warning("Tile info label path does not point to a Label node.")

    setup_seed()
    generate_world()
    update_tile_info_label()
    queue_redraw()


func _process(_delta: float) -> void:
    update_hovered_tile()


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_R:
            regenerate_world()


func setup_seed() -> void:
    if use_random_seed:
        rng.randomize()
        world_seed = rng.randi()

    rng.seed = world_seed

    print("World Seed: ", world_seed)


func generate_world() -> void:
    tiles = WorldGenerator.generate_noise_world(
        GRID_WIDTH,
        GRID_HEIGHT,
        world_seed
    )


func regenerate_world() -> void:
    rng.randomize()
    world_seed = rng.randi()
    setup_seed()
    generate_world()
    update_tile_info_label()
    queue_redraw()

    print("Regenerated world.")


func update_hovered_tile() -> void:
    var mouse_world_position := get_global_mouse_position()
    var tile_x := int(floor(mouse_world_position.x / TILE_SIZE))
    var tile_y := int(floor(mouse_world_position.y / TILE_SIZE))

    var new_hovered_tile := Vector2i(tile_x, tile_y)

    if new_hovered_tile != hovered_tile:
        hovered_tile = new_hovered_tile
        update_tile_info_label()
        queue_redraw()


func update_tile_info_label() -> void:
    if tile_info_label == null:
        return

    if not is_tile_in_bounds(hovered_tile):
        tile_info_label.text = "Tile: outside map"
        return

    var tile_data: Dictionary = tiles[hovered_tile.y][hovered_tile.x]

    var elevation_text := str(snapped(float(tile_data.get("elevation", 0.0)), 0.001))
    var moisture_text := str(snapped(float(tile_data.get("moisture", 0.0)), 0.001))

    tile_info_label.text = (
        "Tile: " + str(hovered_tile.x) + ", " + str(hovered_tile.y) + "\n"
        + "Terrain: " + str(tile_data.get("terrain", "unknown")) + "\n"
        + "Biome: " + str(tile_data.get("biome", "unknown")) + "\n"
        + "Sub-Biome: " + str(tile_data.get("sub_biome", "none")) + "\n"
        + "Elevation: " + elevation_text + "\n"
        + "Moisture: " + moisture_text + "\n"
        + "Walkable: " + str(tile_data.get("walkable", false)) + "\n"
        + "Buildable: " + str(tile_data.get("buildable", false))
    )


func _draw() -> void:
    draw_world_tiles()
    draw_grid_lines()
    draw_hovered_tile()


func draw_world_tiles() -> void:
    for y in range(GRID_HEIGHT):
        for x in range(GRID_WIDTH):
            var tile_data = tiles[y][x]
            var tile_color := get_tile_color(tile_data)

            var tile_position := Vector2(x * TILE_SIZE, y * TILE_SIZE)
            var tile_rect := Rect2(tile_position, Vector2(TILE_SIZE, TILE_SIZE))

            draw_rect(tile_rect, tile_color, true)


func draw_grid_lines() -> void:
    var grid_color := Color(0, 0, 0, 0.35)

    for x in range(GRID_WIDTH + 1):
        var start_pos := Vector2(x * TILE_SIZE, 0)
        var end_pos := Vector2(x * TILE_SIZE, GRID_HEIGHT * TILE_SIZE)
        draw_line(start_pos, end_pos, grid_color, 1.0)

    for y in range(GRID_HEIGHT + 1):
        var start_pos := Vector2(0, y * TILE_SIZE)
        var end_pos := Vector2(GRID_WIDTH * TILE_SIZE, y * TILE_SIZE)
        draw_line(start_pos, end_pos, grid_color, 1.0)


func draw_hovered_tile() -> void:
    if not is_tile_in_bounds(hovered_tile):
        return

    var tile_position := Vector2(hovered_tile.x * TILE_SIZE, hovered_tile.y * TILE_SIZE)
    var tile_rect := Rect2(tile_position, Vector2(TILE_SIZE, TILE_SIZE))

    draw_rect(tile_rect, Color(1, 1, 1, 0.25), true)
    draw_rect(tile_rect, Color(1, 1, 1, 0.9), false, 2.0)


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < GRID_WIDTH
        and tile_position.y < GRID_HEIGHT
    )


func get_tile_color(tile_data: Dictionary) -> Color:
    match tile_data.get("terrain", TERRAIN_GRASS):
        TERRAIN_GRASS:
            return Color(0.25, 0.65, 0.25)
        TERRAIN_FOREST:
            return Color(0.05, 0.35, 0.12)
        TERRAIN_HILLS:
            return Color(0.45, 0.32, 0.16)
        TERRAIN_MOUNTAIN:
            if tile_data.get("sub_biome", SUB_BIOME_BASE_MOUNTAIN) == SUB_BIOME_SNOWY_PEAK:
                return Color(0.88, 0.92, 0.95)

            return Color(0.45, 0.45, 0.45)
        TERRAIN_WATER:
            return Color(0.1, 0.35, 0.75)
        TERRAIN_SWAMP:
            return Color(0.2, 0.38, 0.18)
        _:
            return Color(1, 0, 1)
