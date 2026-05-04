extends CanvasLayer

#  MainUi

signal main_menu_new_game_requested
signal main_menu_load_game_requested
signal main_menu_options_requested
signal main_menu_close_application_requested

signal debug_action_requested(action_id: String)
signal debug_mode_changed(is_enabled: bool)

signal load_save_file_requested(save_file_name: String)
signal delete_save_file_requested(save_file_name: String)
signal load_save_back_requested

signal world_preview_reroll_requested
signal world_preview_confirm_requested
signal world_preview_back_requested

signal region_start_confirm_requested(region_name: String)
signal region_start_cancel_requested

signal pause_resume_requested
signal pause_save_requested
signal pause_load_requested
signal pause_return_to_main_requested
signal pause_close_application_requested

@onready var build_button: Button = get_node_or_null("BuildButton")
@onready var build_menu: Panel = get_node_or_null("BuildMenu")
@onready var campfire_button: Button = get_node_or_null("BuildMenu/CampfireButton")
@onready var region: Node2D = get_node_or_null("../Region")

var main_menu_panel: Panel = null
var world_preview_panel: Panel = null
var region_start_panel: Panel = null
var region_name_input: LineEdit = null
var pause_menu_panel: Panel = null

var options_panel: Panel = null
var debug_mode_checkbox: CheckBox = null
var debug_tools_panel: Panel = null
var pause_debug_tools_button: Button = null
var pause_return_to_main_button: Button = null

var load_game_panel: Panel = null
var load_game_opened_from_pause: bool = false

var confirm_load_panel: Panel = null
var pending_load_save_file_name: String = ""
var pending_load_save_label: String = ""

var confirm_delete_panel: Panel = null
var pending_delete_save_file_name: String = ""
var pending_delete_save_label: String = ""

var generated_build_buttons: Array = []
var generated_age_buttons: Array = []
var generated_main_menu_buttons: Array = []
var generated_world_preview_buttons: Array = []
var generated_region_start_buttons: Array = []
var generated_pause_menu_buttons: Array = []
var generated_options_buttons: Array = []
var generated_debug_tool_buttons: Array = []
var generated_load_save_buttons: Array = []
var generated_confirm_load_buttons: Array = []
var generated_confirm_delete_buttons: Array = []

var selected_build_age: String = ""
var build_ui_enabled: bool = false
var debug_mode_enabled: bool = false


func _ready() -> void:
    print("MAIN UI SCRIPT RUNNING")

    process_mode = Node.PROCESS_MODE_ALWAYS

    setup_main_menu()
    setup_world_preview_panel()
    setup_region_start_panel()
    setup_pause_menu()
    setup_options_panel()
    setup_debug_tools_panel()
    setup_load_game_panel()
    setup_confirm_load_panel()
    setup_confirm_delete_panel()

    if build_button == null:
        push_warning("BuildButton was not found under UI.")
    else:
        setup_build_button_theme()
        build_button.pressed.connect(_on_build_button_pressed)

    if build_menu == null:
        push_warning("BuildMenu was not found under UI. Build button will still show if present.")
    else:
        setup_build_menu_theme()
        setup_build_ui_layout()
        build_menu.visible = false

        if campfire_button != null:
            campfire_button.visible = false

    set_build_ui_enabled(false)
    show_main_menu()


func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_SIZE_CHANGED:
        setup_main_menu_layout()
        setup_world_preview_panel_layout()
        setup_region_start_panel_layout()
        setup_pause_menu_layout()
        setup_options_panel_layout()
        setup_debug_tools_panel_layout()
        setup_load_game_panel_layout()
        setup_confirm_load_panel_layout()
        setup_confirm_delete_panel_layout()
        setup_build_ui_layout()


func set_build_ui_enabled(is_enabled: bool) -> void:
    build_ui_enabled = is_enabled

    if build_button != null:
        build_button.visible = is_enabled

    if not is_enabled:
        hide_build_menu()


func hide_build_menu() -> void:
    if build_menu != null:
        build_menu.visible = false

    selected_build_age = ""
    clear_generated_age_buttons()
    clear_generated_build_buttons()


func show_main_menu() -> void:
    if main_menu_panel == null:
        setup_main_menu()

    if main_menu_panel != null:
        main_menu_panel.visible = true

    hide_world_preview_panel()
    hide_region_start_panel()
    hide_pause_menu()
    hide_options_panel()
    hide_debug_tools_panel()
    hide_load_game_panel()
    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    set_build_ui_enabled(false)


func hide_main_menu() -> void:
    if main_menu_panel != null:
        main_menu_panel.visible = false


func show_options_panel() -> void:
    if options_panel == null:
        setup_options_panel()

    if options_panel != null:
        options_panel.visible = true

    hide_main_menu()
    hide_world_preview_panel()
    hide_region_start_panel()
    hide_pause_menu()
    hide_load_game_panel()
    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    hide_debug_tools_panel()
    set_build_ui_enabled(false)


func hide_options_panel() -> void:
    if options_panel != null:
        options_panel.visible = false


func show_debug_tools_panel() -> void:
    if not debug_mode_enabled:
        return

    if debug_tools_panel == null:
        setup_debug_tools_panel()

    if debug_tools_panel != null:
        debug_tools_panel.visible = true


func hide_debug_tools_panel() -> void:
    if debug_tools_panel != null:
        debug_tools_panel.visible = false


func update_debug_mode_ui() -> void:
    if pause_debug_tools_button != null:
        pause_debug_tools_button.visible = debug_mode_enabled

    if not debug_mode_enabled:
        hide_debug_tools_panel()


func show_world_preview_panel() -> void:
    if world_preview_panel == null:
        setup_world_preview_panel()

    if world_preview_panel != null:
        world_preview_panel.visible = true

    hide_main_menu()
    hide_region_start_panel()
    hide_pause_menu()
    hide_options_panel()
    hide_debug_tools_panel()
    hide_load_game_panel()
    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    set_build_ui_enabled(false)


func hide_world_preview_panel() -> void:
    if world_preview_panel != null:
        world_preview_panel.visible = false


func show_region_start_panel(default_region_name: String = "New Settlement") -> void:
    if region_start_panel == null:
        setup_region_start_panel()

    if region_start_panel != null:
        region_start_panel.visible = true

    if region_name_input != null:
        region_name_input.text = default_region_name
        region_name_input.grab_focus()
        region_name_input.select_all()

    hide_main_menu()
    hide_world_preview_panel()
    hide_pause_menu()
    hide_options_panel()
    hide_debug_tools_panel()
    hide_load_game_panel()
    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    set_build_ui_enabled(false)


func hide_region_start_panel() -> void:
    if region_start_panel != null:
        region_start_panel.visible = false


func show_pause_menu() -> void:
    if pause_menu_panel == null:
        setup_pause_menu()

    if pause_menu_panel != null:
        pause_menu_panel.visible = true

    hide_build_menu()
    hide_load_game_panel()
    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    hide_options_panel()
    update_debug_mode_ui()


func hide_pause_menu() -> void:
    if pause_menu_panel != null:
        pause_menu_panel.visible = false

    hide_debug_tools_panel()


func show_load_game_panel(
    save_infos: Array,
    opened_from_pause: bool = false
) -> void:
    if load_game_panel == null:
        setup_load_game_panel()

    load_game_opened_from_pause = opened_from_pause

    if load_game_panel != null:
        load_game_panel.visible = true

    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    hide_main_menu()
    hide_world_preview_panel()
    hide_region_start_panel()
    hide_options_panel()
    hide_debug_tools_panel()

    if not opened_from_pause:
        hide_pause_menu()

    set_build_ui_enabled(false)
    populate_load_game_panel(save_infos)


func hide_load_game_panel() -> void:
    if load_game_panel != null:
        load_game_panel.visible = false

    hide_confirm_load_panel()
    hide_confirm_delete_panel()
    clear_generated_load_save_buttons()


func show_confirm_load_panel(
    save_file_name: String,
    save_label: String
) -> void:
    if confirm_load_panel == null:
        setup_confirm_load_panel()

    hide_confirm_delete_panel()

    pending_load_save_file_name = save_file_name
    pending_load_save_label = save_label

    if confirm_load_panel != null:
        confirm_load_panel.visible = true

    update_confirm_load_panel_text()


func hide_confirm_load_panel() -> void:
    if confirm_load_panel != null:
        confirm_load_panel.visible = false

    pending_load_save_file_name = ""
    pending_load_save_label = ""


func update_confirm_load_panel_text() -> void:
    if confirm_load_panel == null:
        return

    var save_name_label: Label = confirm_load_panel.get_node_or_null("SaveNameLabel")

    if save_name_label != null:
        save_name_label.text = pending_load_save_label


func show_confirm_delete_panel(
    save_file_name: String,
    save_label: String
) -> void:
    if confirm_delete_panel == null:
        setup_confirm_delete_panel()

    hide_confirm_load_panel()

    pending_delete_save_file_name = save_file_name
    pending_delete_save_label = save_label

    if confirm_delete_panel != null:
        confirm_delete_panel.visible = true

    update_confirm_delete_panel_text()


func hide_confirm_delete_panel() -> void:
    if confirm_delete_panel != null:
        confirm_delete_panel.visible = false

    pending_delete_save_file_name = ""
    pending_delete_save_label = ""


func update_confirm_delete_panel_text() -> void:
    if confirm_delete_panel == null:
        return

    var save_name_label: Label = confirm_delete_panel.get_node_or_null("SaveNameLabel")

    if save_name_label != null:
        save_name_label.text = pending_delete_save_label
        
func populate_load_game_panel(save_infos: Array) -> void:
    if load_game_panel == null:
        return

    clear_generated_load_save_buttons()

    var max_visible_saves: int = 8
    var visible_count: int = min(save_infos.size(), max_visible_saves)

    if visible_count <= 0:
        var empty_label := Label.new()
        empty_label.name = "GeneratedNoSavesLabel"
        empty_label.text = "No save files found."
        empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        empty_label.position = Vector2(20, 70)
        empty_label.size = Vector2(360, 24)
        empty_label.process_mode = Node.PROCESS_MODE_ALWAYS
        load_game_panel.add_child(empty_label)
        generated_load_save_buttons.append(empty_label)
        return

    for save_index in range(visible_count):
        var save_info_variant: Variant = save_infos[save_index]

        if typeof(save_info_variant) != TYPE_DICTIONARY:
            continue

        var save_info: Dictionary = save_info_variant
        var file_name: String = str(save_info.get("file_name", ""))
        var modified_time: int = int(save_info.get("modified_time", 0))

        if file_name == "":
            continue

        var button_label: String = get_save_button_label(file_name, modified_time)
        var row_y: float = 64.0 + float(save_index) * 32.0

        var save_button := create_load_save_button(
            button_label,
            Vector2(24, row_y)
        )

        save_button.pressed.connect(
            Callable(self, "_on_load_save_file_pressed").bind(file_name)
        )

        load_game_panel.add_child(save_button)
        generated_load_save_buttons.append(save_button)

        var delete_button := create_delete_save_button(
            "X",
            Vector2(348, row_y)
        )

        delete_button.tooltip_text = "Delete " + file_name
        delete_button.pressed.connect(
            Callable(self, "_on_delete_save_file_pressed").bind(file_name, button_label)
        )

        load_game_panel.add_child(delete_button)
        generated_load_save_buttons.append(delete_button)


func get_save_button_label(file_name: String, modified_time: int) -> String:
    var clean_name: String = file_name

    if clean_name.ends_with(".json"):
        clean_name = clean_name.substr(0, clean_name.length() - 5)

    var time_text: String = ""

    if modified_time > 0:
        var date_dict: Dictionary = Time.get_datetime_dict_from_unix_time(modified_time)
        time_text = (
            " | "
            + str(int(date_dict.get("year", 0)))
            + "-"
            + str(int(date_dict.get("month", 0))).pad_zeros(2)
            + "-"
            + str(int(date_dict.get("day", 0))).pad_zeros(2)
            + " "
            + str(int(date_dict.get("hour", 0))).pad_zeros(2)
            + ":"
            + str(int(date_dict.get("minute", 0))).pad_zeros(2)
        )

    return clean_name + time_text


func create_load_save_button(
    button_text: String,
    button_position: Vector2
) -> Button:
    var button := Button.new()
    button.text = button_text
    button.position = button_position
    button.size = Vector2(318, 26)
    button.custom_minimum_size = Vector2(318, 26)
    button.process_mode = Node.PROCESS_MODE_ALWAYS
    setup_menu_button_theme(button)

    return button


func create_delete_save_button(
    button_text: String,
    button_position: Vector2
) -> Button:
    var button := Button.new()
    button.text = button_text
    button.position = button_position
    button.size = Vector2(28, 26)
    button.custom_minimum_size = Vector2(28, 26)
    button.process_mode = Node.PROCESS_MODE_ALWAYS
    setup_menu_button_theme(button)

    return button


func setup_main_menu() -> void:
    if main_menu_panel != null:
        return

    main_menu_panel = Panel.new()
    main_menu_panel.name = "GeneratedMainMenu"
    main_menu_panel.visible = false
    main_menu_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(main_menu_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.94)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    main_menu_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Journey Through the Ages\n(WIP Title)"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 22)
    title_label.position = Vector2(0, 18)
    title_label.size = Vector2(325, 60)
    main_menu_panel.add_child(title_label)

    var new_game_button := create_menu_button("New Game", Vector2(80, 88))
    new_game_button.pressed.connect(_on_main_menu_new_game_pressed)
    main_menu_panel.add_child(new_game_button)
    generated_main_menu_buttons.append(new_game_button)

    var load_game_button := create_menu_button("Load Game", Vector2(80, 126))
    load_game_button.pressed.connect(_on_main_menu_load_game_pressed)
    main_menu_panel.add_child(load_game_button)
    generated_main_menu_buttons.append(load_game_button)

    var options_button := create_menu_button("Options", Vector2(80, 164))
    options_button.pressed.connect(_on_main_menu_options_pressed)
    main_menu_panel.add_child(options_button)
    generated_main_menu_buttons.append(options_button)

    var close_button := create_menu_button("Close Application", Vector2(80, 202))
    close_button.pressed.connect(_on_main_menu_close_application_pressed)
    main_menu_panel.add_child(close_button)
    generated_main_menu_buttons.append(close_button)

    setup_main_menu_layout()

func setup_options_panel() -> void:
    if options_panel != null:
        return

    options_panel = Panel.new()
    options_panel.name = "GeneratedOptionsPanel"
    options_panel.visible = false
    options_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(options_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.94)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    options_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Options"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 22)
    title_label.position = Vector2(0, 18)
    title_label.size = Vector2(320, 32)
    options_panel.add_child(title_label)

    debug_mode_checkbox = CheckBox.new()
    debug_mode_checkbox.name = "DebugModeCheckBox"
    debug_mode_checkbox.text = "Debug Mode"
    debug_mode_checkbox.button_pressed = debug_mode_enabled
    debug_mode_checkbox.position = Vector2(80, 76)
    debug_mode_checkbox.size = Vector2(180, 28)
    debug_mode_checkbox.process_mode = Node.PROCESS_MODE_ALWAYS
    debug_mode_checkbox.toggled.connect(_on_debug_mode_toggled)
    options_panel.add_child(debug_mode_checkbox)

    var back_button := create_menu_button("Back", Vector2(80, 128))
    back_button.pressed.connect(_on_options_back_pressed)
    options_panel.add_child(back_button)
    generated_options_buttons.append(back_button)

    setup_options_panel_layout()


func setup_debug_tools_panel() -> void:
    if debug_tools_panel != null:
        return

    debug_tools_panel = Panel.new()
    debug_tools_panel.name = "GeneratedDebugToolsPanel"
    debug_tools_panel.visible = false
    debug_tools_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(debug_tools_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.96)
    panel_style.border_color = Color(0.95, 0.72, 0.32, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    debug_tools_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Debug Tools"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 20)
    title_label.position = Vector2(0, 14)
    title_label.size = Vector2(320, 30)
    debug_tools_panel.add_child(title_label)

    populate_debug_tools_panel()
    setup_debug_tools_panel_layout()


func populate_debug_tools_panel() -> void:
    if debug_tools_panel == null:
        return

    clear_generated_debug_tool_buttons()

    var actions: Array = RegionDebugPanel.get_actions()
    var max_visible_actions: int = min(actions.size(), 13)

    for action_index in range(max_visible_actions):
        var action_data: Dictionary = actions[action_index]
        var action_id: String = str(action_data.get("id", ""))
        var action_label: String = str(action_data.get("label", action_id))

        if action_id == "":
            continue

        var debug_button := create_menu_button(
            action_label,
            Vector2(80, 54 + action_index * 32)
        )

        debug_button.pressed.connect(
            Callable(self, "_on_debug_tool_action_pressed").bind(action_id)
        )

        debug_tools_panel.add_child(debug_button)
        generated_debug_tool_buttons.append(debug_button)


func setup_world_preview_panel() -> void:
    if world_preview_panel != null:
        return

    world_preview_panel = Panel.new()
    world_preview_panel.name = "GeneratedWorldPreviewPanel"
    world_preview_panel.visible = false
    world_preview_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(world_preview_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.90)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 10
    panel_style.content_margin_right = 10
    panel_style.content_margin_top = 10
    panel_style.content_margin_bottom = 10
    world_preview_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "World Generation"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 18)
    title_label.position = Vector2(0, 10)
    title_label.size = Vector2(260, 28)
    world_preview_panel.add_child(title_label)

    var hint_label := Label.new()
    hint_label.name = "HintLabel"
    hint_label.text = "Reroll until you like the world,\nthen confirm it to choose a region."
    hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    hint_label.add_theme_font_size_override("font_size", 11)
    hint_label.position = Vector2(10, 40)
    hint_label.size = Vector2(240, 42)
    world_preview_panel.add_child(hint_label)

    var reroll_button := create_menu_button("Reroll World", Vector2(50, 88))
    reroll_button.pressed.connect(_on_world_preview_reroll_pressed)
    world_preview_panel.add_child(reroll_button)
    generated_world_preview_buttons.append(reroll_button)

    var confirm_button := create_menu_button("Confirm World", Vector2(50, 126))
    confirm_button.pressed.connect(_on_world_preview_confirm_pressed)
    world_preview_panel.add_child(confirm_button)
    generated_world_preview_buttons.append(confirm_button)

    var back_button := create_menu_button("Back to Main Menu", Vector2(50, 164))
    back_button.pressed.connect(_on_world_preview_back_pressed)
    world_preview_panel.add_child(back_button)
    generated_world_preview_buttons.append(back_button)

    setup_world_preview_panel_layout()
    
func setup_load_game_panel() -> void:
    if load_game_panel != null:
        return

    load_game_panel = Panel.new()
    load_game_panel.name = "GeneratedLoadGamePanel"
    load_game_panel.visible = false
    load_game_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(load_game_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.94)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    load_game_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Load Game"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 22)
    title_label.position = Vector2(0, 16)
    title_label.size = Vector2(400, 32)
    load_game_panel.add_child(title_label)

    var back_button := create_menu_button("Back", Vector2(120, 330))
    back_button.pressed.connect(_on_load_save_back_pressed)
    load_game_panel.add_child(back_button)

    setup_load_game_panel_layout()


func setup_confirm_load_panel() -> void:
    if confirm_load_panel != null:
        return

    confirm_load_panel = Panel.new()
    confirm_load_panel.name = "GeneratedConfirmLoadPanel"
    confirm_load_panel.visible = false
    confirm_load_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(confirm_load_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.97)
    panel_style.border_color = Color(0.95, 0.72, 0.32, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    confirm_load_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Load This Save?"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 20)
    title_label.position = Vector2(0, 16)
    title_label.size = Vector2(360, 30)
    confirm_load_panel.add_child(title_label)

    var save_name_label := Label.new()
    save_name_label.name = "SaveNameLabel"
    save_name_label.text = ""
    save_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    save_name_label.add_theme_font_size_override("font_size", 12)
    save_name_label.position = Vector2(20, 54)
    save_name_label.size = Vector2(320, 24)
    confirm_load_panel.add_child(save_name_label)

    var warning_label := Label.new()
    warning_label.name = "WarningLabel"
    warning_label.text = "Any unsaved progress in the current region will be lost."
    warning_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    warning_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    warning_label.add_theme_font_size_override("font_size", 12)
    warning_label.position = Vector2(30, 86)
    warning_label.size = Vector2(300, 44)
    confirm_load_panel.add_child(warning_label)

    var confirm_button := create_menu_button("Load This Save", Vector2(100, 142))
    confirm_button.pressed.connect(_on_confirm_load_pressed)
    confirm_load_panel.add_child(confirm_button)
    generated_confirm_load_buttons.append(confirm_button)

    var cancel_button := create_menu_button("Cancel", Vector2(100, 180))
    cancel_button.pressed.connect(_on_confirm_load_cancel_pressed)
    confirm_load_panel.add_child(cancel_button)
    generated_confirm_load_buttons.append(cancel_button)

    setup_confirm_load_panel_layout()


func setup_confirm_delete_panel() -> void:
    if confirm_delete_panel != null:
        return

    confirm_delete_panel = Panel.new()
    confirm_delete_panel.name = "GeneratedConfirmDeletePanel"
    confirm_delete_panel.visible = false
    confirm_delete_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(confirm_delete_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.98)
    panel_style.border_color = Color(0.95, 0.28, 0.22, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    confirm_delete_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Delete This Save?"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 20)
    title_label.position = Vector2(0, 16)
    title_label.size = Vector2(360, 30)
    confirm_delete_panel.add_child(title_label)

    var save_name_label := Label.new()
    save_name_label.name = "SaveNameLabel"
    save_name_label.text = ""
    save_name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    save_name_label.add_theme_font_size_override("font_size", 12)
    save_name_label.position = Vector2(20, 54)
    save_name_label.size = Vector2(320, 24)
    confirm_delete_panel.add_child(save_name_label)

    var warning_label := Label.new()
    warning_label.name = "WarningLabel"
    warning_label.text = "This permanently deletes the save file. This cannot be undone."
    warning_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    warning_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    warning_label.add_theme_font_size_override("font_size", 12)
    warning_label.position = Vector2(30, 86)
    warning_label.size = Vector2(300, 44)
    confirm_delete_panel.add_child(warning_label)

    var confirm_button := create_menu_button("Delete Save", Vector2(100, 142))
    confirm_button.pressed.connect(_on_confirm_delete_pressed)
    confirm_delete_panel.add_child(confirm_button)
    generated_confirm_delete_buttons.append(confirm_button)

    var cancel_button := create_menu_button("Cancel", Vector2(100, 180))
    cancel_button.pressed.connect(_on_confirm_delete_cancel_pressed)
    confirm_delete_panel.add_child(cancel_button)
    generated_confirm_delete_buttons.append(cancel_button)

    setup_confirm_delete_panel_layout()


func setup_region_start_panel() -> void:
    if region_start_panel != null:
        return

    region_start_panel = Panel.new()
    region_start_panel.name = "GeneratedRegionStartPanel"
    region_start_panel.visible = false
    region_start_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(region_start_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.94)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    region_start_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Start Region?"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 20)
    title_label.position = Vector2(0, 16)
    title_label.size = Vector2(340, 30)
    region_start_panel.add_child(title_label)

    var hint_label := Label.new()
    hint_label.name = "HintLabel"
    hint_label.text = "Name your settlement before entering the region."
    hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    hint_label.add_theme_font_size_override("font_size", 11)
    hint_label.position = Vector2(12, 48)
    hint_label.size = Vector2(316, 24)
    region_start_panel.add_child(hint_label)

    var name_label := Label.new()
    name_label.name = "NameLabel"
    name_label.text = "Settlement Name"
    name_label.add_theme_font_size_override("font_size", 12)
    name_label.position = Vector2(50, 82)
    name_label.size = Vector2(240, 20)
    region_start_panel.add_child(name_label)

    region_name_input = LineEdit.new()
    region_name_input.name = "RegionNameInput"
    region_name_input.text = "New Settlement"
    region_name_input.placeholder_text = "Enter settlement name"
    region_name_input.position = Vector2(50, 104)
    region_name_input.size = Vector2(240, 30)
    region_name_input.custom_minimum_size = Vector2(240, 30)
    region_name_input.process_mode = Node.PROCESS_MODE_ALWAYS
    region_name_input.text_submitted.connect(_on_region_name_submitted)
    setup_line_edit_theme(region_name_input)
    region_start_panel.add_child(region_name_input)

    var start_button := create_menu_button("Start Region", Vector2(90, 150))
    start_button.pressed.connect(_on_region_start_confirm_pressed)
    region_start_panel.add_child(start_button)
    generated_region_start_buttons.append(start_button)

    var cancel_button := create_menu_button("Back to World Map", Vector2(90, 188))
    cancel_button.pressed.connect(_on_region_start_cancel_pressed)
    region_start_panel.add_child(cancel_button)
    generated_region_start_buttons.append(cancel_button)

    setup_region_start_panel_layout()


func setup_pause_menu() -> void:
    if pause_menu_panel != null:
        return

    pause_menu_panel = Panel.new()
    pause_menu_panel.name = "GeneratedPauseMenu"
    pause_menu_panel.visible = false
    pause_menu_panel.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(pause_menu_panel)

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.04, 0.04, 0.04, 0.94)
    panel_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    panel_style.set_border_width_all(2)
    panel_style.set_corner_radius_all(6)
    panel_style.content_margin_left = 12
    panel_style.content_margin_right = 12
    panel_style.content_margin_top = 12
    panel_style.content_margin_bottom = 12
    pause_menu_panel.add_theme_stylebox_override("panel", panel_style)

    var title_label := Label.new()
    title_label.name = "TitleLabel"
    title_label.text = "Paused"
    title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    title_label.add_theme_font_size_override("font_size", 22)
    title_label.position = Vector2(0, 18)
    title_label.size = Vector2(320, 32)
    pause_menu_panel.add_child(title_label)

    var resume_button := create_menu_button("Resume Game", Vector2(80, 74))
    resume_button.pressed.connect(_on_pause_resume_pressed)
    pause_menu_panel.add_child(resume_button)
    generated_pause_menu_buttons.append(resume_button)

    var save_button := create_menu_button("Save Game", Vector2(80, 112))
    save_button.pressed.connect(_on_pause_save_pressed)
    pause_menu_panel.add_child(save_button)
    generated_pause_menu_buttons.append(save_button)

    var load_button := create_menu_button("Load Game", Vector2(80, 150))
    load_button.pressed.connect(_on_pause_load_pressed)
    pause_menu_panel.add_child(load_button)
    generated_pause_menu_buttons.append(load_button)

    pause_debug_tools_button = create_menu_button("Debug Tools", Vector2(80, 188))
    pause_debug_tools_button.name = "DebugToolsButton"
    pause_debug_tools_button.visible = debug_mode_enabled
    pause_debug_tools_button.pressed.connect(_on_pause_debug_tools_pressed)
    pause_menu_panel.add_child(pause_debug_tools_button)
    generated_pause_menu_buttons.append(pause_debug_tools_button)

    pause_return_to_main_button = create_menu_button("Return to Main Menu", Vector2(80, 226))
    pause_return_to_main_button.name = "ReturnToMainMenuButton"
    pause_return_to_main_button.pressed.connect(_on_pause_return_to_main_pressed)
    pause_menu_panel.add_child(pause_return_to_main_button)
    generated_pause_menu_buttons.append(pause_return_to_main_button)

    var close_button := create_menu_button("Close Application", Vector2(80, 264))
    close_button.name = "CloseApplicationButton"
    close_button.pressed.connect(_on_pause_close_application_pressed)
    pause_menu_panel.add_child(close_button)
    generated_pause_menu_buttons.append(close_button)

    setup_pause_menu_layout()


func create_menu_button(button_text: String, button_position: Vector2) -> Button:
    var button := Button.new()
    button.text = button_text
    button.position = button_position
    button.size = Vector2(160, 28)
    button.custom_minimum_size = Vector2(160, 28)
    button.process_mode = Node.PROCESS_MODE_ALWAYS
    setup_menu_button_theme(button)

    return button


func setup_menu_button_theme(button: Button) -> void:
    button.add_theme_font_size_override("font_size", 13)

    var normal_style := StyleBoxFlat.new()
    normal_style.bg_color = Color(0.18, 0.18, 0.18, 0.96)
    normal_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    normal_style.set_border_width_all(1)
    normal_style.set_corner_radius_all(4)
    normal_style.content_margin_left = 8
    normal_style.content_margin_right = 8
    normal_style.content_margin_top = 3
    normal_style.content_margin_bottom = 3

    var hover_style := normal_style.duplicate()
    hover_style.bg_color = Color(0.28, 0.26, 0.20, 0.98)

    var pressed_style := normal_style.duplicate()
    pressed_style.bg_color = Color(0.10, 0.10, 0.10, 0.98)

    button.add_theme_stylebox_override("normal", normal_style)
    button.add_theme_stylebox_override("hover", hover_style)
    button.add_theme_stylebox_override("pressed", pressed_style)
    button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func setup_line_edit_theme(line_edit: LineEdit) -> void:
    line_edit.add_theme_font_size_override("font_size", 13)

    var normal_style := StyleBoxFlat.new()
    normal_style.bg_color = Color(0.10, 0.10, 0.10, 0.98)
    normal_style.border_color = Color(0.78, 0.70, 0.48, 1.0)
    normal_style.set_border_width_all(1)
    normal_style.set_corner_radius_all(4)
    normal_style.content_margin_left = 8
    normal_style.content_margin_right = 8
    normal_style.content_margin_top = 5
    normal_style.content_margin_bottom = 5

    var focus_style := normal_style.duplicate()
    focus_style.border_color = Color(1.0, 0.86, 0.42, 1.0)

    line_edit.add_theme_stylebox_override("normal", normal_style)
    line_edit.add_theme_stylebox_override("focus", focus_style)
    line_edit.add_theme_stylebox_override("read_only", normal_style)
    
func setup_main_menu_layout() -> void:
    if main_menu_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    main_menu_panel.size = Vector2(320, 262)
    main_menu_panel.position = Vector2(
        viewport_size.x * 0.5 - main_menu_panel.size.x * 0.5,
        viewport_size.y * 0.5 - main_menu_panel.size.y * 0.5
    )

func setup_options_panel_layout() -> void:
    if options_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    options_panel.size = Vector2(320, 190)
    options_panel.position = Vector2(
        viewport_size.x * 0.5 - options_panel.size.x * 0.5,
        viewport_size.y * 0.5 - options_panel.size.y * 0.5
    )

func setup_debug_tools_panel_layout() -> void:
    if debug_tools_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    debug_tools_panel.size = Vector2(320, 500)
    debug_tools_panel.position = Vector2(
        viewport_size.x * 0.5 - debug_tools_panel.size.x * 0.5,
        viewport_size.y * 0.5 - debug_tools_panel.size.y * 0.5
    )


func setup_world_preview_panel_layout() -> void:
    if world_preview_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    world_preview_panel.size = Vector2(260, 210)
    world_preview_panel.position = Vector2(
        viewport_size.x - world_preview_panel.size.x - 16.0,
        16.0
    )


func setup_region_start_panel_layout() -> void:
    if region_start_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    region_start_panel.size = Vector2(340, 234)
    region_start_panel.position = Vector2(
        viewport_size.x * 0.5 - region_start_panel.size.x * 0.5,
        viewport_size.y * 0.5 - region_start_panel.size.y * 0.5
    )


func setup_pause_menu_layout() -> void:
    if pause_menu_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    pause_menu_panel.size = Vector2(320, 324)
    pause_menu_panel.position = Vector2(
        viewport_size.x * 0.5 - pause_menu_panel.size.x * 0.5,
        viewport_size.y * 0.5 - pause_menu_panel.size.y * 0.5
    )
    


func setup_load_game_panel_layout() -> void:
    if load_game_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    load_game_panel.size = Vector2(400, 372)
    load_game_panel.position = Vector2(
        viewport_size.x * 0.5 - load_game_panel.size.x * 0.5,
        viewport_size.y * 0.5 - load_game_panel.size.y * 0.5
    )


func setup_confirm_load_panel_layout() -> void:
    if confirm_load_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    confirm_load_panel.size = Vector2(360, 230)
    confirm_load_panel.position = Vector2(
        viewport_size.x * 0.5 - confirm_load_panel.size.x * 0.5,
        viewport_size.y * 0.5 - confirm_load_panel.size.y * 0.5
    )


func setup_confirm_delete_panel_layout() -> void:
    if confirm_delete_panel == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    confirm_delete_panel.size = Vector2(360, 230)
    confirm_delete_panel.position = Vector2(
        viewport_size.x * 0.5 - confirm_delete_panel.size.x * 0.5,
        viewport_size.y * 0.5 - confirm_delete_panel.size.y * 0.5
    )


func force_build_button_visible() -> void:
    if build_button == null:
        return

    build_button.visible = build_ui_enabled
    build_button.text = "Build"
    build_button.custom_minimum_size = Vector2(54, 16)
    build_button.size = Vector2(54, 16)

    setup_build_ui_layout()


func setup_build_button_theme() -> void:
    if build_button == null:
        return

    build_button.add_theme_font_size_override("font_size", 11)

    var normal_style := StyleBoxFlat.new()
    normal_style.bg_color = Color(0.18, 0.18, 0.18, 0.92)
    normal_style.border_color = Color(0.8, 0.8, 0.8, 1.0)
    normal_style.set_border_width_all(1)
    normal_style.set_corner_radius_all(3)
    normal_style.content_margin_left = 4
    normal_style.content_margin_right = 4
    normal_style.content_margin_top = 1
    normal_style.content_margin_bottom = 1

    var hover_style := normal_style.duplicate()
    hover_style.bg_color = Color(0.28, 0.28, 0.28, 0.95)

    var pressed_style := normal_style.duplicate()
    pressed_style.bg_color = Color(0.10, 0.10, 0.10, 0.95)

    build_button.add_theme_stylebox_override("normal", normal_style)
    build_button.add_theme_stylebox_override("hover", hover_style)
    build_button.add_theme_stylebox_override("pressed", pressed_style)
    build_button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func setup_build_menu_theme() -> void:
    if build_menu == null:
        return

    var panel_style := StyleBoxFlat.new()
    panel_style.bg_color = Color(0.08, 0.08, 0.08, 0.88)
    panel_style.border_color = Color(0.65, 0.65, 0.65, 1.0)
    panel_style.set_border_width_all(1)
    panel_style.set_corner_radius_all(4)
    panel_style.content_margin_left = 4
    panel_style.content_margin_right = 4
    panel_style.content_margin_top = 4
    panel_style.content_margin_bottom = 4

    build_menu.add_theme_stylebox_override("panel", panel_style)


func setup_small_button_theme(
    button: Button,
    is_age_button: bool = false,
    is_selected: bool = false
) -> void:
    button.add_theme_font_size_override("font_size", 10)

    var normal_style := StyleBoxFlat.new()

    if is_age_button:
        if is_selected:
            normal_style.bg_color = Color(0.34, 0.24, 0.10, 0.98)
            normal_style.border_color = Color(1.0, 0.78, 0.28, 1.0)
        else:
            normal_style.bg_color = Color(0.22, 0.18, 0.10, 0.95)
            normal_style.border_color = Color(0.95, 0.75, 0.35, 1.0)
    else:
        normal_style.bg_color = Color(0.18, 0.18, 0.18, 0.92)
        normal_style.border_color = Color(0.7, 0.7, 0.7, 1.0)

    normal_style.set_border_width_all(1)
    normal_style.set_corner_radius_all(3)
    normal_style.content_margin_left = 4
    normal_style.content_margin_right = 4
    normal_style.content_margin_top = 1
    normal_style.content_margin_bottom = 1

    var hover_style := normal_style.duplicate()
    hover_style.bg_color = Color(0.28, 0.28, 0.28, 0.95)

    var pressed_style := normal_style.duplicate()
    pressed_style.bg_color = Color(0.10, 0.10, 0.10, 0.95)

    button.add_theme_stylebox_override("normal", normal_style)
    button.add_theme_stylebox_override("hover", hover_style)
    button.add_theme_stylebox_override("pressed", pressed_style)
    button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func setup_build_ui_layout() -> void:
    if build_button == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    var margin: float = 12.0

    build_button.visible = build_ui_enabled
    build_button.text = "Build"
    build_button.custom_minimum_size = Vector2(54, 16)
    build_button.size = Vector2(54, 16)
    build_button.position = Vector2(
        margin,
        viewport_size.y - build_button.size.y - margin
    )

    if build_menu == null:
        return

    build_menu.size = Vector2(
        min(760.0, viewport_size.x - margin * 2.0),
        84.0
    )

    build_menu.position = Vector2(
        margin,
        build_button.position.y - build_menu.size.y - 8.0
    )


func setup_build_menu_age_buttons() -> void:
    if build_menu == null:
        return

    clear_generated_age_buttons()
    clear_generated_build_buttons()

    if campfire_button != null:
        campfire_button.visible = false

    create_age_button(
        "Stone Age",
        RegionBuildingData.AGE_STONE,
        Vector2(8, 8)
    )


func create_age_button(display_name: String, age_id: String, position: Vector2) -> void:
    var age_button := Button.new()
    age_button.name = "AgeButton_" + age_id
    age_button.text = display_name
    age_button.position = position
    age_button.size = Vector2(76, 20)
    age_button.custom_minimum_size = Vector2(76, 20)
    age_button.tooltip_text = "Show " + display_name + " buildings"

    var is_selected: bool = selected_build_age == age_id
    setup_small_button_theme(age_button, true, is_selected)

    age_button.pressed.connect(
        Callable(self, "_on_age_button_pressed").bind(age_id)
    )

    build_menu.add_child(age_button)
    generated_age_buttons.append(age_button)


func create_building_buttons_for_age(age_id: String) -> void:
    clear_generated_build_buttons()

    var unlocked_buildings: Array = RegionBuildingData.get_unlocked_buildings()

    var start_x: float = 8.0
    var button_y: float = 36.0
    var button_spacing: float = 6.0
    var button_height: float = 20.0
    var current_x: float = start_x
    var max_x: float = build_menu.size.x - 8.0

    for building_index in range(unlocked_buildings.size()):
        var building_variant: Variant = unlocked_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_age: String = str(building_data.get("age", ""))

        if building_age != age_id:
            continue

        var building_id: String = str(building_data.get("id", "unknown"))
        var building_name: String = str(building_data.get("name", "Unknown"))

        var button_width: float = get_building_button_width(building_name)

        if current_x + button_width > max_x:
            break

        var building_button := Button.new()
        building_button.name = "BuildButton_" + building_id
        building_button.text = building_name
        building_button.position = Vector2(current_x, button_y)
        building_button.size = Vector2(button_width, button_height)
        building_button.custom_minimum_size = Vector2(button_width, button_height)
        building_button.tooltip_text = get_building_tooltip_text(building_data)

        setup_small_button_theme(building_button, false, false)

        building_button.pressed.connect(
            Callable(self, "_on_generated_building_button_pressed").bind(building_id)
        )

        build_menu.add_child(building_button)
        generated_build_buttons.append(building_button)

        current_x += button_width + button_spacing


func get_building_button_width(building_name: String) -> float:
    var estimated_width: float = 18.0 + float(building_name.length()) * 6.0

    return clampf(estimated_width, 52.0, 128.0)


func clear_generated_age_buttons() -> void:
    for button_index in range(generated_age_buttons.size()):
        var button_variant: Variant = generated_age_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_age_buttons.clear()


func clear_generated_build_buttons() -> void:
    for button_index in range(generated_build_buttons.size()):
        var button_variant: Variant = generated_build_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_build_buttons.clear()


func clear_generated_main_menu_buttons() -> void:
    for button_index in range(generated_main_menu_buttons.size()):
        var button_variant: Variant = generated_main_menu_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_main_menu_buttons.clear()


func clear_generated_world_preview_buttons() -> void:
    for button_index in range(generated_world_preview_buttons.size()):
        var button_variant: Variant = generated_world_preview_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_world_preview_buttons.clear()


func clear_generated_region_start_buttons() -> void:
    for button_index in range(generated_region_start_buttons.size()):
        var button_variant: Variant = generated_region_start_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_region_start_buttons.clear()


func clear_generated_pause_menu_buttons() -> void:
    for button_index in range(generated_pause_menu_buttons.size()):
        var button_variant: Variant = generated_pause_menu_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_pause_menu_buttons.clear()


func clear_generated_options_buttons() -> void:
    for button_index in range(generated_options_buttons.size()):
        var button_variant: Variant = generated_options_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_options_buttons.clear()


func clear_generated_debug_tool_buttons() -> void:
    for button_index in range(generated_debug_tool_buttons.size()):
        var button_variant: Variant = generated_debug_tool_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_debug_tool_buttons.clear()


func clear_generated_load_save_buttons() -> void:
    for button_index in range(generated_load_save_buttons.size()):
        var button_variant: Variant = generated_load_save_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_load_save_buttons.clear()


func clear_generated_confirm_load_buttons() -> void:
    for button_index in range(generated_confirm_load_buttons.size()):
        var button_variant: Variant = generated_confirm_load_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_confirm_load_buttons.clear()


func clear_generated_confirm_delete_buttons() -> void:
    for button_index in range(generated_confirm_delete_buttons.size()):
        var button_variant: Variant = generated_confirm_delete_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_confirm_delete_buttons.clear()


func get_building_tooltip_text(building_data: Dictionary) -> String:
    var building_name: String = str(building_data.get("name", "Unknown Building"))
    var description: String = str(building_data.get("description", ""))
    var cost_text: String = get_cost_text(building_data.get("cost", {}))
    var footprint_text: String = (
        str(int(building_data.get("width", 1)))
        + "x"
        + str(int(building_data.get("height", 1)))
    )

    var movable_text := "Fixed"

    if bool(building_data.get("movable", false)):
        movable_text = "Movable"

    return (
        building_name
        + "\nCost: "
        + cost_text
        + "\nFootprint: "
        + footprint_text
        + "\n"
        + movable_text
        + "\n\n"
        + description
    )


func get_cost_text(cost_variant: Variant) -> String:
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


func _on_build_button_pressed() -> void:
    if not build_ui_enabled:
        return

    if build_menu == null:
        push_warning("BuildMenu was not found.")
        return

    setup_build_ui_layout()

    if build_menu.visible:
        build_menu.visible = false
        selected_build_age = ""
        clear_generated_age_buttons()
        clear_generated_build_buttons()
    else:
        build_menu.visible = true
        selected_build_age = ""
        setup_build_menu_age_buttons()

    print("Build Menu Visible: ", build_menu.visible)


func _on_age_button_pressed(age_id: String) -> void:
    selected_build_age = age_id

    clear_generated_age_buttons()

    create_age_button(
        "Stone Age",
        RegionBuildingData.AGE_STONE,
        Vector2(8, 8)
    )

    create_building_buttons_for_age(selected_build_age)

    print("Selected Build Age: ", selected_build_age)


func _on_generated_building_button_pressed(building_id: String) -> void:
    if build_menu != null:
        build_menu.visible = false

    if region == null:
        push_warning("Region node was not found.")
        return

    if region.has_method("start_building_placement"):
        region.call("start_building_placement", building_id)
        return

    if building_id == RegionBuildingData.BUILDING_CAMPFIRE and region.has_method("start_campfire_placement"):
        region.call("start_campfire_placement")
        return

    push_warning("Region does not have a placement method for building: " + building_id)


func _on_main_menu_new_game_pressed() -> void:
    main_menu_new_game_requested.emit()


func _on_main_menu_load_game_pressed() -> void:
    main_menu_load_game_requested.emit()


func _on_main_menu_options_pressed() -> void:
    main_menu_options_requested.emit()


func _on_options_back_pressed() -> void:
    hide_options_panel()
    show_main_menu()

func _on_main_menu_close_application_pressed() -> void:
    main_menu_close_application_requested.emit()

func _on_debug_mode_toggled(is_enabled: bool) -> void:
    debug_mode_enabled = is_enabled

    if debug_mode_checkbox != null:
        debug_mode_checkbox.button_pressed = debug_mode_enabled

    update_debug_mode_ui()
    debug_mode_changed.emit(debug_mode_enabled)


func _on_pause_debug_tools_pressed() -> void:
    if debug_tools_panel != null and debug_tools_panel.visible:
        hide_debug_tools_panel()
    else:
        show_debug_tools_panel()


func _on_debug_tool_action_pressed(action_id: String) -> void:
    if action_id == RegionDebugPanel.ACTION_CLOSE:
        hide_debug_tools_panel()
        return

    debug_action_requested.emit(action_id)


func _on_world_preview_reroll_pressed() -> void:
    world_preview_reroll_requested.emit()


func _on_world_preview_confirm_pressed() -> void:
    world_preview_confirm_requested.emit()


func _on_world_preview_back_pressed() -> void:
    world_preview_back_requested.emit()


func _on_region_start_confirm_pressed() -> void:
    var region_name: String = ""

    if region_name_input != null:
        region_name = region_name_input.text.strip_edges()

    if region_name == "":
        region_name = "New Settlement"

    region_start_confirm_requested.emit(region_name)


func _on_region_name_submitted(_submitted_text: String) -> void:
    _on_region_start_confirm_pressed()


func _on_region_start_cancel_pressed() -> void:
    region_start_cancel_requested.emit()


func _on_pause_resume_pressed() -> void:
    pause_resume_requested.emit()


func _on_pause_save_pressed() -> void:
    pause_save_requested.emit()


func _on_pause_load_pressed() -> void:
    pause_load_requested.emit()


func _on_pause_return_to_main_pressed() -> void:
    pause_return_to_main_requested.emit()

func _on_pause_close_application_pressed() -> void:
    pause_close_application_requested.emit()

func _on_load_save_file_pressed(save_file_name: String) -> void:
    var save_label: String = save_file_name

    if save_label.ends_with(".json"):
        save_label = save_label.substr(0, save_label.length() - 5)

    show_confirm_load_panel(save_file_name, save_label)


func _on_delete_save_file_pressed(
    save_file_name: String,
    save_label: String
) -> void:
    show_confirm_delete_panel(save_file_name, save_label)


func _on_load_save_back_pressed() -> void:
    hide_load_game_panel()

    if load_game_opened_from_pause:
        show_pause_menu()
    else:
        show_main_menu()

    load_save_back_requested.emit()


func _on_confirm_load_pressed() -> void:
    if pending_load_save_file_name.strip_edges() == "":
        hide_confirm_load_panel()
        return

    var save_file_name: String = pending_load_save_file_name
    hide_confirm_load_panel()
    load_save_file_requested.emit(save_file_name)


func _on_confirm_load_cancel_pressed() -> void:
    hide_confirm_load_panel()


func _on_confirm_delete_pressed() -> void:
    if pending_delete_save_file_name.strip_edges() == "":
        hide_confirm_delete_panel()
        return

    var save_file_name: String = pending_delete_save_file_name
    hide_confirm_delete_panel()
    delete_save_file_requested.emit(save_file_name)


func _on_confirm_delete_cancel_pressed() -> void:
    hide_confirm_delete_panel()
