extends Node2D

const GRID_WIDTH: int = 60
const GRID_HEIGHT: int = 40
const TILE_SIZE: int = 16

var tiles: Array = []
var hovered_tile: Vector2i = Vector2i(-1, -1)


func _ready() -> void:
    generate_empty_world()
    queue_redraw()


func _process(_delta: float) -> void:
    update_hovered_tile()


func generate_empty_world() -> void:
    tiles.clear()

    for y in range(GRID_HEIGHT):
        var row: Array = []

        for x in range(GRID_WIDTH):
            var tile_data := {
                "x": x,
                "y": y,
                "terrain": "grass",
                "biome": "plains",
                "resources": [],
                "walkable": true,
                "buildable": true
            }

            row.append(tile_data)

        tiles.append(row)


func update_hovered_tile() -> void:
    var mouse_world_position := get_global_mouse_position()
    var tile_x := int(floor(mouse_world_position.x / TILE_SIZE))
    var tile_y := int(floor(mouse_world_position.y / TILE_SIZE))

    var new_hovered_tile := Vector2i(tile_x, tile_y)

    if new_hovered_tile != hovered_tile:
        hovered_tile = new_hovered_tile
        queue_redraw()


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
    match tile_data.get("terrain", "grass"):
        "grass":
            return Color(0.25, 0.65, 0.25)
        "forest":
            return Color(0.05, 0.35, 0.12)
        "hills":
            return Color(0.45, 0.32, 0.16)
        "mountain":
            return Color(0.45, 0.45, 0.45)
        "water":
            return Color(0.1, 0.35, 0.75)
        "swamp":
            return Color(0.2, 0.38, 0.18)
        _:
            return Color(1, 0, 1)
