extends Node2D

const GAME_MODE_MAIN_MENU: String = "main_menu"
const GAME_MODE_WORLD_PREVIEW: String = "world_preview"
const GAME_MODE_WORLD: String = "world"
const GAME_MODE_REGION: String = "region"
const GAME_MODE_PAUSED: String = "paused"

@onready var world: Node2D = $World
@onready var region: Node2D = $Region
@onready var main_camera: Camera2D = $MainCamera
@onready var ui: CanvasLayer = $UI

var game_mode: String = GAME_MODE_MAIN_MENU
var previous_game_mode: String = GAME_MODE_MAIN_MENU


func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

    if world.has_signal("region_requested"):
        world.connect("region_requested", Callable(self, "_on_world_region_requested"))

    if region.has_signal("return_to_world_requested"):
        region.connect("return_to_world_requested", Callable(self, "_on_region_return_to_world_requested"))

    connect_ui_signals()
    enter_main_menu_mode()


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

    if ui.has_signal("world_preview_reroll_requested"):
        ui.connect("world_preview_reroll_requested", Callable(self, "_on_world_preview_reroll_requested"))

    if ui.has_signal("world_preview_confirm_requested"):
        ui.connect("world_preview_confirm_requested", Callable(self, "_on_world_preview_confirm_requested"))

    if ui.has_signal("world_preview_back_requested"):
        ui.connect("world_preview_back_requested", Callable(self, "_on_world_preview_back_requested"))

    if ui.has_signal("pause_resume_requested"):
        ui.connect("pause_resume_requested", Callable(self, "_on_pause_resume_requested"))

    if ui.has_signal("pause_save_requested"):
        ui.connect("pause_save_requested", Callable(self, "_on_pause_save_requested"))

    if ui.has_signal("pause_load_requested"):
        ui.connect("pause_load_requested", Callable(self, "_on_pause_load_requested"))

    if ui.has_signal("pause_return_to_main_requested"):
        ui.connect("pause_return_to_main_requested", Callable(self, "_on_pause_return_to_main_requested"))


func enter_main_menu_mode() -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_MAIN_MENU
    previous_game_mode = GAME_MODE_MAIN_MENU

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

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", false)


func enter_world_preview_mode() -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_WORLD_PREVIEW
    previous_game_mode = GAME_MODE_WORLD_PREVIEW

    world.visible = true
    region.visible = false

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("show_world_preview_panel"):
            ui.call("show_world_preview_panel")

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


func enter_region_mode(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    get_tree().paused = false
    game_mode = GAME_MODE_REGION
    previous_game_mode = GAME_MODE_REGION

    world.visible = false
    region.visible = true

    if ui != null:
        if ui.has_method("hide_main_menu"):
            ui.call("hide_main_menu")

        if ui.has_method("hide_world_preview_panel"):
            ui.call("hide_world_preview_panel")

        if ui.has_method("hide_pause_menu"):
            ui.call("hide_pause_menu")

        if ui.has_method("set_build_ui_enabled"):
            ui.call("set_build_ui_enabled", true)

    if world.has_method("deactivate"):
        world.call("deactivate")

    if region.has_method("activate"):
        region.call("activate")

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


func _on_world_region_requested(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    enter_region_mode(
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
    print("Load Game requested. Save/load system is not implemented yet.")


func _on_main_menu_options_requested() -> void:
    print("Options requested. Options menu is not implemented yet.")


func _on_world_preview_reroll_requested() -> void:
    if world.has_method("reroll_preview_world"):
        world.call("reroll_preview_world")


func _on_world_preview_confirm_requested() -> void:
    if world.has_method("confirm_world_generation"):
        world.call("confirm_world_generation")

    enter_world_mode()


func _on_world_preview_back_requested() -> void:
    enter_main_menu_mode()


func _on_pause_resume_requested() -> void:
    resume_from_pause()


func _on_pause_save_requested() -> void:
    print("Save Game requested. Save/load system is not implemented yet.")


func _on_pause_load_requested() -> void:
    print("Load Game requested from pause menu. Save/load system is not implemented yet.")


func _on_pause_return_to_main_requested() -> void:
    enter_main_menu_mode()
