extends Node2D

signal return_to_world_requested

const REGION_WIDTH: int = 120
const REGION_HEIGHT: int = 120
const REGION_TILE_SIZE: int = 16

const REGION_TERRAIN_GRASS: String = RegionGenerator.REGION_TERRAIN_GRASS
const REGION_TERRAIN_WATER: String = RegionGenerator.REGION_TERRAIN_WATER

const FEATURE_NONE: String = RegionGenerator.FEATURE_NONE

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

var inventory := RegionInventory.new()
var building_manager := RegionBuildingManager.new()
var villager_manager := VillagerManager.new()
var renderer := RegionRenderer.new()
var input_controller := RegionInputController.new()

var is_dragging_villager: bool = false
var dragged_villager_id: int = 0
var drag_assignment_tile: Vector2i = Vector2i(-1, -1)
var simulation_paused: bool = false


func _ready() -> void:
    input_controller.setup(self)

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
    input_controller.handle_unhandled_input(event)


func generate_region() -> void:
    region_tiles = RegionGenerator.generate_region(
        REGION_WIDTH,
        REGION_HEIGHT,
        region_seed
    )

    RegionBuildingData.reset_runtime_unlocks()
    setup_building_manager()
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

    RegionBuildingData.reset_runtime_unlocks()
    setup_building_manager()
    clear_buildings()

    hovered_tile = Vector2i(-1, -1)
    selected_tile = Vector2i(-1, -1)
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

    RegionBuildingData.reset_runtime_unlocks()
    setup_building_manager()
    clear_buildings()

    if not is_tile_in_bounds(selected_tile):
        selected_tile = Vector2i(-1, -1)

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
    inventory.reset()


func setup_building_manager() -> void:
    building_manager.setup(
        region_tiles,
        REGION_WIDTH,
        REGION_HEIGHT
    )

    building_manager.cancel_build_mode()


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
        inventory.add_resources(harvested_resources)
        print_settlement_inventory()

    if villager_manager.has_tile_changes():
        queue_redraw()


func clear_buildings() -> void:
    building_manager.clear_buildings()


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

    queue_redraw()


func start_campfire_placement() -> void:
    start_building_placement(BUILDING_CAMPFIRE)


func start_building_placement(building_id: String) -> void:
    building_manager.start_building_placement(building_id)
    queue_redraw()


func cancel_build_mode() -> void:
    building_manager.cancel_build_mode()
    queue_redraw()


func try_place_current_building(origin_tile: Vector2i) -> void:
    var did_place_building: bool = building_manager.try_place_current_building(
        origin_tile,
        inventory
    )

    if did_place_building:
        print_settlement_inventory()

    queue_redraw()


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
    inventory.print_inventory(villager_manager.get_population_count())


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
    renderer.draw_all(
        self,
        region_tiles,
        REGION_WIDTH,
        REGION_HEIGHT,
        REGION_TILE_SIZE,
        show_resource_markers,
        building_manager,
        villager_manager,
        hovered_tile,
        selected_tile,
        is_dragging_villager,
        drag_assignment_tile,
        HARVEST_ASSIGN_RADIUS,
        simulation_paused
    )


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < REGION_WIDTH
        and tile_position.y < REGION_HEIGHT
    )
