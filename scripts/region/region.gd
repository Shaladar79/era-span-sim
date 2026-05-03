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

const VILLAGE_LOG_MAX_MESSAGES: int = 50

const SAVE_KEY_REGION_NAME: String = "region_name"
const SAVE_KEY_REGION_SEED: String = "region_seed"
const SAVE_KEY_SOURCE_WORLD_SEED: String = "source_world_seed"
const SAVE_KEY_SOURCE_SELECTION_ORIGIN: String = "source_selection_origin"
const SAVE_KEY_SOURCE_WORLD_RESOURCE_TOTALS: String = "source_world_resource_totals"
const SAVE_KEY_SOURCE_WORLD_TILES: String = "source_world_tiles"
const SAVE_KEY_REGION_TILES: String = "region_tiles"

const SAVE_KEY_HOVERED_TILE: String = "hovered_tile"
const SAVE_KEY_SELECTED_TILE: String = "selected_tile"
const SAVE_KEY_SHOW_RESOURCE_MARKERS: String = "show_resource_markers"
const SAVE_KEY_SHOW_CAMPFIRE_RADIUS: String = "show_campfire_radius"
const SAVE_KEY_SIMULATION_PAUSED: String = "simulation_paused"

const SAVE_KEY_INVENTORY: String = "inventory"
const SAVE_KEY_ITEM_INVENTORY: String = "item_inventory"
const SAVE_KEY_RESEARCH: String = "research"
const SAVE_KEY_BUILDING_MANAGER: String = "building_manager"
const SAVE_KEY_VILLAGER_MANAGER: String = "villager_manager"
const SAVE_KEY_WILD_ANIMAL_MANAGER: String = "wild_animal_manager"

const SAVE_KEY_VILLAGE_LOG_MESSAGES: String = "village_log_messages"

const SAVE_TYPE_KEY: String = "__save_type"
const SAVE_TYPE_VECTOR2I: String = "Vector2i"
const SAVE_TYPE_VECTOR2: String = "Vector2"

@export var region_seed: int = 12345

var region_name: String = "New Settlement"

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
var wild_animal_manager := RegionWildAnimalManager.new()
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
var show_village_inventory_panel: bool = false
var show_research_panel: bool = false
var show_build_panel: bool = false
var selected_build_age: String = RegionBuildingData.get_default_build_age()
var selected_build_category: String = RegionBuildingData.get_default_build_category_for_age(selected_build_age)

var show_crafting_panel: bool = false
var selected_crafting_building_id: String = ""
var selected_crafting_building_name: String = ""
var selected_crafting_building_instance_id: int = 0

var show_assignment_panel: bool = false
var selected_assignment_building_instance_id: int = 0

var show_village_log_panel: bool = false
var show_debug_panel: bool = false
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


func set_region_name(new_region_name: String) -> void:
    region_name = new_region_name.strip_edges()

    if region_name == "":
        region_name = "New Settlement"

    print("Region Name: ", region_name)
    queue_redraw()


func get_region_name() -> String:
    return region_name


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_REGION_NAME: region_name,
        SAVE_KEY_REGION_SEED: region_seed,
        SAVE_KEY_SOURCE_WORLD_SEED: source_world_seed,
        SAVE_KEY_SOURCE_SELECTION_ORIGIN: get_save_safe_value(source_selection_origin),
        SAVE_KEY_SOURCE_WORLD_RESOURCE_TOTALS: source_world_resource_totals.duplicate(true),
        SAVE_KEY_SOURCE_WORLD_TILES: get_save_safe_value(source_world_tiles),
        SAVE_KEY_REGION_TILES: get_save_safe_value(region_tiles),
        SAVE_KEY_HOVERED_TILE: get_save_safe_value(hovered_tile),
        SAVE_KEY_SELECTED_TILE: get_save_safe_value(selected_tile),
        SAVE_KEY_SHOW_RESOURCE_MARKERS: show_resource_markers,
        SAVE_KEY_SHOW_CAMPFIRE_RADIUS: show_campfire_radius,
        SAVE_KEY_SIMULATION_PAUSED: simulation_paused,
        SAVE_KEY_INVENTORY: inventory.get_save_data(),
        SAVE_KEY_ITEM_INVENTORY: item_inventory.get_save_data(),
        SAVE_KEY_RESEARCH: research.get_save_data(),
        SAVE_KEY_BUILDING_MANAGER: building_manager.get_save_data(),
        SAVE_KEY_VILLAGER_MANAGER: villager_manager.get_save_data(),
        SAVE_KEY_WILD_ANIMAL_MANAGER: wild_animal_manager.get_save_data(),
        SAVE_KEY_VILLAGE_LOG_MESSAGES: village_log_messages.duplicate(true)
    }


func load_save_data(save_data: Dictionary) -> void:
    if save_data.is_empty():
        return

    region_name = str(save_data.get(SAVE_KEY_REGION_NAME, "New Settlement")).strip_edges()

    if region_name == "":
        region_name = "New Settlement"

    region_seed = int(save_data.get(SAVE_KEY_REGION_SEED, region_seed))
    source_world_seed = int(save_data.get(SAVE_KEY_SOURCE_WORLD_SEED, 0))
    source_world_resource_totals = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_SOURCE_WORLD_RESOURCE_TOTALS, {})
    ).duplicate(true)

    var restored_origin: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_SOURCE_SELECTION_ORIGIN, Vector2i(-1, -1))
    )

    if typeof(restored_origin) == TYPE_VECTOR2I:
        source_selection_origin = restored_origin
    else:
        source_selection_origin = Vector2i(-1, -1)

    var restored_source_world_tiles: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_SOURCE_WORLD_TILES, [])
    )

    if typeof(restored_source_world_tiles) == TYPE_ARRAY:
        source_world_tiles = restored_source_world_tiles
    else:
        source_world_tiles = []

    var restored_region_tiles: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_REGION_TILES, [])
    )

    if typeof(restored_region_tiles) == TYPE_ARRAY and not restored_region_tiles.is_empty():
        region_tiles = restored_region_tiles
    elif not source_world_tiles.is_empty():
        region_tiles = RegionGenerator.generate_region_from_world_selection(
            REGION_WIDTH,
            REGION_HEIGHT,
            region_seed,
            source_world_tiles
        )
    else:
        region_tiles = RegionGenerator.generate_region(
            REGION_WIDTH,
            REGION_HEIGHT,
            region_seed
        )

    setup_building_manager()
    setup_villager_manager_for_loaded_save()
    setup_wild_animal_manager()

    var restored_hovered_tile: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_HOVERED_TILE, Vector2i(-1, -1))
    )

    if typeof(restored_hovered_tile) == TYPE_VECTOR2I:
        hovered_tile = restored_hovered_tile
    else:
        hovered_tile = Vector2i(-1, -1)

    var restored_selected_tile: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_SELECTED_TILE, Vector2i(-1, -1))
    )

    if typeof(restored_selected_tile) == TYPE_VECTOR2I:
        selected_tile = restored_selected_tile
    else:
        selected_tile = Vector2i(-1, -1)

    show_resource_markers = bool(save_data.get(SAVE_KEY_SHOW_RESOURCE_MARKERS, true))
    show_campfire_radius = bool(save_data.get(SAVE_KEY_SHOW_CAMPFIRE_RADIUS, false))
    simulation_paused = bool(save_data.get(SAVE_KEY_SIMULATION_PAUSED, true))

    storage_selector_open = false
    selected_storage_building_instance_id = 0
    storage_selector_anchor_tile = Vector2i(-1, -1)
    storage_selector_options = []

    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)

    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_crafting_panel()
    close_assignment_panel()
    show_village_log_panel = false
    show_debug_panel = false

    var inventory_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_INVENTORY, {})
    )
    inventory.load_save_data(inventory_save_data)

    var item_inventory_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_ITEM_INVENTORY, {})
    )
    item_inventory.load_save_data(item_inventory_save_data)

    var research_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_RESEARCH, {})
    )
    research.load_save_data(research_save_data)

    var building_manager_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_BUILDING_MANAGER, {})
    )
    building_manager.load_save_data(building_manager_save_data)

    var villager_manager_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_VILLAGER_MANAGER, {})
    )
    villager_manager.load_save_data(villager_manager_save_data)

    var wild_animal_manager_save_data: Dictionary = get_dictionary_from_variant(
        save_data.get(SAVE_KEY_WILD_ANIMAL_MANAGER, {})
    )
    wild_animal_manager.load_save_data(wild_animal_manager_save_data)

    restore_runtime_unlocks_from_loaded_research()

    village_log_messages.clear()

    var saved_log_messages: Variant = save_data.get(SAVE_KEY_VILLAGE_LOG_MESSAGES, [])

    if typeof(saved_log_messages) == TYPE_ARRAY:
        var log_array: Array = saved_log_messages

        for message_index in range(log_array.size()):
            add_village_log_message(str(log_array[message_index]))

    add_village_log_message("Loaded settlement: " + region_name + ".")

    print("Loaded Region Name: ", region_name)
    print("Loaded Region Seed: ", region_seed)
    print_settlement_inventory()
    print_research_status()

    queue_redraw()


func setup_villager_manager_for_loaded_save() -> void:
    villager_manager.setup(
        region_tiles,
        REGION_WIDTH,
        REGION_HEIGHT,
        REGION_TILE_SIZE,
        REGION_TERRAIN_GRASS,
        REGION_TERRAIN_WATER,
        FEATURE_NONE
    )


func setup_wild_animal_manager() -> void:
    wild_animal_manager.setup(
        region_tiles,
        REGION_WIDTH,
        REGION_HEIGHT
    )


func spawn_stone_age_wild_animals() -> void:
    setup_wild_animal_manager()
    wild_animal_manager.spawn_stone_age_animals(
        region_seed,
        get_campfire_center_tiles()
    )

    var animal_count: int = wild_animal_manager.get_active_animals().size()
    add_village_log_message("Wild animals spotted in the region: " + str(animal_count) + ".")
    print("Wild animals spawned: ", animal_count)


func relocate_wild_animals_away_from_campfires() -> void:
    setup_wild_animal_manager()

    var moved_count: int = wild_animal_manager.relocate_animals_away_from_campfires(
        get_campfire_center_tiles()
    )

    if moved_count <= 0:
        return

    add_village_log_message("Wild animals moved away from campfires: " + str(moved_count) + ".")
    print("Wild animals moved away from campfires: ", moved_count)


func get_campfire_center_tiles() -> Array:
    var campfire_tiles: Array = []
    var manager_buildings: Array = building_manager.get_buildings()

    for building_index in range(manager_buildings.size()):
        var building_variant: Variant = manager_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != BUILDING_CAMPFIRE:
            continue

        var tile_x: int = int(building_data.get("x", 0))
        var tile_y: int = int(building_data.get("y", 0))
        var width: int = int(building_data.get("width", 1))
        var height: int = int(building_data.get("height", 1))

        var center_tile := Vector2i(
            tile_x + int(floor(float(width) / 2.0)),
            tile_y + int(floor(float(height) / 2.0))
        )

        campfire_tiles.append(center_tile)

    return campfire_tiles


func restore_runtime_unlocks_from_loaded_research() -> void:
    RegionBuildingData.reset_runtime_unlocks()

    var loaded_unlocked_buildings: Array = research.get_unlocked_buildings()

    if not loaded_unlocked_buildings.is_empty():
        RegionBuildingData.unlock_buildings(loaded_unlocked_buildings)


func get_dictionary_from_variant(value: Variant) -> Dictionary:
    if typeof(value) != TYPE_DICTIONARY:
        return {}

    var dictionary_value: Dictionary = value
    return dictionary_value
    
func get_save_safe_value(value: Variant) -> Variant:
    match typeof(value):
        TYPE_VECTOR2I:
            var vector_i_value: Vector2i = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2I,
                "x": vector_i_value.x,
                "y": vector_i_value.y
            }

        TYPE_VECTOR2:
            var vector_value: Vector2 = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2,
                "x": vector_value.x,
                "y": vector_value.y
            }

        TYPE_DICTIONARY:
            var source_dict: Dictionary = value
            var output_dict: Dictionary = {}
            var keys: Array = source_dict.keys()

            for key_index in range(keys.size()):
                var key_variant: Variant = keys[key_index]
                var key_string: String = str(key_variant)

                output_dict[key_string] = get_save_safe_value(source_dict.get(key_variant))

            return output_dict

        TYPE_ARRAY:
            var source_array: Array = value
            var output_array: Array = []

            for value_index in range(source_array.size()):
                output_array.append(get_save_safe_value(source_array[value_index]))

            return output_array

        _:
            return value


func restore_save_safe_value(value: Variant) -> Variant:
    if typeof(value) == TYPE_DICTIONARY:
        var source_dict: Dictionary = value
        var save_type: String = str(source_dict.get(SAVE_TYPE_KEY, ""))

        if save_type == SAVE_TYPE_VECTOR2I:
            return Vector2i(
                int(source_dict.get("x", 0)),
                int(source_dict.get("y", 0))
            )

        if save_type == SAVE_TYPE_VECTOR2:
            return Vector2(
                float(source_dict.get("x", 0.0)),
                float(source_dict.get("y", 0.0))
            )

        var restored_dict: Dictionary = {}
        var keys: Array = source_dict.keys()

        for key_index in range(keys.size()):
            var key_variant: Variant = keys[key_index]
            var key_string: String = str(key_variant)

            restored_dict[key_string] = restore_save_safe_value(source_dict.get(key_variant))

        return restored_dict

    if typeof(value) == TYPE_ARRAY:
        var source_array: Array = value
        var restored_array: Array = []

        for value_index in range(source_array.size()):
            restored_array.append(restore_save_safe_value(source_array[value_index]))

        return restored_array

    return value


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
    update_hunting_jobs(delta)
    update_research(delta)
    update_wild_animal_manager(delta)

    queue_redraw()


func update_wild_animal_manager(delta: float) -> void:
    setup_wild_animal_manager()

    var campfire_tiles: Array = get_campfire_center_tiles()

    var did_animals_move: bool = wild_animal_manager.update_wild_animals(
        delta,
        campfire_tiles
    )

    var did_respawn: bool = wild_animal_manager.update_respawns(
        delta,
        campfire_tiles
    )

    var animal_event_messages: Array = wild_animal_manager.get_event_messages()

    if not animal_event_messages.is_empty():
        add_village_log_messages(animal_event_messages)

    if did_animals_move or did_respawn:
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
    reset_build_panel_filters()
    setup_building_manager()
    clear_buildings()
    setup_wild_animal_manager()
    reset_test_inventory()
    reset_research()
    setup_villager_manager()
    close_storage_selector()
    spawn_stone_age_wild_animals()

    simulation_paused = true
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_crafting_panel()
    close_assignment_panel()
    show_village_log_panel = false
    show_debug_panel = false
    village_log_messages.clear()
    add_village_log_message("Settlement founded: " + region_name + ".")

    print("Region Seed: ", region_seed)
    print("Region Name: ", region_name)


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
    reset_build_panel_filters()
    setup_building_manager()
    clear_buildings()
    setup_wild_animal_manager()

    hovered_tile = Vector2i(-1, -1)
    selected_tile = Vector2i(-1, -1)
    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)
    simulation_paused = true
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_crafting_panel()
    close_assignment_panel()
    show_village_log_panel = false
    show_debug_panel = false
    village_log_messages.clear()
    close_storage_selector()

    reset_test_inventory()
    reset_research()
    setup_villager_manager()
    spawn_stone_age_wild_animals()

    add_village_log_message("Settlement founded: " + region_name + ".")
    add_village_log_message(
        "Region selected from world origin "
        + str(source_selection_origin.x)
        + ", "
        + str(source_selection_origin.y)
        + "."
    )

    print("Region Seed: ", region_seed)
    print("Region Name: ", region_name)
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
    reset_build_panel_filters()
    setup_building_manager()
    clear_buildings()
    setup_wild_animal_manager()

    if not is_tile_in_bounds(selected_tile):
        selected_tile = Vector2i(-1, -1)

    is_dragging_villager = false
    dragged_villager_id = 0
    drag_assignment_tile = Vector2i(-1, -1)
    simulation_paused = true
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_crafting_panel()
    close_assignment_panel()
    show_village_log_panel = false
    show_debug_panel = false
    village_log_messages.clear()
    close_storage_selector()

    reset_test_inventory()
    reset_research()
    setup_villager_manager()
    spawn_stone_age_wild_animals()

    add_village_log_message("Settlement regenerated: " + region_name + ".")

    print_region_resource_totals()
    print_settlement_inventory()
    print_research_status()
    queue_redraw()

    print("Regenerated region.")


func reset_build_panel_filters() -> void:
    selected_build_age = RegionBuildingData.get_default_build_age()
    selected_build_category = RegionBuildingData.get_default_build_category_for_age(selected_build_age)


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
    setup_villager_manager_for_loaded_save()
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


func update_hunting_jobs(delta: float) -> void:
    var reserved_hunts: Array = wild_animal_manager.get_reserved_hunts_ready_to_check()

    if reserved_hunts.is_empty():
        return

    for hunt_index in range(reserved_hunts.size()):
        var animal_data: Dictionary = reserved_hunts[hunt_index]
        var animal_instance_id: int = int(animal_data.get(RegionWildAnimalManager.KEY_INSTANCE_ID, 0))
        var required_hunters: int = int(animal_data.get(RegionWildAnimalManager.KEY_REQUIRED_HUNTERS, 1))

        if animal_instance_id <= 0:
            continue

        var hunt_status: Dictionary = villager_manager.get_hunt_status_for_animal(
            animal_instance_id,
            required_hunters
        )

        if not bool(hunt_status.get("all_arrived", false)):
            continue

        var average_hunting_skill: float = villager_manager.get_average_hunting_skill_for_animal(
            animal_instance_id
        )

        var countdown_start: Dictionary = wild_animal_manager.start_hunt_countdown_if_needed(
            animal_instance_id,
            average_hunting_skill
        )

        var countdown_start_message: String = str(countdown_start.get("message", ""))

        if countdown_start_message != "":
            add_village_log_message(countdown_start_message)

        var danger_tick_result: Dictionary = wild_animal_manager.update_hunt_danger_tick(
            animal_instance_id,
            delta
        )

        if bool(danger_tick_result.get("tick_due", false)):
            handle_dangerous_hunt_tick(
                animal_instance_id,
                get_dictionary_from_variant(danger_tick_result.get("animal_data", {}))
            )

        var countdown_result: Dictionary = wild_animal_manager.update_hunt_countdown(
            animal_instance_id,
            delta
        )

        if not bool(countdown_result.get("complete", false)):
            queue_redraw()
            continue

        var hunt_result: Dictionary = wild_animal_manager.resolve_hunt_for_animal_instance(
            animal_instance_id
        )

        var hunt_message: String = str(hunt_result.get("message", ""))

        if hunt_message != "":
            add_village_log_message(hunt_message)

        if bool(hunt_result.get("success", false)):
            var hunt_yields: Dictionary = get_dictionary_from_variant(
                hunt_result.get("yields", {})
            )

            if not hunt_yields.is_empty():
                inventory.add_resources(hunt_yields)
                print_settlement_inventory()

            var kill_record_result: Dictionary = wild_animal_manager.record_animal_kill_from_hunt_result(
                hunt_result
            )

            var kill_record_messages: Array = kill_record_result.get("messages", [])

            if not kill_record_messages.is_empty():
                add_village_log_messages(kill_record_messages)

            var animal_event_messages: Array = wild_animal_manager.get_event_messages()

            if not animal_event_messages.is_empty():
                add_village_log_messages(animal_event_messages)

            var party_messages: Array = villager_manager.apply_hunting_result_to_party(
                animal_instance_id,
                bool(hunt_result.get("injury_occurred", false)),
                bool(hunt_result.get("death_occurred", false))
            )

            add_village_log_messages(party_messages)

        villager_manager.send_hunt_party_home(animal_instance_id)
        queue_redraw()


func handle_dangerous_hunt_tick(
    animal_instance_id: int,
    animal_data: Dictionary
) -> void:
    if animal_data.is_empty():
        return

    var tick_result: Dictionary = villager_manager.apply_dangerous_hunt_tick(
        animal_instance_id,
        str(animal_data.get(RegionWildAnimalManager.KEY_NAME, "Wild Animal")),
        animal_data.get(RegionWildAnimalManager.KEY_TILE, Vector2i(-1, -1)),
        float(animal_data.get(RegionWildAnimalManager.KEY_INJURY_CHANCE, 0.0)),
        int(animal_data.get(RegionWildAnimalManager.KEY_HUNT_DAMAGE, 0))
    )

    var tick_messages: Array = tick_result.get("messages", [])

    if not tick_messages.is_empty():
        add_village_log_messages(tick_messages)

    if bool(tick_result.get("no_replacement_available", false)):
        wild_animal_manager.add_time_to_hunt_countdown(
            animal_instance_id,
            CoreTuning.HUNT_NO_REPLACEMENT_TIME_PENALTY
        )

    if bool(tick_result.get("replacement_sent", false)):
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
    show_build_panel = false
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    close_crafting_panel()
    close_assignment_panel()

    building_manager.start_building_placement(building_id)
    queue_redraw()


func cancel_build_mode() -> void:
    building_manager.cancel_build_mode()
    queue_redraw()


func try_place_current_building(origin_tile: Vector2i) -> void:
    close_storage_selector()
    close_assignment_panel()

    var did_place_building: bool = building_manager.try_place_current_building(
        origin_tile,
        inventory,
        item_inventory
    )

    if did_place_building:
        apply_stone_age_building_progression_unlocks()
        relocate_wild_animals_away_from_campfires()
        print_settlement_inventory()
        print_research_status()

    queue_redraw()


func apply_stone_age_building_progression_unlocks() -> void:
    var unlock_messages: Array = RegionStoneAgeProgression.update_building_trigger_unlocks(
        building_manager
    )

    if unlock_messages.is_empty():
        return

    add_village_log_messages(unlock_messages)

    for message_index in range(unlock_messages.size()):
        print(str(unlock_messages[message_index]))


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

        if show_village_log_panel:
            show_debug_panel = false

        queue_redraw()

        print("Show Village Log Panel: ", show_village_log_panel)
        return true

    if get_debug_button_screen_rect().has_point(mouse_screen_position):
        show_debug_panel = not show_debug_panel

        if show_debug_panel:
            show_village_log_panel = false

        queue_redraw()

        print("Show Debug Panel: ", show_debug_panel)
        return true

    if show_debug_panel:
        if try_execute_debug_action_from_mouse(mouse_screen_position):
            return true

        if get_debug_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_village_log_panel:
        if get_village_log_panel_screen_rect().has_point(mouse_screen_position):
            return true

    return false


func try_handle_top_info_panel_click(mouse_screen_position: Vector2) -> bool:
    if get_resources_button_screen_rect().has_point(mouse_screen_position):
        show_resource_inventory_panel = not show_resource_inventory_panel

        if show_resource_inventory_panel:
            show_village_inventory_panel = false
            show_research_panel = false
            show_build_panel = false
            close_crafting_panel()
            close_assignment_panel()

        queue_redraw()

        print("Resources button clicked.")
        print("Show Resource Inventory Panel: ", show_resource_inventory_panel)
        return true

    if get_inventory_button_screen_rect().has_point(mouse_screen_position):
        show_village_inventory_panel = not show_village_inventory_panel

        if show_village_inventory_panel:
            show_resource_inventory_panel = false
            show_research_panel = false
            show_build_panel = false
            close_crafting_panel()
            close_assignment_panel()

        queue_redraw()

        print("Inventory button clicked.")
        print("Show Village Inventory Panel: ", show_village_inventory_panel)
        return true

    if get_research_button_screen_rect().has_point(mouse_screen_position):
        show_research_panel = not show_research_panel

        if show_research_panel:
            show_resource_inventory_panel = false
            show_village_inventory_panel = false
            show_build_panel = false
            close_crafting_panel()
            close_assignment_panel()

        queue_redraw()

        print("Research button clicked.")
        print("Show Research Panel: ", show_research_panel)
        return true

    if get_build_button_screen_rect().has_point(mouse_screen_position):
        show_build_panel = not show_build_panel

        if show_build_panel:
            show_resource_inventory_panel = false
            show_village_inventory_panel = false
            show_research_panel = false
            close_crafting_panel()
            close_assignment_panel()

        queue_redraw()

        print("Build button clicked.")
        print("Show Build Panel: ", show_build_panel)
        return true

    if show_research_panel:
        if try_buy_research_from_mouse(mouse_screen_position):
            return true

        if get_research_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_build_panel:
        if try_select_build_age_from_mouse(mouse_screen_position):
            return true

        if try_select_build_category_from_mouse(mouse_screen_position):
            return true

        if try_start_building_from_mouse(mouse_screen_position):
            return true

        if get_build_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_resource_inventory_panel:
        if get_resource_list_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_village_inventory_panel:
        if get_village_inventory_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_crafting_panel:
        if try_craft_recipe_from_mouse(mouse_screen_position):
            return true

        if get_crafting_panel_screen_rect().has_point(mouse_screen_position):
            return true

    if show_assignment_panel:
        if try_assign_villager_from_assignment_panel(mouse_screen_position):
            return true

        if get_assignment_panel_screen_rect().has_point(mouse_screen_position):
            return true

    return false


func try_select_build_age_from_mouse(mouse_screen_position: Vector2) -> bool:
    if not show_build_panel:
        return false

    var build_ages: Array = RegionBuildingData.get_available_build_ages()

    for age_index in range(build_ages.size()):
        var age_button_rect: Rect2 = get_build_age_button_screen_rect(
            age_index,
            build_ages.size()
        )

        if not age_button_rect.has_point(mouse_screen_position):
            continue

        var age_data: Dictionary = build_ages[age_index]
        var age_id: String = str(age_data.get("id", ""))

        if age_id == "":
            return true

        selected_build_age = age_id
        selected_build_category = RegionBuildingData.get_default_build_category_for_age(
            selected_build_age
        )

        queue_redraw()

        print("Selected build age: ", RegionBuildingData.get_build_age_name(selected_build_age))
        print("Selected build category: ", RegionBuildingData.get_build_category_name(selected_build_category))

        return true

    return false


func try_select_build_category_from_mouse(mouse_screen_position: Vector2) -> bool:
    if not show_build_panel:
        return false

    var build_categories: Array = RegionBuildingData.get_build_categories_for_age(
        selected_build_age
    )

    for category_index in range(build_categories.size()):
        var category_button_rect: Rect2 = get_build_category_button_screen_rect(
            category_index,
            build_categories.size()
        )

        if not category_button_rect.has_point(mouse_screen_position):
            continue

        var category_data: Dictionary = build_categories[category_index]
        var category_id: String = str(category_data.get("id", ""))

        if category_id == "":
            return true

        selected_build_category = category_id

        queue_redraw()

        print("Selected build category: ", RegionBuildingData.get_build_category_name(selected_build_category))

        return true

    return false


func try_start_building_from_mouse(mouse_screen_position: Vector2) -> bool:
    if not show_build_panel:
        return false

    var unlocked_buildings: Array = RegionBuildingData.get_unlocked_buildings_for_age_and_category(
        selected_build_age,
        selected_build_category
    )

    var visible_count: int = min(
        unlocked_buildings.size(),
        RegionUI.get_build_visible_row_count()
    )

    for building_index in range(visible_count):
        var building_button_rect: Rect2 = get_building_button_screen_rect(building_index)

        if not building_button_rect.has_point(mouse_screen_position):
            continue

        var building_data: Dictionary = unlocked_buildings[building_index]
        var building_id: String = str(building_data.get("id", ""))

        if building_id == "":
            return true

        start_building_placement(building_id)
        return true

    return false


func try_execute_debug_action_from_mouse(mouse_screen_position: Vector2) -> bool:
    if not show_debug_panel:
        return false

    var actions: Array = RegionDebugPanel.get_actions()

    for action_index in range(actions.size()):
        var button_rect: Rect2 = get_debug_action_button_screen_rect(action_index)

        if not button_rect.has_point(mouse_screen_position):
            continue

        var action_id: String = RegionDebugPanel.get_action_id_at_index(action_index)
        execute_debug_action(action_id)
        return true

    return false


func execute_debug_action(action_id: String) -> void:
    if action_id == RegionDebugPanel.ACTION_MAX_RESOURCES:
        var changed_count: int = RegionDebugPanel.max_resources(inventory)
        add_village_log_message("Debug: maxed " + str(changed_count) + " resources.")
        print_settlement_inventory()

    elif RegionDebugPanel.is_animal_resource_action(action_id):
        var changed_count: int = RegionDebugPanel.add_animal_resources(inventory)
        add_village_log_message("Debug: added animal resources to " + str(changed_count) + " storage stacks.")
        print_settlement_inventory()

    elif RegionDebugPanel.is_research_action(action_id):
        var research_amount: int = RegionDebugPanel.get_research_amount_for_action(action_id)
        research.add_research(research_amount)
        add_village_log_message("Debug: added " + str(research_amount) + " research.")
        print_research_status()

    elif action_id == RegionDebugPanel.ACTION_ADD_TEST_ITEMS:
        var item_count: int = RegionDebugPanel.add_test_items(item_inventory)
        add_village_log_message("Debug: added " + str(item_count) + " test items.")
        item_inventory.print_inventory()

    elif RegionDebugPanel.is_villager_action(action_id):
        var villager_amount: int = RegionDebugPanel.get_villager_amount_for_action(action_id)
        var normal_housing_capacity: int = building_manager.get_normal_housing_capacity()

        var result: Dictionary = villager_manager.debug_add_villagers(
            villager_amount,
            normal_housing_capacity
        )

        var message: String = str(result.get("message", ""))

        if message != "":
            add_village_log_message(message)

        print("Debug villager add result: ", result)

    elif RegionDebugPanel.is_animal_kill_debug_action(action_id):
        var animal_id: String = RegionDebugPanel.get_animal_kill_debug_animal_id(action_id)
        var kill_amount: int = RegionDebugPanel.get_animal_kill_debug_amount(action_id)

        var kill_result: Dictionary = wild_animal_manager.debug_add_animal_kills(
            animal_id,
            kill_amount
        )

        var kill_messages: Array = kill_result.get("messages", [])

        if not kill_messages.is_empty():
            add_village_log_messages(kill_messages)

        var animal_event_messages: Array = wild_animal_manager.get_event_messages()

        if not animal_event_messages.is_empty():
            add_village_log_messages(animal_event_messages)

    elif RegionDebugPanel.is_show_animal_kill_counts_action(action_id):
        add_village_log_messages(
            wild_animal_manager.debug_get_kill_count_summary()
        )

    elif action_id == RegionDebugPanel.ACTION_CLOSE:
        show_debug_panel = false

    else:
        add_village_log_message("Debug: unknown action.")

    queue_redraw()


func try_craft_recipe_from_mouse(mouse_screen_position: Vector2) -> bool:
    if not show_crafting_panel:
        return false

    var craftable_recipes: Array = crafting.get_craftable_recipes_for_building(
        selected_crafting_building_id,
        research,
        inventory
    )

    var max_rows: int = int(floor(float(RegionUI.CRAFTING_PANEL_HEIGHT - 44) / float(RegionUI.CRAFTING_ROW_HEIGHT)))
    var visible_count: int = min(craftable_recipes.size(), max_rows)

    for recipe_index in range(visible_count):
        var recipe_button_rect: Rect2 = get_crafting_recipe_button_screen_rect(recipe_index)

        if not recipe_button_rect.has_point(mouse_screen_position):
            continue

        var recipe: Dictionary = craftable_recipes[recipe_index]
        var recipe_id: String = str(recipe.get("id", ""))

        craft_recipe(recipe_id)
        return true

    return false


func craft_recipe(recipe_id: String) -> void:
    var result: Dictionary = crafting.craft_recipe_at_building(
        recipe_id,
        selected_crafting_building_id,
        research,
        inventory,
        item_inventory
    )

    var message: String = str(result.get("message", ""))

    if message != "":
        add_village_log_message(message)

    if bool(result.get("success", false)):
        print_settlement_inventory()

    queue_redraw()
    
func try_assign_villager_from_assignment_panel(mouse_screen_position: Vector2) -> bool:
    if not show_assignment_panel:
        return false

    var selected_building: Dictionary = get_selected_assignment_building()

    if selected_building.is_empty():
        close_assignment_panel()
        return false

    var assigned_villagers: Array = selected_building.get("assigned_villagers", [])
    var assignment_slots: int = int(selected_building.get("assignment_slots", 0))

    if assigned_villagers.size() >= assignment_slots:
        return false

    var assignable_villagers: Array = get_assignment_role_filtered_unassigned_villagers(selected_building)
    var visible_count: int = min(
        assignable_villagers.size(),
        RegionUI.get_assignment_visible_row_count()
    )

    for villager_index in range(visible_count):
        var villager_button_rect: Rect2 = get_assignment_villager_button_screen_rect(villager_index)

        if not villager_button_rect.has_point(mouse_screen_position):
            continue

        var villager_data: Dictionary = assignable_villagers[villager_index]
        var villager_id: int = int(villager_data.get("id", 0))

        assign_villager_to_selected_assignment_building(villager_id)
        return true

    return false


func assign_villager_to_selected_assignment_building(villager_id: int) -> void:
    if villager_id <= 0:
        return

    var selected_building: Dictionary = get_selected_assignment_building()

    if selected_building.is_empty():
        add_village_log_message("No assignment building selected.")
        close_assignment_panel()
        queue_redraw()
        return

    var building_instance_id: int = int(selected_building.get("instance_id", 0))
    var assignment_role: String = str(selected_building.get("assignment_role", ""))
    var villager_data: Dictionary = villager_manager.get_villager_data_by_id(villager_id)

    if villager_data.is_empty():
        add_village_log_message("Villager not found.")
        queue_redraw()
        return

    if not is_villager_compatible_with_assignment_role(villager_data, assignment_role):
        var villager_name: String = str(villager_data.get("name", "Villager"))
        var current_role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
        var current_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(current_role)
        var assignment_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assignment_role)

        add_village_log_message(
            villager_name
            + " is a "
            + current_role_name
            + " and cannot be assigned as "
            + assignment_role_name
            + "."
        )

        queue_redraw()
        return

    var building_result: Dictionary = building_manager.assign_villager_to_building(
        villager_id,
        building_instance_id
    )

    var building_message: String = str(building_result.get("message", ""))

    if building_message != "":
        add_village_log_message(building_message)

    if not bool(building_result.get("success", false)):
        queue_redraw()
        return

    var building_role: String = str(building_result.get("role", ""))
    var replaces_shelter: bool = bool(building_result.get("replaces_shelter", false))

    var villager_result: Dictionary = villager_manager.assign_villager_to_building_assignment(
        villager_id,
        building_instance_id,
        building_role,
        replaces_shelter
    )

    var villager_message: String = str(villager_result.get("message", ""))

    if villager_message != "":
        add_village_log_message(villager_message)

    if bool(villager_result.get("success", false)):
        var building_center_tile: Vector2i = building_manager.get_building_center_tile(selected_building)

        villager_manager.set_villager_assigned_work_anchor(
            villager_id,
            building_center_tile,
            VillagerManager.DEFAULT_ASSIGNED_WORK_RADIUS
        )

    var normal_housing_capacity: int = building_manager.get_normal_housing_capacity()
    villager_manager.auto_assign_villager_housing(normal_housing_capacity)

    queue_redraw()


func get_selected_assignment_building() -> Dictionary:
    if selected_assignment_building_instance_id <= 0:
        return {}

    return building_manager.get_building_by_instance_id(
        selected_assignment_building_instance_id
    )


func get_assigned_villager_data_for_building(selected_building: Dictionary) -> Array:
    var assigned_villager_data: Array = []

    if selected_building.is_empty():
        return assigned_villager_data

    var assigned_villager_ids: Array = selected_building.get("assigned_villagers", [])

    for assigned_index in range(assigned_villager_ids.size()):
        var villager_id: int = int(assigned_villager_ids[assigned_index])
        var villager_data: Dictionary = villager_manager.get_villager_data_by_id(villager_id)

        if villager_data.is_empty():
            continue

        assigned_villager_data.append(villager_data)

    return assigned_villager_data


func get_assignment_role_filtered_unassigned_villagers(selected_building: Dictionary) -> Array:
    var filtered_villagers: Array = []

    if selected_building.is_empty():
        return filtered_villagers

    var assignment_role: String = str(selected_building.get("assignment_role", ""))
    var unassigned_villagers: Array = villager_manager.get_unassigned_villagers()

    for villager_index in range(unassigned_villagers.size()):
        var villager_data: Dictionary = unassigned_villagers[villager_index]

        if not is_villager_compatible_with_assignment_role(villager_data, assignment_role):
            continue

        filtered_villagers.append(villager_data)

    return filtered_villagers


func is_villager_compatible_with_assignment_role(
    villager_data: Dictionary,
    assignment_role: String
) -> bool:
    if assignment_role == "":
        return false

    var default_role: String = StoneAgeVillagerAssignmentData.get_default_role()
    var current_role: String = str(villager_data.get("role", default_role))

    if current_role == default_role:
        return true

    return current_role == assignment_role


func get_assignment_hovered_villager(mouse_screen_position: Vector2) -> Dictionary:
    if not show_assignment_panel:
        return {}

    var selected_building: Dictionary = get_selected_assignment_building()

    if selected_building.is_empty():
        return {}

    var assigned_villagers: Array = selected_building.get("assigned_villagers", [])
    var assignment_slots: int = int(selected_building.get("assignment_slots", 0))

    if assigned_villagers.size() >= assignment_slots:
        var assigned_villager_data: Array = get_assigned_villager_data_for_building(selected_building)
        var assigned_visible_count: int = min(
            assigned_villager_data.size(),
            RegionUI.get_assignment_visible_row_count()
        )

        for villager_index in range(assigned_visible_count):
            var villager_button_rect: Rect2 = get_assignment_villager_button_screen_rect(villager_index)

            if not villager_button_rect.has_point(mouse_screen_position):
                continue

            return assigned_villager_data[villager_index]

        return {}

    var assignable_villagers: Array = get_assignment_role_filtered_unassigned_villagers(selected_building)
    var visible_count: int = min(
        assignable_villagers.size(),
        RegionUI.get_assignment_visible_row_count()
    )

    for villager_index in range(visible_count):
        var villager_button_rect: Rect2 = get_assignment_villager_button_screen_rect(villager_index)

        if not villager_button_rect.has_point(mouse_screen_position):
            continue

        return assignable_villagers[villager_index]

    return {}


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


func try_start_hunt_at_hovered_animal() -> bool:
    if not simulation_paused:
        return false

    if not is_tile_in_bounds(hovered_tile):
        return false

    var animal_data: Dictionary = wild_animal_manager.get_animal_at_tile(hovered_tile)

    if animal_data.is_empty():
        return false

    var animal_name: String = str(animal_data.get(RegionWildAnimalManager.KEY_NAME, "Wild Animal"))
    var required_hunters: int = int(animal_data.get(RegionWildAnimalManager.KEY_REQUIRED_HUNTERS, 1))
    var animal_instance_id: int = int(animal_data.get(RegionWildAnimalManager.KEY_INSTANCE_ID, 0))
    var animal_tile: Vector2i = animal_data.get(RegionWildAnimalManager.KEY_TILE, Vector2i(-1, -1))

    if animal_instance_id <= 0:
        add_village_log_message("Could not start hunt. Invalid animal target.")
        return true

    var reserve_result: Dictionary = wild_animal_manager.reserve_animal_for_hunt_at_tile(hovered_tile)

    if not bool(reserve_result.get("success", false)):
        add_village_log_message(str(reserve_result.get("message", "Could not reserve animal for hunting.")))
        queue_redraw()
        return true

    var assign_result: Dictionary = villager_manager.assign_hunters_to_animal_hunt(
        animal_instance_id,
        animal_tile,
        required_hunters
    )

    if not bool(assign_result.get("success", false)):
        wild_animal_manager.clear_hunt_reservation(animal_instance_id)
        add_village_log_message(str(assign_result.get("message", "Could not assign Hunters.")))
        queue_redraw()
        return true

    wild_animal_manager.mark_hunting_party_assigned(animal_instance_id)

    add_village_log_message(
        "Hunt started for "
        + animal_name
        + ". Required Hunters: "
        + str(required_hunters)
        + "."
    )

    add_village_log_message(str(assign_result.get("message", "")))

    queue_redraw()
    return true


func try_start_villager_drag_or_select() -> void:
    if try_start_hunt_at_hovered_animal():
        return

    if storage_selector_open:
        if try_select_storage_resource_from_mouse():
            return

        close_storage_selector()

    if try_open_storage_selector_at_tile(hovered_tile):
        return

    if try_open_assignment_panel_at_tile(hovered_tile):
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
    
func try_open_assignment_panel_at_tile(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var building_data: Dictionary = building_manager.get_building_at_tile(tile_position)

    if building_data.is_empty():
        return false

    if not building_manager.is_assignment_enabled_building(building_data):
        return false

    show_assignment_panel = true
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_crafting_panel()

    selected_assignment_building_instance_id = int(building_data.get("instance_id", 0))

    print("Opened assignment panel for: " + str(building_data.get("name", "Building")))

    queue_redraw()
    return true


func close_assignment_panel() -> void:
    show_assignment_panel = false
    selected_assignment_building_instance_id = 0


func try_open_crafting_panel_at_tile(tile_position: Vector2i) -> bool:
    if not is_tile_in_bounds(tile_position):
        return false

    var building_data: Dictionary = building_manager.get_building_at_tile(tile_position)

    if building_data.is_empty():
        return false

    var building_id: String = str(building_data.get("id", ""))

    if not crafting.building_has_any_recipes(building_id):
        return false

    show_crafting_panel = true
    show_resource_inventory_panel = false
    show_village_inventory_panel = false
    show_research_panel = false
    show_build_panel = false
    close_assignment_panel()

    selected_crafting_building_id = building_id
    selected_crafting_building_name = str(building_data.get("name", building_id))
    selected_crafting_building_instance_id = int(building_data.get("instance_id", 0))

    var known_recipes: Array = crafting.get_all_known_recipes_for_building(
        building_id,
        research
    )

    var craftable_recipes: Array = crafting.get_craftable_recipes_for_building(
        building_id,
        research,
        inventory
    )

    print("Opened crafting panel for: " + selected_crafting_building_name)
    print("Known recipes: ", known_recipes.size())
    print("Craftable recipes: ", craftable_recipes.size())

    if known_recipes.is_empty():
        add_village_log_message(
            selected_crafting_building_name
            + ": no known recipes yet. Research more plans."
        )
    elif craftable_recipes.is_empty():
        add_village_log_message(
            selected_crafting_building_name
            + ": known recipes exist, but none are affordable right now."
        )

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
        wild_animal_manager.get_active_animals(),
        hovered_tile,
        selected_tile,
        is_dragging_villager,
        drag_assignment_tile,
        HARVEST_ASSIGN_RADIUS,
        simulation_paused
    )

    draw_storage_selector()
    draw_top_info_panel()
    draw_build_button()
    draw_resource_inventory_panel()
    draw_village_inventory_panel()
    draw_research_panel()
    draw_build_panel()
    draw_crafting_panel()
    draw_assignment_panel()
    draw_village_log_button()
    draw_debug_button()
    draw_village_log_panel()
    draw_debug_panel()
    draw_paused_villager_hover_panel()


func draw_storage_selector() -> void:
    RegionDraw.draw_storage_selector(
        self,
        storage_selector_open,
        get_storage_selector_world_position(),
        storage_selector_options,
        STORAGE_SELECTOR_BUTTON_WIDTH,
        STORAGE_SELECTOR_BUTTON_HEIGHT,
        STORAGE_SELECTOR_BUTTON_GAP
    )


func draw_top_info_panel() -> void:
    var normal_housing_capacity: int = building_manager.get_normal_housing_capacity()
    var normal_shelter_demand: int = villager_manager.get_normal_shelter_demand_count()
    var available_shelter: int = max(
        0,
        normal_housing_capacity - normal_shelter_demand
    )

    RegionDraw.draw_top_info_panel(
        self,
        research.get_research_points(),
        villager_manager.get_population_count(),
        available_shelter,
        show_resource_inventory_panel,
        show_village_inventory_panel,
        show_research_panel
    )


func draw_resources_button() -> void:
    RegionDraw.draw_resources_button(
        self,
        show_resource_inventory_panel
    )


func draw_inventory_button() -> void:
    RegionDraw.draw_inventory_button(
        self,
        show_village_inventory_panel
    )


func draw_research_button() -> void:
    RegionDraw.draw_research_button(
        self,
        show_research_panel
    )


func draw_build_button() -> void:
    RegionDraw.draw_build_button(
        self,
        show_build_panel
    )


func draw_resource_inventory_panel() -> void:
    if not show_resource_inventory_panel:
        return

    var visible_resources: Array = get_visible_inventory_resource_names()
    var resource_amounts: Dictionary = {}
    var resource_caps: Dictionary = {}

    for resource_index in range(visible_resources.size()):
        var resource_name: String = str(visible_resources[resource_index])

        resource_amounts[resource_name] = inventory.get_amount(resource_name)
        resource_caps[resource_name] = inventory.get_resource_cap(resource_name)

    RegionDraw.draw_resource_inventory_panel(
        self,
        visible_resources,
        resource_amounts,
        resource_caps
    )


func draw_village_inventory_panel() -> void:
    if not show_village_inventory_panel:
        return

    RegionDraw.draw_village_inventory_panel(
        self,
        item_inventory.get_visible_items()
    )


func draw_research_panel() -> void:
    if not show_research_panel:
        return

    var buyable_plans: Array = research.get_buyable_research_plans(
        building_manager,
        inventory
    )

    RegionDraw.draw_research_panel(
        self,
        buyable_plans
    )


func draw_build_panel() -> void:
    if not show_build_panel:
        return

    var build_ages: Array = RegionBuildingData.get_available_build_ages()
    var build_categories: Array = RegionBuildingData.get_build_categories_for_age(
        selected_build_age
    )
    var filtered_buildings: Array = RegionBuildingData.get_unlocked_buildings_for_age_and_category(
        selected_build_age,
        selected_build_category
    )

    RegionDraw.draw_build_panel(
        self,
        build_ages,
        selected_build_age,
        build_categories,
        selected_build_category,
        filtered_buildings
    )


func draw_crafting_panel() -> void:
    if not show_crafting_panel:
        return

    var craftable_recipes: Array = crafting.get_craftable_recipes_for_building(
        selected_crafting_building_id,
        research,
        inventory
    )

    RegionDraw.draw_crafting_panel(
        self,
        selected_crafting_building_name,
        selected_crafting_building_id,
        craftable_recipes,
        crafting
    )


func draw_assignment_panel() -> void:
    if not show_assignment_panel:
        return

    var selected_building: Dictionary = get_selected_assignment_building()
    var assigned_villager_data: Array = get_assigned_villager_data_for_building(selected_building)
    var assignable_villagers: Array = get_assignment_role_filtered_unassigned_villagers(selected_building)

    RegionDraw.draw_assignment_panel(
        self,
        selected_building,
        assigned_villager_data,
        assignable_villagers
    )


func draw_village_log_button() -> void:
    RegionDraw.draw_village_log_button(
        self,
        show_village_log_panel
    )


func draw_debug_button() -> void:
    RegionDraw.draw_debug_button(
        self,
        show_debug_panel
    )


func draw_village_log_panel() -> void:
    RegionDraw.draw_village_log_panel(
        self,
        show_village_log_panel,
        village_log_messages
    )


func draw_debug_panel() -> void:
    RegionDraw.draw_debug_panel(
        self,
        show_debug_panel
    )


func draw_paused_villager_hover_panel() -> void:
    if not simulation_paused:
        return

    if is_dragging_villager:
        return

    var grave_data: Dictionary = villager_manager.get_dead_villager_at_tile(hovered_tile)

    if not grave_data.is_empty():
        draw_grave_hover_panel(grave_data)
        return

    var animal_data: Dictionary = wild_animal_manager.get_animal_at_tile(hovered_tile)

    if not animal_data.is_empty():
        draw_wild_animal_hover_panel(animal_data)
        return

    var mouse_screen_position: Vector2 = get_viewport().get_mouse_position()
    var assignment_hover_villager: Dictionary = get_assignment_hovered_villager(mouse_screen_position)

    if not assignment_hover_villager.is_empty():
        draw_villager_hover_panel(assignment_hover_villager)
        return

    var mouse_world_position: Vector2 = get_global_mouse_position()
    var villager_data: Dictionary = villager_manager.get_villager_data_at_world_position(
        mouse_world_position,
        VILLAGER_DRAG_HIT_RADIUS
    )

    if villager_data.is_empty():
        return

    draw_villager_hover_panel(villager_data)


func draw_grave_hover_panel(villager_data: Dictionary) -> void:
    RegionDraw.draw_grave_hover_panel(
        self,
        villager_data
    )


func draw_wild_animal_hover_panel(animal_data: Dictionary) -> void:
    RegionDraw.draw_wild_animal_hover_panel(
        self,
        animal_data
    )


func draw_villager_hover_panel(villager_data: Dictionary) -> void:
    RegionDraw.draw_villager_hover_panel(
        self,
        villager_data
    )


func draw_villager_hover_panel_text(
    villager_data: Dictionary,
    panel_screen_rect: Rect2
) -> void:
    RegionDraw.draw_villager_hover_panel_text(
        self,
        villager_data,
        panel_screen_rect
    )


func draw_villager_skill_line(
    skill_label: String,
    skill_value: int,
    text_x: float,
    text_y: float,
    font_size: int
) -> void:
    RegionDraw.draw_villager_skill_line(
        self,
        skill_label,
        skill_value,
        text_x,
        text_y,
        font_size
    )


func get_top_info_panel_screen_rect() -> Rect2:
    return RegionUI.get_top_info_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_resources_button_screen_rect() -> Rect2:
    return RegionUI.get_resources_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_inventory_button_screen_rect() -> Rect2:
    return RegionUI.get_inventory_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_research_button_screen_rect() -> Rect2:
    return RegionUI.get_research_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_build_button_screen_rect() -> Rect2:
    return RegionUI.get_build_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_resource_list_panel_screen_rect() -> Rect2:
    var visible_resources: Array = get_visible_inventory_resource_names()

    return RegionUI.get_resource_list_panel_screen_rect(
        get_viewport().get_visible_rect().size,
        visible_resources.size()
    )


func get_village_inventory_panel_screen_rect() -> Rect2:
    return RegionUI.get_village_inventory_panel_screen_rect(
        get_viewport().get_visible_rect().size,
        item_inventory.get_visible_items().size()
    )


func get_research_panel_screen_rect() -> Rect2:
    return RegionUI.get_research_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_research_plan_button_screen_rect(plan_index: int) -> Rect2:
    return RegionUI.get_research_plan_button_screen_rect(
        get_viewport().get_visible_rect().size,
        plan_index
    )


func get_build_panel_screen_rect() -> Rect2:
    return RegionUI.get_build_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_build_age_button_screen_rect(
    age_index: int,
    age_count: int
) -> Rect2:
    return RegionUI.get_build_age_button_screen_rect(
        get_viewport().get_visible_rect().size,
        age_index,
        age_count
    )


func get_build_category_button_screen_rect(
    category_index: int,
    category_count: int
) -> Rect2:
    return RegionUI.get_build_category_button_screen_rect(
        get_viewport().get_visible_rect().size,
        category_index,
        category_count
    )


func get_building_button_screen_rect(building_index: int) -> Rect2:
    return RegionUI.get_building_button_screen_rect(
        get_viewport().get_visible_rect().size,
        building_index
    )


func get_crafting_panel_screen_rect() -> Rect2:
    return RegionUI.get_crafting_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_crafting_recipe_button_screen_rect(recipe_index: int) -> Rect2:
    return RegionUI.get_crafting_recipe_button_screen_rect(
        get_viewport().get_visible_rect().size,
        recipe_index
    )


func get_assignment_panel_screen_rect() -> Rect2:
    return RegionUI.get_assignment_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_assignment_villager_button_screen_rect(villager_index: int) -> Rect2:
    return RegionUI.get_assignment_villager_button_screen_rect(
        get_viewport().get_visible_rect().size,
        villager_index
    )


func get_village_log_button_screen_rect() -> Rect2:
    return RegionUI.get_village_log_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_village_log_panel_screen_rect() -> Rect2:
    return RegionUI.get_village_log_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_debug_button_screen_rect() -> Rect2:
    return RegionUI.get_debug_button_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_debug_panel_screen_rect() -> Rect2:
    return RegionUI.get_debug_panel_screen_rect(
        get_viewport().get_visible_rect().size
    )


func get_debug_action_button_screen_rect(action_index: int) -> Rect2:
    return RegionUI.get_debug_action_button_screen_rect(
        get_viewport().get_visible_rect().size,
        action_index
    )


func screen_rect_to_world_rect(screen_rect: Rect2) -> Rect2:
    return RegionUI.screen_rect_to_world_rect(
        self,
        screen_rect
    )


func screen_position_to_world_position(screen_position: Vector2) -> Vector2:
    return RegionUI.screen_position_to_world_position(
        self,
        screen_position
    )


func get_world_per_screen_y() -> float:
    return RegionUI.get_world_per_screen_y(self)


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

func get_animal_kill_count_for_hover(animal_id: String) -> int:
    if animal_id == "":
        return 0

    return wild_animal_manager.get_animal_kill_count(animal_id)

func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < REGION_WIDTH
        and tile_position.y < REGION_HEIGHT
    )
