extends Node2D

const GAME_MODE_MAIN_MENU: String = "main_menu"
const GAME_MODE_WORLD_PREVIEW: String = "world_preview"
const GAME_MODE_WORLD: String = "world"
const GAME_MODE_REGION_CONFIRM: String = "region_confirm"
const GAME_MODE_REGION: String = "region"
const GAME_MODE_PAUSED: String = "paused"

const DEFAULT_WORLD_NAME: String = "New World"

const AUTOSAVE_INTERVAL_SECONDS: float = 600.0

@onready var world: Node2D = $World
@onready var region: Node2D = $Region
@onready var main_camera: Camera2D = $MainCamera
@onready var ui: CanvasLayer = $UI

var game_mode: String = GAME_MODE_MAIN_MENU
var previous_game_mode: String = GAME_MODE_MAIN_MENU

var pending_selected_world_tiles: Array = []
var pending_source_world_seed: int = 0
var pending_selection_origin: Vector2i = Vector2i(-1, -1)
var pending_source_resource_totals: Dictionary = {}
var current_region_name: String = ""

var autosave_timer: float = 0.0
var autosave_index: int = 0


func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

    if world.has_signal("region_requested"):
        world.connect("region_requested", Callable(self, "_on_world_region_requested"))

    if region.has_signal("return_to_world_requested"):
        region.connect("return_to_world_requested", Callable(self, "_on_region_return_to_world_requested"))

    connect_ui_signals()
    enter_main_menu_mode()


func _process(delta: float) -> void:
    update_autosave(delta)


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        if game_mode == GAME_MODE_REGION:
            enter_pause_mode()
            get_viewport().set_input_as_handled()
            return

        if game_mode == GAME_MODE_PAUSED:
            resume_from_pause()
            get_viewport().set_input_as_handled()
            return

        if game_mode == GAME_MODE_REGION_CONFIRM:
            cancel_region_start_confirmation()
            get_viewport().set_input_as_handled()
            return


func connect_ui_signals() -> void:
    if ui == null:
        push_warning("UI node was not found.")
        return

    if ui.has_signal("main_menu_new_game_requested"):
        ui.connect("main_menu_new_game_requested", Callable(self, "_on_main_menu_new_game_requested"))

    if ui.has_signal("main_menu_load_game_requested"):
        ui.connect("main_menu_load_game_requested", Callable(self, "_on_main_menu_load_game_requested"))

    if ui.has_signal("main_menu_options_requested"):
        ui.connect("main_menu_options_requested", Callable(self, "_on_main_menu_options_requested"))

    if ui.has_signal("main_menu_close_application_requested"):
       ui.connect("main_menu_close_application_requested", Callable(self, "_on_main_menu_close_application_requested"))
    
    if ui.has_signal("debug_action_requested"):
        ui.connect("debug_action_requested", Callable(self, "_on_debug_action_requested"))

    if ui.has_signal("world_preview_reroll_requested"):
        ui.connect("world_preview_reroll_requested", Callable(self, "_on_world_preview_reroll_requested"))

    if ui.has_signal("world_preview_confirm_requested"):
        ui.connect("world_preview_confirm_requested", Callable(self, "_on_world_preview_confirm_requested"))

    if ui.has_signal("world_preview_back_requested"):
        ui.connect("world_preview_back_requested", Callable(self, "_on_world_preview_back_requested"))

    if ui.has_signal("region_start_confirm_requested"):
        ui.connect("region_start_confirm_requested", Callable(self, "_on_region_start_confirm_requested"))

    if ui.has_signal("region_start_cancel_requested"):
        ui.connect("region_start_cancel_requested", Callable(self, "_on_region_start_cancel_requested"))

    if ui.has_signal("pause_resume_requested"):
        ui.connect("pause_resume_requested", Callable(self, "_on_pause_resume_requested"))

    if ui.has_signal("pause_save_requested"):
        ui.connect("pause_save_requested", Callable(self, "_on_pause_save_requested"))

    if ui.has_signal("pause_load_requested"):
        ui.connect("pause_load_requested", Callable(self, "_on_pause_load_requested"))

    if ui.has_signal("pause_return_to_main_requested"):
        ui.connect("pause_return_to_main_requested", Callable(self, "_on_pause_return_to_main_requested"))
        
    if ui.has_signal("pause_close_application_requested"):
       ui.connect("pause_close_application_requested", Callable(self, "_on_pause_close_application_requested"))

    if ui.has_signal("load_save_file_requested"):
        ui.connect("load_save_file_requested", Callable(self, "_on_load_save_file_requested"))

    if ui.has_signal("delete_save_file_requested"):
        ui.connect("delete_save_file_requested", Callable(self, "_on_delete_save_file_requested"))

    if ui.has_signal("load_save_back_requested"):
        ui.connect("load_save_back_requested", Callable(self, "_on_load_save_back_requested"))


func enter_main_menu_mode() -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_MAIN_MENU
    previous_game_mode = GAME_MODE_MAIN_MENU

    clear_pending_region_selection()

    world.visible = false
    region.visible = false

    if world.has_method("deactivate"):
        world.call("deactivate")

    if region.has_method("deactivate"):
        region.call("deactivate")

    if ui != null:
        if ui.has_method("show_main_menu"):
            ui.call("show_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_region_start_panel"):
            ui.call("hide_region_start_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)


func enter_world_preview_mode() -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_WORLD_PREVIEW
    previous_game_mode = GAME_MODE_WORLD_PREVIEW

    clear_pending_region_selection()

    world.visible = true
    region.visible = false

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("show_world_preview_panel"):
            ui.call("show_world_preview_panel")

        if ui.has_method("hide_region_start_panel"):
            ui.call("hide_region_start_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)

    if world.has_method("activate"):
        world.call("activate")

    if world.has_method("start_world_preview"):
        world.call("start_world_preview")

    if region.has_method("deactivate"):
        region.call("deactivate")

    if world.has_method("get_map_center"):
        main_camera.position = world.call("get_map_center")


func enter_world_mode() -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_WORLD
    previous_game_mode = GAME_MODE_WORLD

    world.visible = true
    region.visible = false

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_region_start_panel"):
            ui.call("hide_region_start_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)

    if world.has_method("activate"):
        world.call("activate")

    if world.has_method("enter_region_selection_mode"):
        world.call("enter_region_selection_mode")

    if region.has_method("deactivate"):
        region.call("deactivate")

    if world.has_method("get_map_center"):
        main_camera.position = world.call("get_map_center")


func enter_region_start_confirmation_mode(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_REGION_CONFIRM
    previous_game_mode = GAME_MODE_WORLD

    pending_selected_world_tiles = selected_world_tiles.duplicate(true)
    pending_source_world_seed = source_world_seed
    pending_selection_origin = selection_origin
    pending_source_resource_totals = source_resource_totals.duplicate(true)

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)

        if ui.has_method("show_region_start_panel"):
            ui.call("show_region_start_panel", get_default_region_name())


func enter_region_mode(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary,
    region_name: String = ""
) -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_REGION
    previous_game_mode = GAME_MODE_REGION
    autosave_timer = 0.0
    autosave_index = 0

    current_region_name = region_name.strip_edges()

    if current_region_name == "":
        current_region_name = get_default_region_name()

    world.visible = false
    region.visible = true

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_region_start_panel"):
            ui.call("hide_region_start_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", true)

    if world.has_method("deactivate"):
        world.call("deactivate")

    if region.has_method("activate"):
        region.call("activate")

    if region.has_method("set_region_name"):
        region.call("set_region_name", current_region_name)

    if region.has_method("generate_from_world_selection"):
        region.call(
            "generate_from_world_selection",
            selected_world_tiles,
            source_world_seed,
            selection_origin,
            source_resource_totals
        )

    if region.has_method("get_map_center"):
        main_camera.position = region.call("get_map_center")


func enter_pause_mode() -> void:
    if game_mode != GAME_MODE_REGION:
        return

    previous_game_mode = game_mode
    game_mode = GAME_MODE_PAUSED
    get_tree().paused = true

    if ui != null:
        if ui.has_method("show_pause_menu"):
            ui.call("show_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)


func resume_from_pause() -> void:
    if game_mode != GAME_MODE_PAUSED:
        return

    game_mode = previous_game_mode
    get_tree().paused = false

    if ui != null:
        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", game_mode == GAME_MODE_REGION)


func confirm_pending_region_start(region_name: String) -> void:
    if pending_selected_world_tiles.is_empty():
        print("No pending region selection to start.")
        enter_world_mode()
        return

    enter_region_mode(
        pending_selected_world_tiles,
        pending_source_world_seed,
        pending_selection_origin,
        pending_source_resource_totals,
        region_name
    )


func cancel_region_start_confirmation() -> void:
    clear_pending_region_selection()

    if ui != null and ui.has_method("hide_region_start_panel"):
        ui.call("hide_region_start_panel")

    enter_world_mode()


func clear_pending_region_selection() -> void:
    pending_selected_world_tiles.clear()
    pending_source_world_seed = 0
    pending_selection_origin = Vector2i(-1, -1)
    pending_source_resource_totals.clear()


func get_default_region_name() -> String:
    if pending_selection_origin.x >= 0 and pending_selection_origin.y >= 0:
        return "Settlement " + str(pending_selection_origin.x) + "-" + str(pending_selection_origin.y)

    return "New Settlement"


func get_current_region_name() -> String:
    if region != null and region.has_method("get_region_name"):
        var region_name_from_node: String = str(region.call("get_region_name")).strip_edges()

        if region_name_from_node != "":
            return region_name_from_node

    if current_region_name.strip_edges() != "":
        return current_region_name.strip_edges()

    return "New Settlement"


func get_save_name() -> String:
    var region_name: String = get_current_region_name()

    if region_name == "":
        region_name = "New Settlement"

    return region_name


func build_current_save_data() -> Dictionary:
    var world_data: Dictionary = build_current_world_save_data()
    var region_data: Dictionary = build_current_region_save_data()

    return SaveManager.build_base_save_data(
        get_save_name(),
        DEFAULT_WORLD_NAME,
        get_current_region_name(),
        world_data,
        region_data
    )


func build_current_world_save_data() -> Dictionary:
    var world_seed: int = 0

    if world != null:
        world_seed = int(world.get("world_seed"))

    return {
        "world_name": DEFAULT_WORLD_NAME,
        "world_seed": world_seed,
        "game_mode": game_mode,
        "previous_game_mode": previous_game_mode
    }


func build_current_region_save_data() -> Dictionary:
    if region != null and region.has_method("get_save_data"):
        var region_save_data: Variant = region.call("get_save_data")

        if typeof(region_save_data) == TYPE_DICTIONARY:
            return region_save_data

    return {
        "region_name": get_current_region_name(),
        "region_seed": 0,
        "source_world_seed": 0,
        "source_selection_origin": vector2i_to_save_dict(Vector2i(-1, -1)),
        "source_world_resource_totals": {},
        "source_world_tiles": [],
        "simulation_paused": true
    }


func vector2i_to_save_dict(value: Vector2i) -> Dictionary:
    return {
        "x": value.x,
        "y": value.y
    }


func update_autosave(delta: float) -> void:
    if game_mode != GAME_MODE_REGION:
        return

    if get_tree().paused:
        return

    autosave_timer += delta

    if autosave_timer < AUTOSAVE_INTERVAL_SECONDS:
        return

    autosave_timer = 0.0
    autosave_current_game()


func autosave_current_game() -> void:
    if game_mode != GAME_MODE_REGION:
        return

    autosave_index += 1

    var save_data: Dictionary = build_current_save_data()
    var result: Dictionary = SaveManager.write_autosave(
        get_current_region_name(),
        autosave_index,
        save_data
    )

    var message: String = str(result.get("message", "Autosave complete."))
    print(message)

    if region != null and region.has_method("add_village_log_message"):
        region.call("add_village_log_message", "Autosave complete.")


func save_current_game() -> void:
    if game_mode != GAME_MODE_REGION and game_mode != GAME_MODE_PAUSED:
        print("Save Game requested, but no active region is running.")
        return

    var save_data: Dictionary = build_current_save_data()
    var result: Dictionary = SaveManager.write_save(get_save_name(), save_data)

    var message: String = str(result.get("message", "Save complete."))
    print(message)

    if region != null and region.has_method("add_village_log_message"):
        region.call("add_village_log_message", message)


func load_most_recent_game() -> void:
    var result: Dictionary = SaveManager.read_most_recent_save()

    if not bool(result.get("success", false)):
        print(str(result.get("message", "Load failed.")))
        return

    var save_data_variant: Variant = result.get("data", {})

    if typeof(save_data_variant) != TYPE_DICTIONARY:
        print("Load failed. Save data was not a dictionary.")
        return

    var save_data: Dictionary = save_data_variant
    apply_loaded_save_data(save_data)

    print(str(result.get("message", "Loaded save.")))


func show_load_game_selection(opened_from_pause: bool = false) -> void:
    var save_infos: Array = SaveManager.list_save_file_infos()

    if ui != null and ui.has_method("show_load_game_panel"):
        ui.call("show_load_game_panel", save_infos, opened_from_pause)
        return

    print("Load panel is not available. Loading most recent save instead.")
    load_most_recent_game()


func refresh_load_game_selection() -> void:
    var save_infos: Array = SaveManager.list_save_file_infos()

    if ui != null and ui.has_method("show_load_game_panel"):
        ui.call("show_load_game_panel", save_infos, game_mode == GAME_MODE_PAUSED)


func load_save_file(save_file_name: String) -> void:
    if save_file_name.strip_edges() == "":
        print("Load failed. Empty save file name.")
        return

    var save_path: String = SaveManager.get_save_path_from_file_name(save_file_name)
    var result: Dictionary = SaveManager.read_save_from_path(save_path)

    if not bool(result.get("success", false)):
        print(str(result.get("message", "Load failed.")))
        return

    var save_data_variant: Variant = result.get("data", {})

    if typeof(save_data_variant) != TYPE_DICTIONARY:
        print("Load failed. Save data was not a dictionary.")
        return

    var save_data: Dictionary = save_data_variant
    apply_loaded_save_data(save_data)

    print(str(result.get("message", "Loaded save.")))


func delete_save_file(save_file_name: String) -> void:
    var result: Dictionary = SaveManager.delete_save_file(save_file_name)
    var message: String = str(result.get("message", "Delete save finished."))

    print(message)

    if not bool(result.get("success", false)):
        return

    refresh_load_game_selection()


func apply_loaded_save_data(save_data: Dictionary) -> void:
    var region_data_variant: Variant = save_data.get(SaveManager.KEY_REGION_DATA, {})

    if typeof(region_data_variant) != TYPE_DICTIONARY:
        print("Load failed. Save had no valid region_data.")
        return

    var region_data: Dictionary = region_data_variant

    get_tree().paused = false
    game_mode = GAME_MODE_REGION
    previous_game_mode = GAME_MODE_REGION
    autosave_timer = 0.0
    world.visible = false
    region.visible = true

    clear_pending_region_selection()

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_region_start_panel"):
            ui.call("hide_region_start_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("hide_load_game_panel"):
            ui.call("hide_load_game_panel")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", true)

    if world.has_method("deactivate"):
        world.call("deactivate")

    if region.has_method("activate"):
        region.call("activate")

    if region.has_method("load_save_data"):
        region.call("load_save_data", region_data)
    else:
        print("Load failed. Region does not have load_save_data().")
        return

    current_region_name = get_current_region_name()

    if region.has_method("get_map_center"):
        main_camera.position = region.call("get_map_center")

    print("Loaded game: " + current_region_name)


func _on_world_region_requested(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    enter_region_start_confirmation_mode(
        selected_world_tiles,
        source_world_seed,
        selection_origin,
        source_resource_totals
    )


func _on_region_return_to_world_requested() -> void:
    enter_world_mode()


func _on_main_menu_new_game_requested() -> void:
    enter_world_preview_mode()


func _on_main_menu_load_game_requested() -> void:
    show_load_game_selection(false)


func _on_main_menu_options_requested() -> void:
    if ui != null and ui.has_method("show_options_panel"):
        ui.call("show_options_panel")
        return

    print("Options requested, but Options panel is not available.")
    
func _on_main_menu_close_application_requested() -> void:
    get_tree().quit()


func _on_debug_action_requested(action_id: String) -> void:
    if action_id == "":
        return

    if region != null and region.has_method("execute_debug_action"):
        region.call("execute_debug_action", action_id)
        return

    print("Debug action requested, but Region cannot execute debug actions: " + action_id)


func _on_world_preview_reroll_requested() -> void:
    if world.has_method("reroll_preview_world"):
        world.call("reroll_preview_world")


func _on_world_preview_confirm_requested() -> void:
    if world.has_method("confirm_world_generation"):
        world.call("confirm_world_generation")

    enter_world_mode()


func _on_world_preview_back_requested() -> void:
    enter_main_menu_mode()


func _on_region_start_confirm_requested(region_name: String) -> void:
    confirm_pending_region_start(region_name)


func _on_region_start_cancel_requested() -> void:
    cancel_region_start_confirmation()


func _on_pause_resume_requested() -> void:
    resume_from_pause()


func _on_pause_save_requested() -> void:
    save_current_game()


func _on_pause_load_requested() -> void:
    show_load_game_selection(true)


func _on_pause_return_to_main_requested() -> void:
    enter_main_menu_mode()

func _on_pause_close_application_requested() -> void:
    get_tree().quit()

func _on_load_save_file_requested(save_file_name: String) -> void:
    load_save_file(save_file_name)


func _on_delete_save_file_requested(save_file_name: String) -> void:
    delete_save_file(save_file_name)


func _on_load_save_back_requested() -> void:
    pass
