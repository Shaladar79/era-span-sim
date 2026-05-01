extends Node2D

signal region_requested(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
)

const GRID_WIDTH: int = 160
const GRID_HEIGHT: int = 120
const TILE_SIZE: int = 16
const REGION_SELECTION_SIZE: int = 6

const TERRAIN_GRASS: String = WorldGenerator.TERRAIN_GRASS
const TERRAIN_FOREST: String = WorldGenerator.TERRAIN_FOREST
const TERRAIN_HILLS: String = WorldGenerator.TERRAIN_HILLS
const TERRAIN_MOUNTAIN: String = WorldGenerator.TERRAIN_MOUNTAIN
const TERRAIN_WATER: String = WorldGenerator.TERRAIN_WATER
const TERRAIN_OCEAN: String = WorldGenerator.TERRAIN_OCEAN
const TERRAIN_SWAMP: String = WorldGenerator.TERRAIN_SWAMP
const TERRAIN_DESERT: String = WorldGenerator.TERRAIN_DESERT
const TERRAIN_TUNDRA: String = WorldGenerator.TERRAIN_TUNDRA

const SUB_BIOME_BASE_MOUNTAIN: String = WorldGenerator.SUB_BIOME_BASE_MOUNTAIN
const SUB_BIOME_SNOWY_PEAK: String = WorldGenerator.SUB_BIOME_SNOWY_PEAK

@export var world_seed: int = 12345
@export var use_random_seed: bool = false
@export var tile_info_label_path: NodePath

var rng := RandomNumberGenerator.new()
var tiles: Array = []
var hovered_tile: Vector2i = Vector2i(-1, -1)
var selected_tile: Vector2i = Vector2i(-1, -1)
var selected_region_origin: Vector2i = Vector2i(-1, -1)
var tile_info_label: Label = null
var show_resource_markers: bool = true

var allow_world_regeneration: bool = false
var region_selection_enabled: bool = false


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
    print_resource_totals()
    queue_redraw()


func activate() -> void:
    set_process(true)
    set_process_unhandled_input(true)


func deactivate() -> void:
    set_process(false)
    set_process_unhandled_input(false)


func get_map_center() -> Vector2:
    return Vector2(
        float(GRID_WIDTH * TILE_SIZE) / 2.0,
        float(GRID_HEIGHT * TILE_SIZE) / 2.0
    )


func _process(_delta: float) -> void:
    update_hovered_tile()


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_R:
            if allow_world_regeneration:
                regenerate_world()

        if event.keycode == KEY_T:
            toggle_resource_markers()

        if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
            if region_selection_enabled:
                request_region_from_selection()

    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if region_selection_enabled:
                select_hovered_region()


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


func start_world_preview() -> void:
    allow_world_regeneration = true
    region_selection_enabled = false
    regenerate_world()


func reroll_preview_world() -> void:
    if not allow_world_regeneration:
        return

    regenerate_world()


func confirm_world_generation() -> void:
    allow_world_regeneration = false
    region_selection_enabled = true
    clear_region_selection()
    update_tile_info_label()
    queue_redraw()

    print("World confirmed. Region selection enabled.")


func enter_region_selection_mode() -> void:
    allow_world_regeneration = false
    region_selection_enabled = true
    clear_region_selection()
    update_tile_info_label()
    queue_redraw()


func enter_world_preview_mode() -> void:
    allow_world_regeneration = true
    region_selection_enabled = false
    clear_region_selection()
    update_tile_info_label()
    queue_redraw()


func clear_region_selection() -> void:
    selected_tile = Vector2i(-1, -1)
    selected_region_origin = Vector2i(-1, -1)


func regenerate_world() -> void:
    rng.randomize()
    world_seed = rng.randi()
    setup_seed()
    generate_world()

    clear_region_selection()
    update_tile_info_label()
    print_resource_totals()
    queue_redraw()

    print("Regenerated world.")


func toggle_resource_markers() -> void:
    show_resource_markers = not show_resource_markers
    queue_redraw()

    print("Show Resource Markers: ", show_resource_markers)


func select_hovered_region() -> void:
    if not region_selection_enabled:
        return

    if not is_tile_in_bounds(hovered_tile):
        selected_tile = Vector2i(-1, -1)
        selected_region_origin = Vector2i(-1, -1)
    else:
        selected_tile = hovered_tile
        selected_region_origin = get_clamped_region_origin(hovered_tile)

    update_tile_info_label()
    queue_redraw()

    print("Selected World Region Origin: ", selected_region_origin)


func get_clamped_region_origin(tile_position: Vector2i) -> Vector2i:
    var max_x := GRID_WIDTH - REGION_SELECTION_SIZE
    var max_y := GRID_HEIGHT - REGION_SELECTION_SIZE

    return Vector2i(
        clampi(tile_position.x, 0, max_x),
        clampi(tile_position.y, 0, max_y)
    )


func is_region_origin_in_bounds(origin: Vector2i) -> bool:
    return (
        origin.x >= 0
        and origin.y >= 0
        and origin.x + REGION_SELECTION_SIZE <= GRID_WIDTH
        and origin.y + REGION_SELECTION_SIZE <= GRID_HEIGHT
    )


func request_region_from_selection() -> void:
    if not region_selection_enabled:
        print("Region selection is not enabled yet. Confirm the world first.")
        return

    if not is_region_origin_in_bounds(selected_region_origin):
        print("No valid 6x6 world region selected.")
        return

    var selected_world_tiles: Array = get_selected_world_tiles()
    var selected_resource_totals: Dictionary = get_resource_totals_from_world_tiles(selected_world_tiles)

    print_world_selection_resource_totals(selected_resource_totals)

    emit_signal(
        "region_requested",
        selected_world_tiles,
        world_seed,
        selected_region_origin,
        selected_resource_totals
    )


func get_selected_world_tiles() -> Array:
    var selected_world_tiles: Array = []

    for local_y in range(REGION_SELECTION_SIZE):
        var row: Array = []

        for local_x in range(REGION_SELECTION_SIZE):
            var world_x := selected_region_origin.x + local_x
            var world_y := selected_region_origin.y + local_y
            var tile_data: Dictionary = tiles[world_y][world_x]

            row.append(tile_data.duplicate(true))

        selected_world_tiles.append(row)

    return selected_world_tiles


func get_resource_totals_from_world_tiles(world_tile_selection: Array) -> Dictionary:
    var resource_totals: Dictionary = {}

    for row_index in range(world_tile_selection.size()):
        var row_variant: Variant = world_tile_selection[row_index]

        if typeof(row_variant) != TYPE_ARRAY:
            continue

        var row: Array = row_variant

        for tile_index in range(row.size()):
            var tile_variant: Variant = row[tile_index]

            if typeof(tile_variant) != TYPE_DICTIONARY:
                continue

            var world_tile: Dictionary = tile_variant
            var resources: Array = world_tile.get("resources", [])

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

    return resource_totals


func print_world_selection_resource_totals(resource_totals: Dictionary) -> void:
    print("")
    print("World Selection 6x6 Resource Totals:")

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


func print_resource_totals() -> void:
    var resource_totals: Dictionary = {}

    for y in range(GRID_HEIGHT):
        for x in range(GRID_WIDTH):
            var tile_data: Dictionary = tiles[y][x]
            var resources: Array = tile_data.get("resources", [])

            for resource_index in range(resources.size()):
                var resource: Variant = resources[resource_index]

                if typeof(resource) != TYPE_DICTIONARY:
                    continue

                var resource_dict: Dictionary = resource
                var resource_name := str(resource_dict.get("name", "Unknown"))
                var amount := int(resource_dict.get("amount", 0))

                if not resource_totals.has(resource_name):
                    resource_totals[resource_name] = 0

                resource_totals[resource_name] += amount

    print("")
    print("Resource Totals:")

    if resource_totals.is_empty():
        print("- None")
        return

    var resource_names: Array = resource_totals.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name: Variant = resource_names[resource_index]
        print(str(resource_name) + ": " + str(resource_totals[resource_name]))

    print("")


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
        tile_info_label.text = (
            "Hover Tile: outside map\n"
            + "Selected Region: " + get_selected_region_text() + "\n"
            + get_world_mode_help_text()
        )
        return

    var tile_data: Dictionary = tiles[hovered_tile.y][hovered_tile.x]

    var elevation_text := str(snapped(float(tile_data.get("elevation", 0.0)), 0.001))
    var moisture_text := str(snapped(float(tile_data.get("moisture", 0.0)), 0.001))
    var resources_text := get_resources_text(tile_data)

    tile_info_label.text = (
        "Hover Tile: " + str(hovered_tile.x) + ", " + str(hovered_tile.y) + "\n"
        + "Selected Region: " + get_selected_region_text() + "\n"
        + get_world_mode_help_text() + "\n"
        + "Terrain: " + str(tile_data.get("terrain", "unknown")) + "\n"
        + "Biome: " + str(tile_data.get("biome", "unknown")) + "\n"
        + "Sub-Biome: " + str(tile_data.get("sub_biome", "none")) + "\n"
        + "Elevation: " + elevation_text + "\n"
        + "Moisture: " + moisture_text + "\n"
        + "Walkable: " + str(tile_data.get("walkable", false)) + "\n"
        + "Buildable: " + str(tile_data.get("buildable", false)) + "\n"
        + "Resources:\n" + resources_text
    )


func get_world_mode_help_text() -> String:
    if allow_world_regeneration and not region_selection_enabled:
        return "World Preview Mode\nR: Reroll World\nUse Confirm World to continue"

    if region_selection_enabled:
        return "Region Selection Mode\nLeft Click: Select 6x6 Region\nEnter: Open Region"

    return "World inactive"


func get_selected_region_text() -> String:
    if not is_region_origin_in_bounds(selected_region_origin):
        return "none"

    return (
        str(selected_region_origin.x)
        + ", "
        + str(selected_region_origin.y)
        + " to "
        + str(selected_region_origin.x + REGION_SELECTION_SIZE - 1)
        + ", "
        + str(selected_region_origin.y + REGION_SELECTION_SIZE - 1)
    )


func get_resources_text(tile_data: Dictionary) -> String:
    var resources: Array = tile_data.get("resources", [])

    if resources.is_empty():
        return "- None"

    var text := ""

    for resource_index in range(resources.size()):
        var resource: Variant = resources[resource_index]

        if typeof(resource) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource
        var resource_name := str(resource_dict.get("name", "Unknown"))
        var amount := int(resource_dict.get("amount", 0))
        var max_amount := int(resource_dict.get("max_amount", amount))

        text += "- " + resource_name + ": " + str(amount) + "/" + str(max_amount) + "\n"

    return text.strip_edges()


func _draw() -> void:
    draw_world_tiles()

    if show_resource_markers:
        draw_resource_markers()

    draw_grid_lines()

    if region_selection_enabled:
        draw_selected_region()

    draw_hovered_tile()


func draw_world_tiles() -> void:
    for y in range(GRID_HEIGHT):
        for x in range(GRID_WIDTH):
            var tile_data: Dictionary = tiles[y][x]
            var tile_color := get_tile_color(tile_data)

            var tile_position := Vector2(x * TILE_SIZE, y * TILE_SIZE)
            var tile_rect := Rect2(tile_position, Vector2(TILE_SIZE, TILE_SIZE))

            draw_rect(tile_rect, tile_color, true)


func draw_resource_markers() -> void:
    for y in range(GRID_HEIGHT):
        for x in range(GRID_WIDTH):
            var tile_data: Dictionary = tiles[y][x]
            var resources: Array = tile_data.get("resources", [])

            if resources.is_empty():
                continue

            draw_tile_resource_markers(x, y, resources)


func draw_tile_resource_markers(tile_x: int, tile_y: int, resources: Array) -> void:
    var marker_radius: float = 2.0
    var marker_spacing: float = 5.0
    var max_markers: int = 4

    var tile_origin := Vector2(tile_x * TILE_SIZE, tile_y * TILE_SIZE)
    var start_position := tile_origin + Vector2(4, 4)

    var marker_count: int = mini(resources.size(), max_markers)

    for i in range(marker_count):
        var resource: Variant = resources[i]

        if typeof(resource) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource
        var resource_id := str(resource_dict.get("id", "unknown"))
        var marker_color := get_resource_marker_color(resource_id)
        var marker_position := start_position + Vector2(i * marker_spacing, 0)

        draw_circle(marker_position, marker_radius, marker_color)


func get_resource_marker_color(resource_id: String) -> Color:
    match resource_id:
        ResourceSpawner.RESOURCE_WOOD:
            return Color(0.45, 0.25, 0.08)
        ResourceSpawner.RESOURCE_BERRIES:
            return Color(0.85, 0.05, 0.08)
        ResourceSpawner.RESOURCE_MUSHROOMS:
            return Color(0.55, 0.20, 0.75)
        ResourceSpawner.RESOURCE_STONE:
            return Color(0.55, 0.55, 0.55)
        ResourceSpawner.RESOURCE_FLINT:
            return Color(0.18, 0.18, 0.18)
        ResourceSpawner.RESOURCE_REEDS:
            return Color(0.70, 0.78, 0.25)
        ResourceSpawner.RESOURCE_CLAY:
            return Color(0.70, 0.32, 0.12)
        ResourceSpawner.RESOURCE_FISH:
            return Color(0.45, 0.80, 1.00)
        ResourceSpawner.RESOURCE_FIBER:
            return Color(0.75, 0.95, 0.55)
        _:
            return Color(1.0, 1.0, 1.0)


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


func draw_selected_region() -> void:
    if not is_region_origin_in_bounds(selected_region_origin):
        return

    var tile_position := Vector2(
        selected_region_origin.x * TILE_SIZE,
        selected_region_origin.y * TILE_SIZE
    )

    var region_size := Vector2(
        REGION_SELECTION_SIZE * TILE_SIZE,
        REGION_SELECTION_SIZE * TILE_SIZE
    )

    var region_rect := Rect2(tile_position, region_size)

    draw_rect(region_rect, Color(1.0, 0.9, 0.1, 1.0), false, 3.0)


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
        TERRAIN_OCEAN:
            return Color(0.02, 0.12, 0.45)
        TERRAIN_SWAMP:
            return Color(0.2, 0.38, 0.18)
        TERRAIN_DESERT:
            return Color(0.78, 0.62, 0.28)
        TERRAIN_TUNDRA:
            return Color(0.62, 0.72, 0.68)
        _:
            return Color(1, 0, 1)
