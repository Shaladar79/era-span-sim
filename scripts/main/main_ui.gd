extends CanvasLayer

@onready var build_button: Button = get_node_or_null("BuildButton")
@onready var build_menu: Panel = get_node_or_null("BuildMenu")
@onready var campfire_button: Button = get_node_or_null("BuildMenu/CampfireButton")
@onready var region: Node2D = get_node_or_null("../Region")


func _ready() -> void:
    print("MAIN UI SCRIPT RUNNING")

    if build_button == null:
        push_warning("BuildButton was not found under UI.")
        return

    if build_menu == null:
        push_warning("BuildMenu was not found under UI.")
        return

    if campfire_button == null:
        push_warning("CampfireButton was not found under UI/BuildMenu.")
        return

    setup_build_button_theme()
    setup_build_menu_theme()
    setup_campfire_button_theme()
    setup_build_ui_layout()

    build_menu.visible = false

    build_button.pressed.connect(_on_build_button_pressed)
    campfire_button.pressed.connect(_on_campfire_button_pressed)


func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_SIZE_CHANGED:
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

    build_button.custom_minimum_size = Vector2(54, 16)


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


func setup_campfire_button_theme() -> void:
    if campfire_button == null:
        return

    campfire_button.add_theme_font_size_override("font_size", 11)

    var normal_style := StyleBoxFlat.new()
    normal_style.bg_color = Color(0.18, 0.18, 0.18, 0.92)
    normal_style.border_color = Color(0.7, 0.7, 0.7, 1.0)
    normal_style.set_border_width_all(1)
    normal_style.set_corner_radius_all(3)
    normal_style.content_margin_left = 4
    normal_style.content_margin_right = 4
    normal_style.content_margin_top = 2
    normal_style.content_margin_bottom = 2

    var hover_style := normal_style.duplicate()
    hover_style.bg_color = Color(0.28, 0.28, 0.28, 0.95)

    var pressed_style := normal_style.duplicate()
    pressed_style.bg_color = Color(0.10, 0.10, 0.10, 0.95)

    campfire_button.add_theme_stylebox_override("normal", normal_style)
    campfire_button.add_theme_stylebox_override("hover", hover_style)
    campfire_button.add_theme_stylebox_override("pressed", pressed_style)
    campfire_button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func setup_build_ui_layout() -> void:
    if build_button == null or build_menu == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    var margin: float = 12.0

    build_button.visible = true
    build_button.text = "Build"
    build_button.size = Vector2(54, 16)
    build_button.position = Vector2(
        margin,
        viewport_size.y - build_button.size.y - margin
    )

    build_menu.position = Vector2(
        margin,
        build_button.position.y - build_menu.size.y - 8.0
    )

    if campfire_button != null:
        campfire_button.text = "Campfire - 4 Wood, 2 Stone"


func _on_build_button_pressed() -> void:
    build_menu.visible = not build_menu.visible
    setup_build_ui_layout()

    print("Build Menu Visible: ", build_menu.visible)


func _on_campfire_button_pressed() -> void:
    build_menu.visible = false

    if region == null:
        push_warning("Region node was not found.")
        return

    if region.has_method("start_campfire_placement"):
        region.call("start_campfire_placement")
    else:
        push_warning("Region does not have start_campfire_placement() yet.")
