extends CanvasLayer

@onready var build_button: Button = get_node_or_null("BuildButton")
@onready var build_menu: Panel = get_node_or_null("BuildMenu")
@onready var campfire_button: Button = get_node_or_null("BuildMenu/CampfireButton")
@onready var region: Node2D = get_node_or_null("../Region")

var generated_build_buttons: Array = []
var generated_age_buttons: Array = []

var selected_build_age: String = ""


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

    # Later age buttons will be added here.
    # Example:
    # create_age_button("Copper Age", RegionBuildingData.AGE_COPPER, Vector2(90, 8))
    # create_age_button("Bronze Age", RegionBuildingData.AGE_BRONZE, Vector2(180, 8))


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
