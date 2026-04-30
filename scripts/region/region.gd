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

const STORAGE_SELECTOR_BUTTON_WIDTH: int = 96
const STORAGE_SELECTOR_BUTTON_HEIGHT: int = 22
const STORAGE_SELECTOR_BUTTON_GAP: int = 2

const TOP_INFO_PANEL_WIDTH: int = 240
const TOP_INFO_PANEL_HEIGHT: int = 112
const TOP_INFO_PANEL_MARGIN: int = 12

const TOP_INFO_RESOURCE_BUTTON_WIDTH: int = 92
const TOP_INFO_RESOURCE_BUTTON_HEIGHT: int = 22

const TOP_INFO_RESEARCH_BUTTON_WIDTH: int = 92
const TOP_INFO_RESEARCH_BUTTON_HEIGHT: int = 22

const RESOURCE_LIST_PANEL_WIDTH: int = 240
const RESOURCE_LIST_ROW_HEIGHT: int = 20
const RESOURCE_LIST_PANEL_GAP: int = 4

const RESEARCH_PANEL_WIDTH: int = 360
const RESEARCH_PANEL_HEIGHT: int = 260
const RESEARCH_PANEL_GAP: int = 4
const RESEARCH_ROW_HEIGHT: int = 30

const CRAFTING_PANEL_WIDTH: int = 360
const CRAFTING_PANEL_HEIGHT: int = 260
const CRAFTING_PANEL_GAP: int = 4
const CRAFTING_ROW_HEIGHT: int = 42

const VILLAGER_HOVER_PANEL_WIDTH: int = 250
const VILLAGER_HOVER_PANEL_HEIGHT: int = 225
const VILLAGER_HOVER_PANEL_OFFSET: Vector2 = Vector2(18, 18)

const VILLAGE_LOG_BUTTON_WIDTH: int = 110
const VILLAGE_LOG_BUTTON_HEIGHT: int = 26
const VILLAGE_LOG_PANEL_WIDTH: int = 360
const VILLAGE_LOG_PANEL_HEIGHT: int = 220
const VILLAGE_LOG_MARGIN: int = 12
const VILLAGE_LOG_BOTTOM_OFFSET: int = 52
const VILLAGE_LOG_ROW_HEIGHT: int = 18
const VILLAGE_LOG_MAX_MESSAGES: int = 50

@export var region_seed: int = 12345

var region_tiles: Array = []
var source_world_tiles: Array = []
var source_world_seed: int = 0
var source_selection_origin: Vector2i = Vector2i(-1, -1)
var source_world_resource_totals: Dictionary = {}

var hovered_tile: Vector2i = Vector2i(-1, -1)
var selected_tile: Vector2i = Vector2i(-1, -1)

var show_resource_markers: bool = true
var show_campfire_radius: bool = false

var inventory := RegionInventory.new()
var item_inventory := RegionItemInventory.new()
var research := RegionResearch.new()
var crafting := RegionCrafting.new()

var building_manager := RegionBuildingManager.new()
var villager_manager := VillagerManager.new()
var renderer := RegionRenderer.new()
var input_controller := RegionInputController.new()

var is_dragging_villager: bool = false
var dragged_villager_id: int = 0
var drag_assignment_tile: Vector2i = Vector2i(-1, -1)
var simulation_paused: bool = true

var storage_selector_open: bool = false
var selected_storage_building_instance_id: int = 0
var storage_selector_anchor_tile: Vector2i = Vector2i(-1, -1)
var storage_selector_options: Array = []

var show_resource_inventory_panel: bool = false
var show_research_panel: bool = false
var show_crafting_panel: bool = false
var selected_crafting_building_id: String = ""
var selected_crafting_building_name: String = ""
var selected_crafting_building_instance_id: int = 0
var show_village_log_panel: bool = false
var village_log_messages: Array = []


func _ready() -> void:
    input_controller.setup(self)

    generate_region()
    print_region_resource_totals()
    print_settlement_inventory()
    print_research_status()
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
        queue_redraw()
        return

    update_villager_manager(delta)
    update_research(delta)

    queue_redraw()


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
    reset_research()
    setup_villager_manager()
    close_storage_selector()

    simulation_paused = true
    show_resource_inventory_panel = false
    show_research_panel = false
    close_crafting_panel()
    show_village_log_panel = false
    village_log_messages.clear()

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
    simulation_paused = true
    show_resource_inventory_panel = false
    show_research_panel = false
    close_crafting_panel()
    show_village_log_panel = false
    village_log_messages.clear()
    close_storage_selector()

    reset_test_inventory()
    reset_research()
    setup_villager_manager()

    print("Region Seed: ", region_seed)
    print("Source World Region Origin: ", source_selection_origin)
    print_source_world_selection_resource_totals()
    print_region_resource_totals()
    print_settlement_inventory()
    print_research_status()

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
    simulation_paused = true
    show_resource_inventory_panel = false
    show_research_panel = false
    close_crafting_panel()
    show_village_log_panel = false
    village_log_messages.clear()
    close_storage_selector()

    reset_test_inventory()
    reset_research()
    setup_villager_manager()

    print_region_resource_totals()
    print_settlement_inventory()
    print_research_status()
    queue_redraw()

    print("Regenerated region.")


func reset_test_inventory() -> void:
    inventory.reset()
    item_inventory.reset()


func reset_research() -> void:
    research.reset()


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
    var normal_housing_capacity: int = building_manager.get_normal_housing_capacity()

    villager_manager.set_global_movement_speed_bonus(
        research.get_villager_move_speed_bonus()
    )

    var harvested_resources: Dictionary = villager_manager.update(
        delta,
        inventory,
        normal_housing_capacity
    )

    var villager_event_messages: Array = villager_manager.get_event_messages()

    if not villager_event_messages.is_empty():
        add_village_log_messages(villager_event_messages)

    if not harvested_resources.is_empty():
        inventory.add_resources(harvested_resources)
        print_settlement_inventory()

    if villager_manager.has_tile_changes():
        queue_redraw()


func update_research(delta: float) -> void:
    research.update(
        delta,
        building_manager
    )


func clear_buildings() -> void:
    building_manager.clear_buildings()


func toggle_resource_markers() -> void:
    show_resource_markers = not show_resource_markers
    queue_redraw()

    print("Show Region Resource Markers: ", show_resource_markers)


func toggle_campfire_radius() -> void:
    show_campfire_radius = not show_campfire_radius
    queue_redraw()

    print("Show Campfire Radius: ", show_campfire_radius)


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
    close_storage_selector()
    building_manager.start_building_placement(building_id)
    queue_redraw()


func cancel_build_mode() -> void:
    building_manager.cancel_build_mode()
    queue_redraw()


func try_place_current_building(origin_tile: Vector2i) -> void:
    close_storage_selector()

    var did_place_building: bool = building_manager.try_place_current_building(
        origin_tile,
        inventory
    )

    if did_place_building:
        print_settlement_inventory()
        print_research_status()

    queue_redraw()


func add_village_log_message(message: String) -> void:
    if message == "":
        return

    village_log_messages.append(message)

    while village_log_messages.size() > VILLAGE_LOG_MAX_MESSAGES:
        village_log_messages.pop_front()


func add_village_log_messages(messages: Array) -> void:
    for message_index in range(messages.size()):
        add_village_log_message(str(messages[message_index]))


func try_handle_village_log_click(mouse_screen_position: Vector2) -> bool:
    if get_village_log_button_screen_rect().has_point(mouse_screen_position):
        show_village_log_panel = not show_village_log_panel
        queue_redraw()

        print("Show Village Log Panel: ", show_village_log_panel)
        return true

    if show_village_log_panel:
        if get_village_log_panel_screen_rect().has_point(mouse_screen_position):
            return true

    return false


func try_handle_top_info_panel_click(mouse_screen_position: Vector2) -> bool:
    if get_resources_button_screen_rect().has_point(mouse_screen_position):
        show_resource_inventory_panel = not show_resource_inventory_panel

        if show_resource_inventory_panel:
            show_research_panel = false
            close_crafting_panel()

        queue_redraw()

        print("Resources button clicked.")
        print("Show Resource Inventory Panel: ", show_resource_inventory_panel)
        return true

    if get_research_button_screen_rect().has_point(mouse_screen_position):
        show_research_panel = not show_research_panel

        if show_research_panel:
            show_resource_inventory_panel = false
            close_crafting_panel()

        queue_redraw()

        print("Research button clicked.")
        print("Show Research Panel: ", show_research_panel)
        return true

    if show_crafting_panel:
        if get_crafting_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_research_panel:
        if try_buy_research_from_mouse(mouse_screen_position):
            return true

        if get_research_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_resource_inventory_panel:
        if get_resource_list_panel_screen_rect().has_point(mouse_screen_position):
            return true

    return false


func try_buy_research_from_mouse(mouse_screen_position: Vector2) -> bool:
    var buyable_plans: Array = research.get_buyable_research_plans(
        building_manager,
        inventory
    )

    for plan_index in range(buyable_plans.size()):
        var plan_rect: Rect2 = get_research_plan_button_screen_rect(plan_index)

        if not plan_rect.has_point(mouse_screen_position):
            continue

        var plan: Dictionary = buyable_plans[plan_index]
        var research_id: String = str(plan.get("id", ""))

        buy_research_plan(research_id)
        return true

    return false


func buy_research_plan(research_id: String) -> void:
    var result: Dictionary = research.buy_research_plan(
        research_id,
        building_manager,
        inventory
    )

    var message: String = str(result.get("message", ""))

    if message != "":
        add_village_log_message(message)

    if not bool(result.get("success", false)):
        queue_redraw()
        return

    var unlocked_buildings: Array = result.get("unlocked_buildings", [])
    var unlocked_recipes: Array = result.get("unlocked_recipes", [])
    var global_bonuses: Array = result.get("global_bonuses", [])

    if not unlocked_buildings.is_empty():
        RegionBuildingData.unlock_buildings(unlocked_buildings)

        for building_index in range(unlocked_buildings.size()):
            var building_id: String = str(unlocked_buildings[building_index])
            var building_data: Dictionary = RegionBuildingData.get_building(building_id)
            var building_name: String = str(building_data.get("name", building_id))

            add_village_log_message("Unlocked building: " + building_name + ".")

    if not unlocked_recipes.is_empty():
        for recipe_index in range(unlocked_recipes.size()):
            var recipe_id: String = str(unlocked_recipes[recipe_index])
            add_village_log_message("Unlocked recipe: " + recipe_id + ".")

    if not global_bonuses.is_empty():
        for bonus_index in range(global_bonuses.size()):
            var bonus_variant: Variant = global_bonuses[bonus_index]

            if typeof(bonus_variant) != TYPE_DICTIONARY:
                continue

            var bonus_data: Dictionary = bonus_variant
            var bonus_name: String = str(bonus_data.get("name", "Global Bonus"))
            var bonus_amount: float = float(bonus_data.get("amount", 0.0))
            var bonus_percent: int = int(round(bonus_amount * 100.0))

            add_village_log_message(
                "Global bonus: "
                + bonus_name
                + " +"
                + str(bonus_percent)
                + "%."
            )

    print_research_status()
    queue_redraw()


func try_start_villager_drag_or_select() -> void:
    if storage_selector_open:
        if try_select_storage_resource_from_mouse():
            return

        close_storage_selector()

    if try_open_storage_selector_at_tile(hovered_tile):
        return

    if try_open_crafting_panel_at_tile(hovered_tile):
        return

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


func try_open_storage_selector_at_tile(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var building_data: Dictionary = building_manager.get_building_at_tile(tile_position)

    if building_data.is_empty():
        return false

    if not building_manager.is_storage_area_building(building_data):
        return false

    var selectable_resources: Array = inventory.get_selectable_storage_resources()

    if selectable_resources.is_empty():
        print("No storage resource options available. Gather at least 1 of a resource first.")
        return true

    storage_selector_open = true
    selected_storage_building_instance_id = int(building_data.get("instance_id", 0))
    storage_selector_anchor_tile = Vector2i(
        int(building_data.get("x", tile_position.x)),
        int(building_data.get("y", tile_position.y))
    )
    storage_selector_options = selectable_resources

    print("Storage Area selected. Choose resource:")
    for option_index in range(storage_selector_options.size()):
        print(str(option_index + 1) + ". " + str(storage_selector_options[option_index]))

    queue_redraw()
    return true


func try_select_storage_resource_from_mouse() -> bool:
    if not storage_selector_open:
        return false

    var mouse_world_position := get_global_mouse_position()
    var selected_index: int = get_storage_selector_option_index_at_position(mouse_world_position)

    if selected_index < 0:
        return false

    if selected_index >= storage_selector_options.size():
        return false

    var selected_resource: String = str(storage_selector_options[selected_index])

    var did_assign: bool = building_manager.assign_storage_area_resource(
        selected_storage_building_instance_id,
        selected_resource,
        inventory
    )

    if did_assign:
        print_settlement_inventory()

    close_storage_selector()
    queue_redraw()

    return true


func get_storage_selector_option_index_at_position(world_position: Vector2) -> int:
    if not storage_selector_open:
        return -1

    var selector_origin := get_storage_selector_world_position()

    for option_index in range(storage_selector_options.size()):
        var option_rect := Rect2(
            selector_origin + Vector2(
                0,
                option_index * (STORAGE_SELECTOR_BUTTON_HEIGHT + STORAGE_SELECTOR_BUTTON_GAP)
            ),
            Vector2(
                STORAGE_SELECTOR_BUTTON_WIDTH,
                STORAGE_SELECTOR_BUTTON_HEIGHT
            )
        )

        if option_rect.has_point(world_position):
            return option_index

    return -1


func get_storage_selector_world_position() -> Vector2:
    return Vector2(
        storage_selector_anchor_tile.x * REGION_TILE_SIZE,
        (storage_selector_anchor_tile.y * REGION_TILE_SIZE) - (
            storage_selector_options.size() * (STORAGE_SELECTOR_BUTTON_HEIGHT + STORAGE_SELECTOR_BUTTON_GAP)
        ) - 4
    )


func close_storage_selector() -> void:
    storage_selector_open = false
    selected_storage_building_instance_id = 0
    storage_selector_anchor_tile = Vector2i(-1, -1)
    storage_selector_options = []
    queue_redraw()


func try_open_crafting_panel_at_tile(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var building_data: Dictionary = building_manager.get_building_at_tile(tile_position)

    if building_data.is_empty():
        return false

    var building_id: String = str(building_data.get("id", ""))
    var craftable_recipes: Array = crafting.get_craftable_recipes_for_building(
        building_id,
        research,
        inventory
    )

    if craftable_recipes.is_empty():
        return false

    show_crafting_panel = true
    show_resource_inventory_panel = false
    show_research_panel = false

    selected_crafting_building_id = building_id
    selected_crafting_building_name = str(building_data.get("name", building_id))
    selected_crafting_building_instance_id = int(building_data.get("instance_id", 0))

    print("Opened crafting panel for: " + selected_crafting_building_name)

    queue_redraw()
    return true


func close_crafting_panel() -> void:
    show_crafting_panel = false
    selected_crafting_building_id = ""
    selected_crafting_building_name = ""
    selected_crafting_building_instance_id = 0


func print_settlement_inventory() -> void:
    inventory.print_inventory(villager_manager.get_population_count())
    item_inventory.print_inventory()


func add_crafted_items_from_recipe_outputs(outputs: Array) -> void:
    item_inventory.add_items_from_outputs(outputs)
    item_inventory.print_inventory()


func print_research_status() -> void:
    research.print_research_status(building_manager)


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
        show_campfire_radius,
        building_manager,
        villager_manager,
        hovered_tile,
        selected_tile,
        is_dragging_villager,
        drag_assignment_tile,
        HARVEST_ASSIGN_RADIUS,
        simulation_paused
    )

    draw_storage_selector()
    draw_top_info_panel()
    draw_resource_inventory_panel()
    draw_research_panel()
    draw_crafting_panel()
    draw_village_log_button()
    draw_village_log_panel()
    draw_paused_villager_hover_panel()


func draw_storage_selector() -> void:
    if not storage_selector_open:
        return

    var selector_origin := get_storage_selector_world_position()

    for option_index in range(storage_selector_options.size()):
        var resource_name: String = str(storage_selector_options[option_index])

        var option_position := selector_origin + Vector2(
            0,
            option_index * (STORAGE_SELECTOR_BUTTON_HEIGHT + STORAGE_SELECTOR_BUTTON_GAP)
        )

        var option_rect := Rect2(
            option_position,
            Vector2(
                STORAGE_SELECTOR_BUTTON_WIDTH,
                STORAGE_SELECTOR_BUTTON_HEIGHT
            )
        )

        draw_rect(option_rect, Color(0.08, 0.07, 0.05, 0.92), true)
        draw_rect(option_rect, Color(0.95, 0.82, 0.45, 1.0), false, 1.5)

        draw_string(
            ThemeDB.fallback_font,
            option_position + Vector2(6, 15),
            resource_name,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            14,
            Color(1.0, 1.0, 1.0, 1.0)
        )


func draw_top_info_panel() -> void:
    var world_per_screen_y: float = get_world_per_screen_y()

    var panel_screen_rect: Rect2 = get_top_info_panel_screen_rect()
    var panel_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)

    draw_rect(
        panel_rect,
        Color(0.05, 0.05, 0.05, 0.82),
        true
    )

    draw_rect(
        panel_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    var research_text := "Research: " + str(research.get_research_points())
    var villager_text := "Villagers: " + str(villager_manager.get_population_count())

    var normal_housing_capacity: int = building_manager.get_normal_housing_capacity()
    var available_shelter: int = max(
        0,
        normal_housing_capacity - villager_manager.get_population_count()
    )

    var shelter_text := "Shelter: " + str(available_shelter) + " open"

    var font_size: int = int(max(10.0, 14.0 * world_per_screen_y))
    var small_font_size: int = int(max(9.0, 12.0 * world_per_screen_y))

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 22)),
        research_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(126, 22)),
        villager_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(126, 44)),
        shelter_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    draw_resources_button()
    draw_research_button()


func draw_resources_button() -> void:
    var world_per_screen_y: float = get_world_per_screen_y()
    var button_screen_rect: Rect2 = get_resources_button_screen_rect()
    var button_world_rect: Rect2 = screen_rect_to_world_rect(button_screen_rect)

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)
    var button_border_color := Color(0.95, 0.82, 0.45, 1.0)

    if show_resource_inventory_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

    draw_rect(
        button_world_rect,
        button_border_color,
        false,
        max(1.0, 1.25 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(button_screen_rect.position + Vector2(8, 16)),
        "Resources",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(9.0, 12.0 * world_per_screen_y)),
        Color(1.0, 1.0, 1.0, 1.0)
    )


func draw_research_button() -> void:
    var world_per_screen_y: float = get_world_per_screen_y()
    var button_screen_rect: Rect2 = get_research_button_screen_rect()
    var button_world_rect: Rect2 = screen_rect_to_world_rect(button_screen_rect)

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_research_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

    draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        max(1.0, 1.25 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(button_screen_rect.position + Vector2(8, 16)),
        "Research",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(9.0, 12.0 * world_per_screen_y)),
        Color(1.0, 1.0, 1.0, 1.0)
    )


func draw_resource_inventory_panel() -> void:
    if not show_resource_inventory_panel:
        return

    var world_per_screen_y: float = get_world_per_screen_y()
    var panel_screen_rect: Rect2 = get_resource_list_panel_screen_rect()
    var panel_world_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)

    draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.92),
        true
    )

    draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 20)),
        "Village Resources",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(10.0, 13.0 * world_per_screen_y)),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    var visible_resources: Array = get_visible_inventory_resource_names()

    if visible_resources.is_empty():
        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 44)),
            "No stored resources",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(9.0, 12.0 * world_per_screen_y)),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    for resource_index in range(visible_resources.size()):
        var resource_name: String = str(visible_resources[resource_index])
        var current_amount: int = inventory.get_amount(resource_name)
        var resource_cap: int = inventory.get_resource_cap(resource_name)

        var resource_text := resource_name + ": " + str(current_amount) + "/" + str(resource_cap)

        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(
                panel_screen_rect.position + Vector2(
                    10,
                    44 + resource_index * RESOURCE_LIST_ROW_HEIGHT
                )
            ),
            resource_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(9.0, 12.0 * world_per_screen_y)),
            Color(1.0, 1.0, 1.0, 1.0)
        )


func draw_research_panel() -> void:
    if not show_research_panel:
        return

    var world_per_screen_y: float = get_world_per_screen_y()
    var panel_screen_rect: Rect2 = get_research_panel_screen_rect()
    var panel_world_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)

    draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

    draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 20)),
        "Available Research",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(10.0, 13.0 * world_per_screen_y)),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    var buyable_plans: Array = research.get_buyable_research_plans(
        building_manager,
        inventory
    )

    if buyable_plans.is_empty():
        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 48)),
            "No affordable research available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(9.0, 12.0 * world_per_screen_y)),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_rows: int = int(floor(float(RESEARCH_PANEL_HEIGHT - 44) / float(RESEARCH_ROW_HEIGHT)))
    var visible_count: int = min(buyable_plans.size(), max_rows)

    for plan_index in range(visible_count):
        var plan: Dictionary = buyable_plans[plan_index]
        var plan_button_screen_rect: Rect2 = get_research_plan_button_screen_rect(plan_index)
        var plan_button_world_rect: Rect2 = screen_rect_to_world_rect(plan_button_screen_rect)

        draw_rect(
            plan_button_world_rect,
            Color(0.12, 0.10, 0.07, 0.95),
            true
        )

        draw_rect(
            plan_button_world_rect,
            Color(0.65, 0.55, 0.32, 0.95),
            false,
            max(1.0, 1.0 * world_per_screen_y)
        )

        var plan_name: String = str(plan.get("name", "Research"))
        var plan_cost: int = int(plan.get("cost", 0))
        var plan_text: String = plan_name + " — " + str(plan_cost) + " Research"

        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(plan_button_screen_rect.position + Vector2(8, 20)),
            plan_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(8.0, 11.0 * world_per_screen_y)),
            Color(1.0, 1.0, 1.0, 1.0)
        )


func draw_crafting_panel() -> void:
    if not show_crafting_panel:
        return

    var world_per_screen_y: float = get_world_per_screen_y()
    var panel_screen_rect: Rect2 = get_crafting_panel_screen_rect()
    var panel_world_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)

    draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

    draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 20)),
        selected_crafting_building_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(10.0, 13.0 * world_per_screen_y)),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    var craftable_recipes: Array = crafting.get_craftable_recipes_for_building(
        selected_crafting_building_id,
        research,
        inventory
    )

    if craftable_recipes.is_empty():
        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 48)),
            "No affordable recipes available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(9.0, 12.0 * world_per_screen_y)),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_rows: int = int(floor(float(CRAFTING_PANEL_HEIGHT - 44) / float(CRAFTING_ROW_HEIGHT)))
    var visible_count: int = min(craftable_recipes.size(), max_rows)

    for recipe_index in range(visible_count):
        var recipe: Dictionary = craftable_recipes[recipe_index]
        var recipe_button_screen_rect: Rect2 = get_crafting_recipe_button_screen_rect(recipe_index)
        var recipe_button_world_rect: Rect2 = screen_rect_to_world_rect(recipe_button_screen_rect)

        draw_rect(
            recipe_button_world_rect,
            Color(0.12, 0.10, 0.07, 0.95),
            true
        )

        draw_rect(
            recipe_button_world_rect,
            Color(0.65, 0.55, 0.32, 0.95),
            false,
            max(1.0, 1.0 * world_per_screen_y)
        )

        var recipe_id: String = str(recipe.get("id", ""))
        var recipe_name: String = str(recipe.get("name", "Recipe"))
        var cost_text: String = crafting.get_recipe_cost_text(recipe_id)
        var output_text: String = crafting.get_recipe_output_text(recipe_id)

        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(recipe_button_screen_rect.position + Vector2(8, 16)),
            recipe_name,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(8.0, 11.0 * world_per_screen_y)),
            Color(1.0, 1.0, 1.0, 1.0)
        )

        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(recipe_button_screen_rect.position + Vector2(8, 32)),
            "Cost: " + cost_text + "  ->  " + output_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(7.0, 10.0 * world_per_screen_y)),
            Color(0.88, 0.88, 0.88, 1.0)
        )


func draw_village_log_button() -> void:
    var world_per_screen_y: float = get_world_per_screen_y()
    var button_screen_rect: Rect2 = get_village_log_button_screen_rect()
    var button_world_rect: Rect2 = screen_rect_to_world_rect(button_screen_rect)

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_village_log_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

    draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        max(1.0, 1.25 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(button_screen_rect.position + Vector2(12, 18)),
        "Village Log",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(9.0, 12.0 * world_per_screen_y)),
        Color(1.0, 1.0, 1.0, 1.0)
    )


func draw_village_log_panel() -> void:
    if not show_village_log_panel:
        return

    var world_per_screen_y: float = get_world_per_screen_y()
    var panel_screen_rect: Rect2 = get_village_log_panel_screen_rect()
    var panel_world_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)

    draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

    draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 20)),
        "Village Log",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        int(max(10.0, 13.0 * world_per_screen_y)),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if village_log_messages.is_empty():
        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(panel_screen_rect.position + Vector2(10, 46)),
            "No events yet.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(9.0, 12.0 * world_per_screen_y)),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_visible_rows: int = int(floor(float(VILLAGE_LOG_PANEL_HEIGHT - 44) / float(VILLAGE_LOG_ROW_HEIGHT)))
    var start_index: int = max(0, village_log_messages.size() - max_visible_rows)

    var draw_row: int = 0

    for message_index in range(start_index, village_log_messages.size()):
        var message_text: String = str(village_log_messages[message_index])

        draw_string(
            ThemeDB.fallback_font,
            screen_position_to_world_position(
                panel_screen_rect.position + Vector2(
                    10,
                    46 + draw_row * VILLAGE_LOG_ROW_HEIGHT
                )
            ),
            message_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            int(max(8.0, 11.0 * world_per_screen_y)),
            Color(1.0, 1.0, 1.0, 1.0)
        )

        draw_row += 1


func draw_paused_villager_hover_panel() -> void:
    if not simulation_paused:
        return

    if is_dragging_villager:
        return

    var mouse_world_position: Vector2 = get_global_mouse_position()
    var villager_data: Dictionary = villager_manager.get_villager_data_at_world_position(
        mouse_world_position,
        VILLAGER_DRAG_HIT_RADIUS
    )

    if villager_data.is_empty():
        return

    draw_villager_hover_panel(villager_data)


func draw_villager_hover_panel(villager_data: Dictionary) -> void:
    var mouse_screen_position: Vector2 = get_viewport().get_mouse_position()
    var panel_screen_position: Vector2 = mouse_screen_position + VILLAGER_HOVER_PANEL_OFFSET

    var viewport_size: Vector2 = get_viewport().get_visible_rect().size

    if panel_screen_position.x + VILLAGER_HOVER_PANEL_WIDTH > viewport_size.x:
        panel_screen_position.x = mouse_screen_position.x - VILLAGER_HOVER_PANEL_WIDTH - VILLAGER_HOVER_PANEL_OFFSET.x

    if panel_screen_position.y + VILLAGER_HOVER_PANEL_HEIGHT > viewport_size.y:
        panel_screen_position.y = mouse_screen_position.y - VILLAGER_HOVER_PANEL_HEIGHT - VILLAGER_HOVER_PANEL_OFFSET.y

    var panel_screen_rect := Rect2(
        panel_screen_position,
        Vector2(
            VILLAGER_HOVER_PANEL_WIDTH,
            VILLAGER_HOVER_PANEL_HEIGHT
        )
    )

    var panel_world_rect: Rect2 = screen_rect_to_world_rect(panel_screen_rect)
    var world_per_screen_y: float = get_world_per_screen_y()

    draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

    draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        max(1.0, 1.5 * world_per_screen_y)
    )

    draw_villager_hover_panel_text(
        villager_data,
        panel_screen_rect
    )


func draw_villager_hover_panel_text(
    villager_data: Dictionary,
    panel_screen_rect: Rect2
) -> void:
    var world_per_screen_y: float = get_world_per_screen_y()
    var title_font_size: int = int(max(10.0, 13.0 * world_per_screen_y))
    var body_font_size: int = int(max(8.0, 11.0 * world_per_screen_y))

    var villager_name: String = str(villager_data.get("name", "Villager"))
    var gender: String = str(villager_data.get("gender", "unknown"))
    var level: float = float(villager_data.get("level", 0.0))
    var speed: int = int(villager_data.get("speed", 100))
    var health_state: String = str(villager_data.get("health_state", "healthy"))
    var current_state: String = str(villager_data.get("state", "idle"))
    var is_housed: bool = bool(villager_data.get("is_housed", false))
    var housed_text: String = "Housed"

    if not is_housed:
        housed_text = "Unhoused"

    var belongings: Array = villager_data.get("belongings", [])
    var max_belongings: int = int(villager_data.get("max_belongings", 2))
    var statuses: Array = villager_data.get("statuses", [])
    var statuses_text: String = "None"

    if not statuses.is_empty():
        var status_parts: Array = []

        for status_index in range(statuses.size()):
            status_parts.append(str(statuses[status_index]))

        statuses_text = ", ".join(status_parts)

    var skills: Dictionary = villager_data.get("skills", {})

    var text_x: float = panel_screen_rect.position.x + 10.0
    var text_y: float = panel_screen_rect.position.y + 18.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        villager_name + " (" + gender + ")",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 18.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "Level: " + str(snappedf(level, 0.1)) + "    Speed: " + str(speed),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "Health: " + health_state + "    " + housed_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "State: " + current_state,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "Belongings: " + str(belongings.size()) + "/" + str(max_belongings),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "Statuses: " + statuses_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 20.0

    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        "Skills",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 15.0

    draw_villager_skill_line("Gathering", int(skills.get(VillagerManager.SKILL_GATHERING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Wood Working", int(skills.get(VillagerManager.SKILL_WOOD_WORKING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Stone Working", int(skills.get(VillagerManager.SKILL_STONE_WORKING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Building", int(skills.get(VillagerManager.SKILL_BUILDING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Hauling", int(skills.get(VillagerManager.SKILL_HAULING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Medicine", int(skills.get(VillagerManager.SKILL_MEDICINE, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line("Thinking", int(skills.get(VillagerManager.SKILL_THINKING, 0)), text_x, text_y, body_font_size)


func draw_villager_skill_line(
    skill_label: String,
    skill_value: int,
    text_x: float,
    text_y: float,
    font_size: int
) -> void:
    draw_string(
        ThemeDB.fallback_font,
        screen_position_to_world_position(Vector2(text_x, text_y)),
        skill_label + ": " + str(skill_value),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )


func get_top_info_panel_screen_rect() -> Rect2:
    var viewport_size: Vector2 = get_viewport().get_visible_rect().size

    return Rect2(
        Vector2(
            viewport_size.x - TOP_INFO_PANEL_WIDTH - TOP_INFO_PANEL_MARGIN,
            TOP_INFO_PANEL_MARGIN
        ),
        Vector2(
            TOP_INFO_PANEL_WIDTH,
            TOP_INFO_PANEL_HEIGHT
        )
    )


func get_resources_button_screen_rect() -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect()

    return Rect2(
        panel_rect.position + Vector2(10, 54),
        Vector2(
            TOP_INFO_RESOURCE_BUTTON_WIDTH,
            TOP_INFO_RESOURCE_BUTTON_HEIGHT
        )
    )


func get_research_button_screen_rect() -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect()

    return Rect2(
        panel_rect.position + Vector2(10, 82),
        Vector2(
            TOP_INFO_RESEARCH_BUTTON_WIDTH,
            TOP_INFO_RESEARCH_BUTTON_HEIGHT
        )
    )


func get_resource_list_panel_screen_rect() -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect()
    var visible_resources: Array = get_visible_inventory_resource_names()
    var row_count: int = max(1, visible_resources.size())

    return Rect2(
        Vector2(
            panel_rect.position.x,
            panel_rect.position.y + panel_rect.size.y + RESOURCE_LIST_PANEL_GAP
        ),
        Vector2(
            RESOURCE_LIST_PANEL_WIDTH,
            30 + row_count * RESOURCE_LIST_ROW_HEIGHT
        )
    )


func get_research_panel_screen_rect() -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect()

    return Rect2(
        Vector2(
            panel_rect.position.x - RESEARCH_PANEL_WIDTH + TOP_INFO_PANEL_WIDTH,
            panel_rect.position.y + panel_rect.size.y + RESEARCH_PANEL_GAP
        ),
        Vector2(
            RESEARCH_PANEL_WIDTH,
            RESEARCH_PANEL_HEIGHT
        )
    )


func get_research_plan_button_screen_rect(plan_index: int) -> Rect2:
    var panel_rect: Rect2 = get_research_panel_screen_rect()

    return Rect2(
        panel_rect.position + Vector2(
            10,
            34 + plan_index * RESEARCH_ROW_HEIGHT
        ),
        Vector2(
            RESEARCH_PANEL_WIDTH - 20,
            RESEARCH_ROW_HEIGHT - 4
        )
    )


func get_crafting_panel_screen_rect() -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect()

    return Rect2(
        Vector2(
            panel_rect.position.x - CRAFTING_PANEL_WIDTH + TOP_INFO_PANEL_WIDTH,
            panel_rect.position.y + panel_rect.size.y + CRAFTING_PANEL_GAP
        ),
        Vector2(
            CRAFTING_PANEL_WIDTH,
            CRAFTING_PANEL_HEIGHT
        )
    )


func get_crafting_recipe_button_screen_rect(recipe_index: int) -> Rect2:
    var panel_rect: Rect2 = get_crafting_panel_screen_rect()

    return Rect2(
        panel_rect.position + Vector2(
            10,
            34 + recipe_index * CRAFTING_ROW_HEIGHT
        ),
        Vector2(
            CRAFTING_PANEL_WIDTH - 20,
            CRAFTING_ROW_HEIGHT - 4
        )
    )


func get_village_log_button_screen_rect() -> Rect2:
    var viewport_size: Vector2 = get_viewport().get_visible_rect().size

    return Rect2(
        Vector2(
            VILLAGE_LOG_MARGIN,
            viewport_size.y - VILLAGE_LOG_BUTTON_HEIGHT - VILLAGE_LOG_MARGIN - VILLAGE_LOG_BOTTOM_OFFSET
        ),
        Vector2(
            VILLAGE_LOG_BUTTON_WIDTH,
            VILLAGE_LOG_BUTTON_HEIGHT
        )
    )


func get_village_log_panel_screen_rect() -> Rect2:
    var button_rect: Rect2 = get_village_log_button_screen_rect()

    return Rect2(
        Vector2(
            VILLAGE_LOG_MARGIN,
            button_rect.position.y - VILLAGE_LOG_PANEL_HEIGHT - 6
        ),
        Vector2(
            VILLAGE_LOG_PANEL_WIDTH,
            VILLAGE_LOG_PANEL_HEIGHT
        )
    )


func screen_rect_to_world_rect(screen_rect: Rect2) -> Rect2:
    var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    var world_per_screen_x: float = inverse_transform.basis_xform(Vector2.RIGHT).length()
    var world_per_screen_y: float = inverse_transform.basis_xform(Vector2.DOWN).length()

    return Rect2(
        inverse_transform * screen_rect.position,
        Vector2(
            screen_rect.size.x * world_per_screen_x,
            screen_rect.size.y * world_per_screen_y
        )
    )


func screen_position_to_world_position(screen_position: Vector2) -> Vector2:
    var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    return inverse_transform * screen_position


func get_world_per_screen_y() -> float:
    var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    return inverse_transform.basis_xform(Vector2.DOWN).length()


func get_visible_inventory_resource_names() -> Array:
    var visible_resources: Array = []
    var all_resources: Dictionary = inventory.get_all_resources()
    var resource_names: Array = all_resources.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var amount: int = int(all_resources.get(resource_name, 0))

        if amount <= 0:
            continue

        visible_resources.append(resource_name)

    return visible_resources


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < REGION_WIDTH
        and tile_position.y < REGION_HEIGHT
    )
