extends CanvasLayer

@onready var build_button: Button = get_node_or_null("BuildButton")
@onready var build_menu: Panel = get_node_or_null("BuildMenu")
@onready var campfire_button: Button = get_node_or_null("BuildMenu/CampfireButton")
@onready var region: Node2D = get_node_or_null("../Region")

var generated_build_buttons: Array = []


func _ready() -> void:
    print("MAIN UI SCRIPT RUNNING")

    if build_button == null:
        push_warning("BuildButton was not found under UI.")
        return

    setup_build_button_theme()
    force_build_button_visible()

    if build_menu == null:
        push_warning("BuildMenu was not found under UI. Build button will still show.")
        build_button.pressed.connect(_on_build_button_pressed)
        return

    setup_build_menu_theme()
    setup_build_ui_layout()

    build_menu.visible = false

    if campfire_button != null:
        campfire_button.visible = false

    build_button.pressed.connect(_on_build_button_pressed)

    call_deferred("setup_build_menu_buttons")


func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_SIZE_CHANGED:
        setup_build_ui_layout()


func force_build_button_visible() -> void:
    if build_button == null:
        return

    build_button.visible = true
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


func setup_building_button_theme(button: Button) -> void:
    button.add_theme_font_size_override("font_size", 11)

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
    pressed_style.bg_color = Color(0.10, 0.10, 0.95)

    button.add_theme_stylebox_override("normal", normal_style)
    button.add_theme_stylebox_override("hover", hover_style)
    button.add_theme_stylebox_override("pressed", pressed_style)
    button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func setup_build_ui_layout() -> void:
    if build_button == null:
        return

    var viewport_size := get_viewport().get_visible_rect().size
    var margin: float = 12.0

    build_button.visible = true
    build_button.text = "Build"
    build_button.custom_minimum_size = Vector2(54, 16)
    build_button.size = Vector2(54, 16)
    build_button.position = Vector2(
        margin,
        viewport_size.y - build_button.size.y - margin
    )

    if build_menu == null:
        return

    build_menu.position = Vector2(
        margin,
        build_button.position.y - build_menu.size.y - 8.0
    )


func setup_build_menu_buttons() -> void:
    if build_menu == null:
        return

    clear_generated_build_buttons()

    if campfire_button != null:
        campfire_button.visible = false

    var unlocked_buildings: Array = RegionBuildingData.get_unlocked_buildings()

    var button_y: float = 8.0
    var button_margin: float = 8.0
    var button_height: float = 22.0
    var button_width: float = max(80.0, build_menu.size.x - button_margin * 2.0)

    for building_index in range(unlocked_buildings.size()):
        var building_variant: Variant = unlocked_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", "unknown"))

        var building_button := Button.new()
        building_button.name = "BuildButton_" + building_id
        building_button.text = get_building_button_text(building_data)
        building_button.position = Vector2(button_margin, button_y)
        building_button.size = Vector2(button_width, button_height)
        building_button.custom_minimum_size = Vector2(button_width, button_height)

        setup_building_button_theme(building_button)

        building_button.pressed.connect(
            Callable(self, "_on_generated_building_button_pressed").bind(building_id)
        )

        build_menu.add_child(building_button)
        generated_build_buttons.append(building_button)

        button_y += button_height + 6.0


func clear_generated_build_buttons() -> void:
    for button_index in range(generated_build_buttons.size()):
        var button_variant: Variant = generated_build_buttons[button_index]

        if button_variant is Node:
            var button_node: Node = button_variant
            button_node.queue_free()

    generated_build_buttons.clear()


func get_building_button_text(building_data: Dictionary) -> String:
    var building_name: String = str(building_data.get("name", "Unknown Building"))
    var cost_text: String = get_cost_text(building_data.get("cost", {}))

    if cost_text == "":
        return building_name

    return building_name + " - " + cost_text


func get_cost_text(cost_variant: Variant) -> String:
    if typeof(cost_variant) != TYPE_DICTIONARY:
        return ""

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
    if build_menu == null:
        push_warning("BuildMenu was not found.")
        return

    setup_build_menu_buttons()
    setup_build_ui_layout()

    build_menu.visible = not build_menu.visible

    print("Build Menu Visible: ", build_menu.visible)


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
