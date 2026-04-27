extends Node2D

signal return_to_world_requested

const REGION_WIDTH: int = 120
const REGION_HEIGHT: int = 120
const REGION_TILE_SIZE: int = 16

const REGION_TERRAIN_GRASS: String = RegionGenerator.REGION_TERRAIN_GRASS
const REGION_TERRAIN_FOREST: String = RegionGenerator.REGION_TERRAIN_FOREST
const REGION_TERRAIN_DIRT: String = RegionGenerator.REGION_TERRAIN_DIRT
const REGION_TERRAIN_ROCK: String = RegionGenerator.REGION_TERRAIN_ROCK
const REGION_TERRAIN_WATER: String = RegionGenerator.REGION_TERRAIN_WATER
const REGION_TERRAIN_MUD: String = RegionGenerator.REGION_TERRAIN_MUD
const REGION_TERRAIN_SHORE: String = RegionGenerator.REGION_TERRAIN_SHORE

const FEATURE_NONE: String = RegionGenerator.FEATURE_NONE
const FEATURE_TREE: String = RegionGenerator.FEATURE_TREE
const FEATURE_BUSH: String = RegionGenerator.FEATURE_BUSH
const FEATURE_STONE: String = RegionGenerator.FEATURE_STONE
const FEATURE_REEDS: String = RegionGenerator.FEATURE_REEDS

const RESOURCE_WOOD: String = RegionGenerator.RESOURCE_WOOD
const RESOURCE_BERRIES: String = RegionGenerator.RESOURCE_BERRIES
const RESOURCE_MUSHROOMS: String = RegionGenerator.RESOURCE_MUSHROOMS
const RESOURCE_STONE: String = RegionGenerator.RESOURCE_STONE
const RESOURCE_FLINT: String = RegionGenerator.RESOURCE_FLINT
const RESOURCE_REEDS: String = RegionGenerator.RESOURCE_REEDS
const RESOURCE_CLAY: String = RegionGenerator.RESOURCE_CLAY
const RESOURCE_FISH: String = RegionGenerator.RESOURCE_FISH
const RESOURCE_FIBER: String = RegionGenerator.RESOURCE_FIBER

@export var region_seed: int = 12345

var region_tiles: Array = []
var source_world_tiles: Array = []
var source_world_seed: int = 0
var source_selection_origin: Vector2i = Vector2i(-1, -1)
var source_world_resource_totals: Dictionary = {}
var hovered_tile: Vector2i = Vector2i(-1, -1)
var selected_tile: Vector2i = Vector2i(-1, -1)
var show_resource_markers: bool = true


func _ready() -> void:
    generate_region()
    print_region_resource_totals()
    queue_redraw()


func activate() -> void:
    set_process(true)
    set_process_unhandled_input(true)


func deactivate() -> void:
    set_process(false)
    set_process_unhandled_input(false)


func get_map_center() -> Vector2:
    return Vector2(
        float(REGION_WIDTH * REGION_TILE_SIZE) / 2.0,
        float(REGION_HEIGHT * REGION_TILE_SIZE) / 2.0
    )


func _process(_delta: float) -> void:
    update_hovered_tile()


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_LEFT:
            select_hovered_tile()

    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_R:
            regenerate_region()

        if event.keycode == KEY_T:
            toggle_resource_markers()

        if event.keycode == KEY_ESCAPE:
            emit_signal("return_to_world_requested")


func generate_region() -> void:
    region_tiles = RegionGenerator.generate_region(
        REGION_WIDTH,
        REGION_HEIGHT,
        region_seed
    )

    print("Region Seed: ", region_seed)


func generate_from_world_selection(
    selected_world_tiles: Array,
    selected_world_seed: int,
    selection_origin: Vector2i,
    selected_source_resource_totals: Dictionary
) -> void:
    source_world_tiles = selected_world_tiles
    source_world_seed = selected_world_seed
    source_selection_origin = selection_origin
    source_world_resource_totals = selected_source_resource_totals.duplicate(true)

    region_seed = get_region_seed_from_world_selection(
        selected_world_seed,
        selection_origin
    )

    region_tiles = RegionGenerator.generate_region_from_world_selection(
        REGION_WIDTH,
        REGION_HEIGHT,
        region_seed,
        source_world_tiles
    )

    hovered_tile = Vector2i(-1, -1)
    selected_tile = Vector2i(-1, -1)

    print("Region Seed: ", region_seed)
    print("Source World Region Origin: ", source_selection_origin)
    print_source_world_selection_resource_totals()
    print_region_resource_totals()

    queue_redraw()


func get_region_seed_from_world_selection(
    selected_world_seed: int,
    selection_origin: Vector2i
) -> int:
    return (
        selected_world_seed
        + selection_origin.x * 73856093
        + selection_origin.y * 19349663
    )


func regenerate_region() -> void:
    if not source_world_tiles.is_empty():
        region_tiles = RegionGenerator.generate_region_from_world_selection(
            REGION_WIDTH,
            REGION_HEIGHT,
            region_seed,
            source_world_tiles
        )

        print_source_world_selection_resource_totals()
    else:
        generate_region()

    if not is_tile_in_bounds(selected_tile):
        selected_tile = Vector2i(-1, -1)

    print_region_resource_totals()
    queue_redraw()

    print("Regenerated region.")


func toggle_resource_markers() -> void:
    show_resource_markers = not show_resource_markers
    queue_redraw()

    print("Show Region Resource Markers: ", show_resource_markers)


func print_source_world_selection_resource_totals() -> void:
    print("")
    print("Source World 6x6 Resource Totals:")

    if source_world_resource_totals.is_empty():
        print("- None")
        return

    var resource_names: Array = source_world_resource_totals.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        print(resource_name + ": " + str(source_world_resource_totals[resource_name]))

    print("")


func print_region_resource_totals() -> void:
    var resource_totals: Dictionary = {}

    for y in range(REGION_HEIGHT):
        for x in range(REGION_WIDTH):
            var tile_data: Dictionary = region_tiles[y][x]
            var resources: Array = tile_data.get("resources", [])

            for resource_index in range(resources.size()):
                var resource: Variant = resources[resource_index]

                if typeof(resource) != TYPE_DICTIONARY:
                    continue

                var resource_dict: Dictionary = resource
                var resource_name: String = str(resource_dict.get("name", "Unknown"))
                var amount: int = int(resource_dict.get("amount", 0))

                if not resource_totals.has(resource_name):
                    resource_totals[resource_name] = 0

                resource_totals[resource_name] += amount

    print("")
    print("Generated Regional Resource Totals:")

    if resource_totals.is_empty():
        print("- None")
        return

    var resource_names: Array = resource_totals.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        print(resource_name + ": " + str(resource_totals[resource_name]))

    print("")


func update_hovered_tile() -> void:
    var mouse_world_position := get_global_mouse_position()
    var tile_x := int(floor(mouse_world_position.x / REGION_TILE_SIZE))
    var tile_y := int(floor(mouse_world_position.y / REGION_TILE_SIZE))

    var new_hovered_tile := Vector2i(tile_x, tile_y)

    if new_hovered_tile != hovered_tile:
        hovered_tile = new_hovered_tile
        queue_redraw()


func select_hovered_tile() -> void:
    if not is_tile_in_bounds(hovered_tile):
        selected_tile = Vector2i(-1, -1)
    else:
        selected_tile = hovered_tile

    queue_redraw()

    print("Selected Region Tile: ", selected_tile)

    if is_tile_in_bounds(selected_tile):
        print_selected_tile_resources()


func print_selected_tile_resources() -> void:
    var tile_data: Dictionary = region_tiles[selected_tile.y][selected_tile.x]
    var resources: Array = tile_data.get("resources", [])

    print("Selected Region Tile Resources:")

    if resources.is_empty():
        print("- None")
        return

    for resource_index in range(resources.size()):
        var resource: Variant = resources[resource_index]

        if typeof(resource) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource
        var resource_name: String = str(resource_dict.get("name", "Unknown"))
        var amount: int = int(resource_dict.get("amount", 0))
        var max_amount: int = int(resource_dict.get("max_amount", amount))

        print("- " + resource_name + ": " + str(amount) + "/" + str(max_amount))


func _draw() -> void:
    draw_region_tiles()
    draw_region_features()

    if show_resource_markers:
        draw_region_resource_markers()

    draw_grid_lines()
    draw_selected_tile()
    draw_hovered_tile()


func draw_region_tiles() -> void:
    for y in range(REGION_HEIGHT):
        for x in range(REGION_WIDTH):
            var tile_data: Dictionary = region_tiles[y][x]
            var tile_color: Color = get_region_tile_color(tile_data)

            var tile_position := Vector2(x * REGION_TILE_SIZE, y * REGION_TILE_SIZE)
            var tile_rect := Rect2(tile_position, Vector2(REGION_TILE_SIZE, REGION_TILE_SIZE))

            draw_rect(tile_rect, tile_color, true)


func draw_region_features() -> void:
    for y in range(REGION_HEIGHT):
        for x in range(REGION_WIDTH):
            var tile_data: Dictionary = region_tiles[y][x]
            var feature: String = str(tile_data.get("feature", FEATURE_NONE))

            if feature == FEATURE_NONE:
                continue

            draw_region_feature(x, y, feature)


func draw_region_feature(tile_x: int, tile_y: int, feature: String) -> void:
    var tile_origin := Vector2(tile_x * REGION_TILE_SIZE, tile_y * REGION_TILE_SIZE)
    var center := tile_origin + Vector2(REGION_TILE_SIZE / 2.0, REGION_TILE_SIZE / 2.0)

    match feature:
        FEATURE_TREE:
            draw_circle(center, 5.0, Color(0.02, 0.22, 0.06))
        FEATURE_BUSH:
            draw_circle(center, 3.5, Color(0.10, 0.45, 0.10))
        FEATURE_STONE:
            draw_circle(center, 4.0, Color(0.55, 0.55, 0.55))
        FEATURE_REEDS:
            draw_circle(center, 3.5, Color(0.62, 0.72, 0.20))
        _:
            pass


func draw_region_resource_markers() -> void:
    for y in range(REGION_HEIGHT):
        for x in range(REGION_WIDTH):
            var tile_data: Dictionary = region_tiles[y][x]
            var resources: Array = tile_data.get("resources", [])

            if resources.is_empty():
                continue

            draw_tile_resource_markers(x, y, resources)


func draw_tile_resource_markers(tile_x: int, tile_y: int, resources: Array) -> void:
    var marker_size: float = 3.0
    var marker_spacing: float = 5.0
    var max_markers: int = 4

    var tile_origin := Vector2(tile_x * REGION_TILE_SIZE, tile_y * REGION_TILE_SIZE)
    var start_position := tile_origin + Vector2(4, REGION_TILE_SIZE - 5)

    var marker_count: int = mini(resources.size(), max_markers)

    for i in range(marker_count):
        var resource: Variant = resources[i]

        if typeof(resource) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource
        var resource_id: String = str(resource_dict.get("id", "unknown"))
        var marker_color: Color = get_resource_marker_color(resource_id)
        var marker_position := start_position + Vector2(i * marker_spacing, 0)

        draw_plus_marker(marker_position, marker_size, marker_color)


func draw_plus_marker(position: Vector2, size: float, color: Color) -> void:
    draw_line(
        Vector2(position.x - size, position.y),
        Vector2(position.x + size, position.y),
        color,
        1.5
    )

    draw_line(
        Vector2(position.x, position.y - size),
        Vector2(position.x, position.y + size),
        color,
        1.5
    )


func get_resource_marker_color(resource_id: String) -> Color:
    match resource_id:
        RESOURCE_WOOD:
            return Color(0.45, 0.25, 0.08)
        RESOURCE_BERRIES:
            return Color(0.90, 0.05, 0.08)
        RESOURCE_MUSHROOMS:
            return Color(0.55, 0.20, 0.75)
        RESOURCE_STONE:
            return Color(0.70, 0.70, 0.70)
        RESOURCE_FLINT:
            return Color(0.12, 0.12, 0.12)
        RESOURCE_REEDS:
            return Color(0.72, 0.82, 0.24)
        RESOURCE_CLAY:
            return Color(0.78, 0.34, 0.12)
        RESOURCE_FISH:
            return Color(0.45, 0.85, 1.00)
        RESOURCE_FIBER:
            return Color(0.78, 1.00, 0.55)
        _:
            return Color(1.0, 1.0, 1.0)


func draw_grid_lines() -> void:
    var grid_color := Color(0, 0, 0, 0.25)

    for x in range(REGION_WIDTH + 1):
        var start_pos := Vector2(x * REGION_TILE_SIZE, 0)
        var end_pos := Vector2(x * REGION_TILE_SIZE, REGION_HEIGHT * REGION_TILE_SIZE)
        draw_line(start_pos, end_pos, grid_color, 1.0)

    for y in range(REGION_HEIGHT + 1):
        var start_pos := Vector2(0, y * REGION_TILE_SIZE)
        var end_pos := Vector2(REGION_WIDTH * REGION_TILE_SIZE, y * REGION_TILE_SIZE)
        draw_line(start_pos, end_pos, grid_color, 1.0)


func draw_selected_tile() -> void:
    if not is_tile_in_bounds(selected_tile):
        return

    var tile_position := Vector2(selected_tile.x * REGION_TILE_SIZE, selected_tile.y * REGION_TILE_SIZE)
    var tile_rect := Rect2(tile_position, Vector2(REGION_TILE_SIZE, REGION_TILE_SIZE))

    draw_rect(tile_rect, Color(1.0, 0.9, 0.1, 1.0), false, 2.0)


func draw_hovered_tile() -> void:
    if not is_tile_in_bounds(hovered_tile):
        return

    var tile_position := Vector2(hovered_tile.x * REGION_TILE_SIZE, hovered_tile.y * REGION_TILE_SIZE)
    var tile_rect := Rect2(tile_position, Vector2(REGION_TILE_SIZE, REGION_TILE_SIZE))

    draw_rect(tile_rect, Color(1, 1, 1, 0.22), true)
    draw_rect(tile_rect, Color(1, 1, 1, 0.9), false, 2.0)


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < REGION_WIDTH
        and tile_position.y < REGION_HEIGHT
    )


func get_region_tile_color(tile_data: Dictionary) -> Color:
    match tile_data.get("terrain", REGION_TERRAIN_GRASS):
        REGION_TERRAIN_GRASS:
            return Color(0.30, 0.62, 0.24)
        REGION_TERRAIN_FOREST:
            return Color(0.08, 0.34, 0.10)
        REGION_TERRAIN_DIRT:
            return Color(0.42, 0.30, 0.16)
        REGION_TERRAIN_ROCK:
            return Color(0.42, 0.42, 0.42)
        REGION_TERRAIN_WATER:
            return Color(0.13, 0.38, 0.72)
        REGION_TERRAIN_MUD:
            return Color(0.20, 0.24, 0.12)
        REGION_TERRAIN_SHORE:
            return Color(0.80, 0.74, 0.50)
        _:
            return Color(1, 0, 1)
