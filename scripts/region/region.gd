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

const BUILD_MODE_NONE: String = "none"
const BUILDING_CAMPFIRE: String = RegionBuildingData.BUILDING_CAMPFIRE

const HARVEST_ASSIGN_RADIUS: int = 8
const VILLAGER_DRAG_HIT_RADIUS: float = 8.0

@export var region_seed: int = 12345

var region_tiles: Array = []
var source_world_tiles: Array = []
var source_world_seed: int = 0
var source_selection_origin: Vector2i = Vector2i(-1, -1)
var source_world_resource_totals: Dictionary = {}

var hovered_tile: Vector2i = Vector2i(-1, -1)
var selected_tile: Vector2i = Vector2i(-1, -1)

var show_resource_markers: bool = true
var current_build_mode: String = BUILD_MODE_NONE
var current_building_id: String = ""

var region_buildings: Array = []

var villager_manager := VillagerManager.new()

var is_dragging_villager: bool = false
var dragged_villager_id: int = 0
var drag_assignment_tile: Vector2i = Vector2i(-1, -1)
var simulation_paused: bool = false

var settlement_inventory: Dictionary = {
    "Wood": 0,
    "Stone": 0,
    "Fiber": 0,
    "Flint": 0
}


func _ready() -> void:
    generate_region()
    print_region_resource_totals()
    print_settlement_inventory()
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


func _process(delta: float) -> void:
    update_hovered_tile()

    if simulation_paused:
        return

    update_villager_manager(delta)


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                if current_build_mode != BUILD_MODE_NONE:
                    try_place_current_building(hovered_tile)
                else:
                    try_start_villager_drag_or_select()
            else:
                if is_dragging_villager:
                    finish_villager_drag_assignment()

    if event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_SPACE:
            toggle_simulation_pause()
            return

        if event.keycode == KEY_R:
            regenerate_region()

        if event.keycode == KEY_T:
            toggle_resource_markers()

        if event.keycode == KEY_C:
            start_campfire_placement()

        if event.keycode == KEY_ESCAPE:
            if current_build_mode != BUILD_MODE_NONE:
                cancel_build_mode()
            elif is_dragging_villager:
                cancel_villager_drag()
            else:
                emit_signal("return_to_world_requested")


func generate_region() -> void:
    region_tiles = RegionGenerator.generate_region(
        REGION_WIDTH,
        REGION_HEIGHT,
        region_seed
    )

    clear_buildings()
    reset_test_inventory()
    setup_villager_manager()

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

    clear_buildings()

    hovered_tile = Vector2i(-1, -1)
    selected_tile = Vector2i(-1, -1)
    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""
    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)
    simulation_paused = false

    reset_test_inventory()
    setup_villager_manager()

    print("Region Seed: ", region_seed)
    print("Source World Region Origin: ", source_selection_origin)
    print_source_world_selection_resource_totals()
    print_region_resource_totals()
    print_settlement_inventory()

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
        region_tiles = RegionGenerator.generate_region(
            REGION_WIDTH,
            REGION_HEIGHT,
            region_seed
        )

    clear_buildings()

    if not is_tile_in_bounds(selected_tile):
        selected_tile = Vector2i(-1, -1)

    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""
    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)
    simulation_paused = false

    reset_test_inventory()
    setup_villager_manager()

    print_region_resource_totals()
    print_settlement_inventory()
    queue_redraw()

    print("Regenerated region.")


func reset_test_inventory() -> void:
    settlement_inventory = {
        "Wood": 0,
        "Stone": 0,
        "Fiber": 0,
        "Flint": 0
    }


func setup_villager_manager() -> void:
    villager_manager.setup(
        region_tiles,
        REGION_WIDTH,
        REGION_HEIGHT,
        REGION_TILE_SIZE,
        REGION_TERRAIN_GRASS,
        REGION_TERRAIN_WATER,
        FEATURE_NONE
    )

    villager_manager.reset_and_spawn_starting_villagers()


func update_villager_manager(delta: float) -> void:
    var harvested_resources: Dictionary = villager_manager.update(delta)

    if not harvested_resources.is_empty():
        add_harvested_resources_to_inventory(harvested_resources)
        print_settlement_inventory()

    if villager_manager.has_tile_changes():
        queue_redraw()


func add_harvested_resources_to_inventory(harvested_resources: Dictionary) -> void:
    var resource_names: Array = harvested_resources.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var harvested_amount: int = int(harvested_resources.get(resource_name, 0))
        var current_amount: int = int(settlement_inventory.get(resource_name, 0))

        settlement_inventory[resource_name] = current_amount + harvested_amount


func clear_buildings() -> void:
    region_buildings.clear()

    if region_tiles.is_empty():
        return

    for y in range(REGION_HEIGHT):
        for x in range(REGION_WIDTH):
            var tile_data: Dictionary = region_tiles[y][x]
            tile_data["occupied"] = false
            tile_data.erase("building_id")


func toggle_resource_markers() -> void:
    show_resource_markers = not show_resource_markers
    queue_redraw()

    print("Show Region Resource Markers: ", show_resource_markers)


func toggle_simulation_pause() -> void:
    simulation_paused = not simulation_paused

    if simulation_paused:
        print("Simulation Paused. You can drag villagers to assign harvest areas.")
    else:
        print("Simulation Resumed.")


func start_campfire_placement() -> void:
    start_building_placement(BUILDING_CAMPFIRE)


func start_building_placement(building_id: String) -> void:
    var building_data: Dictionary = RegionBuildingData.get_building(building_id)

    if building_data.is_empty():
        push_warning("Unknown building id: " + building_id)
        return

    if not bool(building_data.get("unlocked", false)):
        print("Building is locked: ", str(building_data.get("name", building_id)))
        return

    current_build_mode = building_id
    current_building_id = building_id

    queue_redraw()

    print(str(building_data.get("name", building_id)) + " placement mode: ON")
    print("Cost: " + get_cost_text_from_dictionary(building_data.get("cost", {})))


func cancel_build_mode() -> void:
    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""
    queue_redraw()

    print("Build mode cancelled.")


func try_place_current_building(origin_tile: Vector2i) -> void:
    if current_building_id == "":
        print("No building selected.")
        return

    var building_data: Dictionary = RegionBuildingData.get_building(current_building_id)

    if building_data.is_empty():
        push_warning("Cannot place unknown building: " + current_building_id)
        cancel_build_mode()
        return

    if not is_tile_in_bounds(origin_tile):
        print("Cannot place building outside the map.")
        return

    var footprint_width: int = int(building_data.get("width", 1))
    var footprint_height: int = int(building_data.get("height", 1))
    var building_name: String = str(building_data.get("name", current_building_id))
    var cost_variant: Variant = building_data.get("cost", {})
    var cost: Dictionary = {}

    if typeof(cost_variant) == TYPE_DICTIONARY:
        cost = cost_variant

    if not can_place_building(origin_tile, footprint_width, footprint_height):
        print("Cannot place " + building_name + " here.")
        print_building_placement_failure_reason(
            origin_tile,
            footprint_width,
            footprint_height
        )
        return

    if not has_building_cost(cost):
        print("Not enough resources to build " + building_name + ".")
        print("Need: " + get_cost_text_from_dictionary(cost))
        print_settlement_inventory()
        return

    spend_building_cost(cost)

    place_building(
        current_building_id,
        building_name,
        origin_tile,
        footprint_width,
        footprint_height
    )

    print(building_name + " built at: ", origin_tile)
    print_settlement_inventory()

    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    queue_redraw()


func can_place_building(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> bool:
    if origin_tile.x < 0 or origin_tile.y < 0:
        return false

    if origin_tile.x + footprint_width > REGION_WIDTH:
        return false

    if origin_tile.y + footprint_height > REGION_HEIGHT:
        return false

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

            if not bool(tile_data.get("buildable", false)):
                return false

            if bool(tile_data.get("occupied", false)):
                return false

    return true


func print_building_placement_failure_reason(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> void:
    print("")
    print("Placement Debug:")
    print("Origin: ", origin_tile)
    print("Footprint: ", footprint_width, "x", footprint_height)

    if origin_tile.x < 0 or origin_tile.y < 0:
        print("- Origin is outside the map.")
        return

    if origin_tile.x + footprint_width > REGION_WIDTH:
        print("- Footprint extends past right edge of map.")
        return

    if origin_tile.y + footprint_height > REGION_HEIGHT:
        print("- Footprint extends past bottom edge of map.")
        return

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            if not is_tile_in_bounds(tile_position):
                print("- Tile outside map: ", tile_position)
                continue

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

            var terrain: String = str(tile_data.get("terrain", "unknown"))
            var feature: String = str(tile_data.get("feature", "unknown"))
            var buildable: bool = bool(tile_data.get("buildable", false))
            var walkable: bool = bool(tile_data.get("walkable", false))
            var occupied: bool = bool(tile_data.get("occupied", false))
            var resources: Array = tile_data.get("resources", [])

            if not buildable or occupied:
                print(
                    "- Blocking tile ",
                    tile_position,
                    " terrain=",
                    terrain,
                    " feature=",
                    feature,
                    " buildable=",
                    buildable,
                    " walkable=",
                    walkable,
                    " occupied=",
                    occupied,
                    " resources=",
                    resources.size()
                )

    print("")


func has_building_cost(cost: Dictionary) -> bool:
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var required_amount: int = int(cost.get(resource_name, 0))
        var current_amount: int = int(settlement_inventory.get(resource_name, 0))

        if current_amount < required_amount:
            return false

    return true


func spend_building_cost(cost: Dictionary) -> void:
    var resource_names: Array = cost.keys()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var required_amount: int = int(cost.get(resource_name, 0))
        var current_amount: int = int(settlement_inventory.get(resource_name, 0))

        settlement_inventory[resource_name] = current_amount - required_amount


func get_cost_text_from_dictionary(cost_variant: Variant) -> String:
    if typeof(cost_variant) != TYPE_DICTIONARY:
        return "Free"

    var cost: Dictionary = cost_variant

    if cost.is_empty():
        return "Free"

    var parts: Array = []
    var resource_names: Array = cost.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var amount: int = int(cost.get(resource_name, 0))

        parts.append(resource_name + " " + str(amount))

    return ", ".join(parts)


func place_building(
    building_id: String,
    display_name: String,
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> void:
    var building_data := {
        "id": building_id,
        "name": display_name,
        "x": origin_tile.x,
        "y": origin_tile.y,
        "width": footprint_width,
        "height": footprint_height,
        "active": true
    }

    region_buildings.append(building_data)

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
            tile_data["occupied"] = true
            tile_data["building_id"] = building_id


func try_start_villager_drag_or_select() -> void:
    var mouse_world_position := get_global_mouse_position()
    var villager_id: int = villager_manager.get_villager_at_world_position(
        mouse_world_position,
        VILLAGER_DRAG_HIT_RADIUS
    )

    if villager_id > 0:
        is_dragging_villager = true
        dragged_villager_id = villager_id
        drag_assignment_tile = hovered_tile

        print("Started dragging villager id: ", dragged_villager_id)

        queue_redraw()
        return

    select_hovered_tile()


func finish_villager_drag_assignment() -> void:
    if dragged_villager_id <= 0:
        cancel_villager_drag()
        return

    if not is_tile_in_bounds(hovered_tile):
        cancel_villager_drag()
        return

    drag_assignment_tile = hovered_tile

    villager_manager.assign_harvest_area(
        dragged_villager_id,
        drag_assignment_tile,
        HARVEST_ASSIGN_RADIUS
    )

    cancel_villager_drag()
    queue_redraw()


func cancel_villager_drag() -> void:
    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)


func print_settlement_inventory() -> void:
    print("")
    print("Settlement Inventory:")

    var resource_names: Array = settlement_inventory.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        print(resource_name + ": " + str(int(settlement_inventory.get(resource_name, 0))))

    print("Population: " + str(villager_manager.get_population_count()))
    print("")


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

        if is_dragging_villager:
            drag_assignment_tile = hovered_tile

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

    print("Selected Region Tile Data:")
    print("- Terrain: ", str(tile_data.get("terrain", "unknown")))
    print("- Feature: ", str(tile_data.get("feature", "unknown")))
    print("- Walkable: ", bool(tile_data.get("walkable", false)))
    print("- Buildable: ", bool(tile_data.get("buildable", false)))
    print("- Occupied: ", bool(tile_data.get("occupied", false)))

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

    draw_buildings()
    draw_villagers()
    draw_villager_assignment_markers()
    draw_villager_drag_preview()
    draw_grid_lines()
    draw_building_preview()
    draw_selected_tile()
    draw_hovered_tile()
    draw_pause_overlay()


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


func draw_buildings() -> void:
    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", "unknown"))

        match building_id:
            BUILDING_CAMPFIRE:
                draw_campfire_building(building_data)
            _:
                draw_generic_building(building_data)


func draw_campfire_building(building_data: Dictionary) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 2))
    var height: int = int(building_data.get("height", 2))

    var building_position := Vector2(tile_x * REGION_TILE_SIZE, tile_y * REGION_TILE_SIZE)
    var building_size := Vector2(width * REGION_TILE_SIZE, height * REGION_TILE_SIZE)
    var building_rect := Rect2(building_position, building_size)

    draw_rect(building_rect, Color(0.50, 0.22, 0.08, 0.95), true)
    draw_rect(building_rect, Color(1.0, 0.55, 0.12, 1.0), false, 2.0)

    var center := building_position + building_size / 2.0
    draw_circle(center, 6.0, Color(1.0, 0.42, 0.05, 1.0))
    draw_circle(center, 3.0, Color(1.0, 0.9, 0.2, 1.0))


func draw_generic_building(building_data: Dictionary) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 1))
    var height: int = int(building_data.get("height", 1))

    var building_position := Vector2(tile_x * REGION_TILE_SIZE, tile_y * REGION_TILE_SIZE)
    var building_size := Vector2(width * REGION_TILE_SIZE, height * REGION_TILE_SIZE)
    var building_rect := Rect2(building_position, building_size)

    draw_rect(building_rect, Color(0.35, 0.22, 0.12, 0.90), true)
    draw_rect(building_rect, Color(0.85, 0.70, 0.45, 1.0), false, 2.0)


func draw_villagers() -> void:
    var manager_villagers: Array = villager_manager.get_villagers()

    for villager_index in range(manager_villagers.size()):
        var villager_variant: Variant = manager_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        draw_villager(villager_data)


func draw_villager(villager_data: Dictionary) -> void:
    var center: Vector2 = villager_data.get("world_position", Vector2.ZERO)
    var state: String = str(villager_data.get("state", VillagerManager.VILLAGER_STATE_IDLE))

    var body_color := Color(0.85, 0.82, 0.72, 1.0)

    match state:
        VillagerManager.VILLAGER_STATE_MOVING:
            body_color = Color(0.75, 0.88, 0.95, 1.0)
        VillagerManager.VILLAGER_STATE_HARVESTING:
            body_color = Color(0.95, 0.82, 0.45, 1.0)
        _:
            body_color = Color(0.85, 0.82, 0.72, 1.0)

    var outline_color := Color(0.15, 0.10, 0.08, 1.0)

    draw_circle(center + Vector2(0, 3), 4.2, body_color)
    draw_circle(center + Vector2(0, -3), 2.7, body_color)
    draw_line(
        center + Vector2(-4, 7),
        center + Vector2(4, 7),
        outline_color,
        2.0
    )
    draw_circle(center + Vector2(0, 3), 4.2, outline_color, false, 1.0)
    draw_circle(center + Vector2(0, -3), 2.7, outline_color, false, 1.0)


func draw_villager_assignment_markers() -> void:
    var manager_villagers: Array = villager_manager.get_villagers()

    for villager_index in range(manager_villagers.size()):
        var villager_variant: Variant = manager_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var assigned_center: Vector2i = villager_data.get(
            "assigned_harvest_center",
            VillagerManager.NO_ASSIGNED_AREA
        )

        var assigned_radius: int = int(villager_data.get("assigned_harvest_radius", 0))

        if not is_tile_in_bounds(assigned_center):
            continue

        if assigned_radius <= 0:
            continue

        draw_harvest_area_marker(
            assigned_center,
            assigned_radius,
            Color(0.95, 0.85, 0.25, 0.18),
            Color(0.95, 0.85, 0.25, 0.85)
        )


func draw_villager_drag_preview() -> void:
    if not is_dragging_villager:
        return

    if not is_tile_in_bounds(drag_assignment_tile):
        return

    draw_harvest_area_marker(
        drag_assignment_tile,
        HARVEST_ASSIGN_RADIUS,
        Color(0.25, 0.75, 1.0, 0.18),
        Color(0.25, 0.75, 1.0, 0.9)
    )


func draw_harvest_area_marker(
    center_tile: Vector2i,
    radius: int,
    fill_color: Color,
    outline_color: Color
) -> void:
    var center_world := Vector2(
        center_tile.x * REGION_TILE_SIZE + REGION_TILE_SIZE / 2.0,
        center_tile.y * REGION_TILE_SIZE + REGION_TILE_SIZE / 2.0
    )

    var radius_pixels: float = float(radius * REGION_TILE_SIZE)

    draw_circle(center_world, radius_pixels, fill_color)
    draw_circle(center_world, radius_pixels, outline_color, false, 2.0)


func draw_building_preview() -> void:
    if current_build_mode == BUILD_MODE_NONE or current_building_id == "":
        return

    if not is_tile_in_bounds(hovered_tile):
        return

    var building_data: Dictionary = RegionBuildingData.get_building(current_building_id)

    if building_data.is_empty():
        return

    var footprint_width: int = int(building_data.get("width", 1))
    var footprint_height: int = int(building_data.get("height", 1))

    var can_place := can_place_building(
        hovered_tile,
        footprint_width,
        footprint_height
    )

    var preview_position := Vector2(
        hovered_tile.x * REGION_TILE_SIZE,
        hovered_tile.y * REGION_TILE_SIZE
    )

    var preview_size := Vector2(
        footprint_width * REGION_TILE_SIZE,
        footprint_height * REGION_TILE_SIZE
    )

    var preview_rect := Rect2(preview_position, preview_size)

    if can_place:
        draw_rect(preview_rect, Color(0.1, 0.9, 0.1, 0.28), true)
        draw_rect(preview_rect, Color(0.1, 1.0, 0.1, 0.95), false, 2.0)
    else:
        draw_rect(preview_rect, Color(0.9, 0.1, 0.1, 0.28), true)
        draw_rect(preview_rect, Color(1.0, 0.1, 0.1, 0.95), false, 2.0)


func draw_pause_overlay() -> void:
    if not simulation_paused:
        return

    var viewport_size := get_viewport_rect().size
    var label_position := Vector2(16, 16)

    draw_rect(
        Rect2(label_position - Vector2(6, 4), Vector2(190, 26)),
        Color(0.0, 0.0, 0.0, 0.55),
        true
    )

    draw_string(
        ThemeDB.fallback_font,
        label_position + Vector2(0, 16),
        "PAUSED - assign orders",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        16,
        Color(1.0, 1.0, 1.0, 1.0)
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
