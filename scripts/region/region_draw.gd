extends RefCounted
class_name RegionDraw


static func get_panel_border_width(world_per_screen_y: float) -> float:
    return max(1.0, 1.5 * world_per_screen_y)


static func get_button_border_width(world_per_screen_y: float) -> float:
    return max(1.0, 1.25 * world_per_screen_y)


static func get_small_border_width(world_per_screen_y: float) -> float:
    return max(1.0, 1.0 * world_per_screen_y)


static func get_title_font_size(world_per_screen_y: float) -> int:
    return int(max(10.0, 13.0 * world_per_screen_y))


static func get_body_font_size(world_per_screen_y: float) -> int:
    return int(max(9.0, 12.0 * world_per_screen_y))


static func get_small_font_size(world_per_screen_y: float) -> int:
    return int(max(8.0, 11.0 * world_per_screen_y))


static func get_tiny_font_size(world_per_screen_y: float) -> int:
    return int(max(7.0, 10.0 * world_per_screen_y))


static func draw_top_info_panel(
    node: CanvasItem,
    research_points: int,
    villager_count: int,
    available_shelter: int,
    show_resource_inventory_panel: bool,
    show_village_inventory_panel: bool,
    show_research_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_top_info_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(
        panel_rect,
        Color(0.05, 0.05, 0.05, 0.82),
        true
    )

    node.draw_rect(
        panel_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    var research_text := "Research: " + str(research_points)
    var villager_text := "Villagers: " + str(villager_count)
    var shelter_text := "Shelter: " + str(available_shelter) + " open"

    var font_size: int = int(max(10.0, 14.0 * world_per_screen_y))
    var small_font_size: int = int(max(9.0, 12.0 * world_per_screen_y))

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 22)
        ),
        research_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(126, 22)
        ),
        villager_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(126, 44)
        ),
        shelter_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    draw_resources_button(
        node,
        show_resource_inventory_panel
    )

    draw_inventory_button(
        node,
        show_village_inventory_panel
    )

    draw_research_button(
        node,
        show_research_panel
    )


static func draw_resources_button(
    node: CanvasItem,
    show_resource_inventory_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_resources_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_resource_inventory_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 16)
        ),
        "Resources",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_inventory_button(
    node: CanvasItem,
    show_village_inventory_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_inventory_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_village_inventory_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 16)
        ),
        "Inventory",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_research_button(
    node: CanvasItem,
    show_research_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_research_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_research_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 16)
        ),
        "Research",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_build_button(
    node: CanvasItem,
    show_build_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_build_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_build_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 16)
        ),
        "Build",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_resource_inventory_panel(
    node: CanvasItem,
    visible_resources: Array,
    resource_amounts: Dictionary,
    resource_caps: Dictionary
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_resource_list_panel_screen_rect(
        node.get_viewport().get_visible_rect().size,
        visible_resources.size()
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.92), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        "Village Resources",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if visible_resources.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 44)
            ),
            "No stored resources",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    for resource_index in range(visible_resources.size()):
        var resource_name: String = str(visible_resources[resource_index])
        var current_amount: int = int(resource_amounts.get(resource_name, 0))
        var resource_cap: int = int(resource_caps.get(resource_name, 0))
        var resource_text := resource_name + ": " + str(current_amount) + "/" + str(resource_cap)

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(
                    10,
                    44 + resource_index * RegionUI.RESOURCE_LIST_ROW_HEIGHT
                )
            ),
            resource_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )


static func draw_village_inventory_panel(
    node: CanvasItem,
    visible_items: Array
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_village_inventory_panel_screen_rect(
        node.get_viewport().get_visible_rect().size,
        visible_items.size()
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.92), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        "Village Inventory",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if visible_items.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 44)
            ),
            "No crafted items",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    for item_index in range(visible_items.size()):
        var item_data: Dictionary = visible_items[item_index]
        var item_name: String = str(item_data.get("name", "Unknown Item"))
        var category: String = str(item_data.get("category", RegionItemInventory.CATEGORY_MISC))
        var amount: int = int(item_data.get("amount", 0))

        var item_text := "[" + category + "] " + item_name + ": " + str(amount)

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(
                    10,
                    44 + item_index * RegionUI.INVENTORY_LIST_ROW_HEIGHT
                )
            ),
            item_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )


static func draw_research_panel(
    node: CanvasItem,
    buyable_plans: Array
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_research_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        "Available Research",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if buyable_plans.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 48)
            ),
            "No affordable research available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_rows: int = int(floor(float(RegionUI.RESEARCH_PANEL_HEIGHT - 44) / float(RegionUI.RESEARCH_ROW_HEIGHT)))
    var visible_count: int = min(buyable_plans.size(), max_rows)

    for plan_index in range(visible_count):
        var plan: Dictionary = buyable_plans[plan_index]

        var plan_button_screen_rect: Rect2 = RegionUI.get_research_plan_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            plan_index
        )

        var plan_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
            node,
            plan_button_screen_rect
        )

        node.draw_rect(plan_button_world_rect, Color(0.12, 0.10, 0.07, 0.95), true)

        node.draw_rect(
            plan_button_world_rect,
            Color(0.65, 0.55, 0.32, 0.95),
            false,
            get_small_border_width(world_per_screen_y)
        )

        var plan_name: String = str(plan.get("name", "Research"))
        var plan_cost: int = int(plan.get("cost", 0))
        var plan_text: String = plan_name + " — " + str(plan_cost) + " Research"

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                plan_button_screen_rect.position + Vector2(8, 20)
            ),
            plan_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_small_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )


static func draw_build_panel(
    node: CanvasItem,
    build_ages: Array,
    selected_build_age: String,
    build_categories: Array,
    selected_build_category: String,
    unlocked_buildings: Array
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_build_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        "Build",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    draw_build_age_buttons(
        node,
        build_ages,
        selected_build_age
    )

    draw_build_category_buttons(
        node,
        build_categories,
        selected_build_category
    )

    if unlocked_buildings.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, RegionUI.BUILD_LIST_START_Y + 20)
            ),
            "No buildings unlocked in this category.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var visible_count: int = min(
        unlocked_buildings.size(),
        RegionUI.get_build_visible_row_count()
    )

    for building_index in range(visible_count):
        draw_building_button_row(
            node,
            unlocked_buildings[building_index],
            building_index
        )


static func draw_build_age_buttons(
    node: CanvasItem,
    build_ages: Array,
    selected_build_age: String
) -> void:
    for age_index in range(build_ages.size()):
        var age_data: Dictionary = build_ages[age_index]
        var age_id: String = str(age_data.get("id", ""))
        var age_name: String = str(age_data.get("name", age_id))

        var age_button_screen_rect: Rect2 = RegionUI.get_build_age_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            age_index,
            build_ages.size()
        )

        draw_build_filter_button(
            node,
            age_button_screen_rect,
            age_name,
            age_id == selected_build_age
        )


static func draw_build_category_buttons(
    node: CanvasItem,
    build_categories: Array,
    selected_build_category: String
) -> void:
    for category_index in range(build_categories.size()):
        var category_data: Dictionary = build_categories[category_index]
        var category_id: String = str(category_data.get("id", ""))
        var category_name: String = str(category_data.get("name", category_id))

        var category_button_screen_rect: Rect2 = RegionUI.get_build_category_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            category_index,
            build_categories.size()
        )

        draw_build_filter_button(
            node,
            category_button_screen_rect,
            category_name,
            category_id == selected_build_category
        )


static func draw_build_filter_button(
    node: CanvasItem,
    button_screen_rect: Rect2,
    label: String,
    is_selected: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var fill_color := Color(0.12, 0.10, 0.07, 0.95)
    var border_color := Color(0.65, 0.55, 0.32, 0.95)

    if is_selected:
        fill_color = Color(0.32, 0.24, 0.10, 0.98)
        border_color = Color(1.0, 0.86, 0.42, 1.0)

    node.draw_rect(button_world_rect, fill_color, true)

    node.draw_rect(
        button_world_rect,
        border_color,
        false,
        get_small_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 17)
        ),
        label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_building_button_row(
    node: CanvasItem,
    building_data: Dictionary,
    building_index: int
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var building_button_screen_rect: Rect2 = RegionUI.get_building_button_screen_rect(
        node.get_viewport().get_visible_rect().size,
        building_index
    )

    var building_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        building_button_screen_rect
    )

    node.draw_rect(building_button_world_rect, Color(0.12, 0.10, 0.07, 0.95), true)

    node.draw_rect(
        building_button_world_rect,
        Color(0.65, 0.55, 0.32, 0.95),
        false,
        get_small_border_width(world_per_screen_y)
    )

    var building_name: String = str(building_data.get("name", "Building"))
    var resource_cost_text: String = get_resource_cost_text(building_data.get("cost", {}))
    var item_cost_text: String = get_item_cost_text(building_data.get("item_cost", {}))

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            building_button_screen_rect.position + Vector2(8, 14)
        ),
        building_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )

    var cost_line: String = "Cost: " + resource_cost_text

    if item_cost_text != "Free":
        cost_line += " | Items: " + item_cost_text

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            building_button_screen_rect.position + Vector2(8, 29)
        ),
        cost_line,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(0.88, 0.88, 0.88, 1.0)
    )


static func draw_crafting_panel(
    node: CanvasItem,
    selected_crafting_building_name: String,
    selected_crafting_building_id: String,
    craftable_recipes: Array,
    crafting: RegionCrafting
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_crafting_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        selected_crafting_building_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if craftable_recipes.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 48)
            ),
            "No affordable recipes available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_rows: int = int(floor(float(RegionUI.CRAFTING_PANEL_HEIGHT - 44) / float(RegionUI.CRAFTING_ROW_HEIGHT)))
    var visible_count: int = min(craftable_recipes.size(), max_rows)

    for recipe_index in range(visible_count):
        var recipe: Dictionary = craftable_recipes[recipe_index]

        var recipe_button_screen_rect: Rect2 = RegionUI.get_crafting_recipe_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            recipe_index
        )

        var recipe_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
            node,
            recipe_button_screen_rect
        )

        node.draw_rect(recipe_button_world_rect, Color(0.12, 0.10, 0.07, 0.95), true)

        node.draw_rect(
            recipe_button_world_rect,
            Color(0.65, 0.55, 0.32, 0.95),
            false,
            get_small_border_width(world_per_screen_y)
        )

        var recipe_id: String = str(recipe.get("id", ""))
        var recipe_name: String = str(recipe.get("name", "Recipe"))
        var cost_text: String = crafting.get_recipe_cost_text(recipe_id)
        var output_text: String = crafting.get_recipe_output_text(recipe_id)

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                recipe_button_screen_rect.position + Vector2(8, 16)
            ),
            recipe_name,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_small_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                recipe_button_screen_rect.position + Vector2(8, 32)
            ),
            "Cost: " + cost_text + "  ->  " + output_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_tiny_font_size(world_per_screen_y),
            Color(0.88, 0.88, 0.88, 1.0)
        )


static func draw_assignment_panel(
    node: CanvasItem,
    selected_assignment_building: Dictionary,
    assigned_villager_data: Array,
    assignable_villagers: Array
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_assignment_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    if selected_assignment_building.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 22)
            ),
            "Assignment",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_title_font_size(world_per_screen_y),
            Color(1.0, 0.95, 0.75, 1.0)
        )
        return

    var building_name: String = str(selected_assignment_building.get("name", "Building"))
    var assignment_role: String = str(selected_assignment_building.get("assignment_role", ""))
    var assignment_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assignment_role)
    var assignment_slots: int = int(selected_assignment_building.get("assignment_slots", 0))
    var assigned_villagers: Array = selected_assignment_building.get("assigned_villagers", [])
    var assignment_count: int = assigned_villagers.size()
    var replaces_shelter: bool = bool(selected_assignment_building.get("assignment_replaces_shelter", false))

    var shelter_text: String = "Shelter: Does not replace normal shelter"

    if replaces_shelter:
        shelter_text = "Shelter: Replaces normal shelter"

    var assigned_names_text: String = get_assigned_villager_names_text(assigned_villager_data)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        building_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 42)
        ),
        "Role: " + assignment_role_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(0.90, 0.95, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 60)
        ),
        "Slots: " + str(assignment_count) + " / " + str(assignment_slots),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(0.90, 0.95, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 78)
        ),
        shelter_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        Color(0.88, 0.88, 0.88, 1.0)
    )

    if assignment_count > 0 and assigned_names_text != "":
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 94)
            ),
            "Assigned: " + assigned_names_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_small_font_size(world_per_screen_y),
            Color(0.90, 0.95, 1.0, 1.0)
        )

    if assignment_count >= assignment_slots:
        if assigned_villager_data.is_empty():
            node.draw_string(
                ThemeDB.fallback_font,
                RegionUI.screen_position_to_world_position(
                    node,
                    panel_screen_rect.position + Vector2(10, RegionUI.ASSIGNMENT_LIST_START_Y + 38)
                ),
                "No open assignment slots.",
                HORIZONTAL_ALIGNMENT_LEFT,
                -1,
                get_body_font_size(world_per_screen_y),
                Color(0.85, 0.85, 0.85, 1.0)
            )
            return

        var assigned_visible_count: int = min(
            assigned_villager_data.size(),
            RegionUI.get_assignment_visible_row_count()
        )

        for assigned_index in range(assigned_visible_count):
            draw_assignment_villager_row(
                node,
                assigned_villager_data[assigned_index],
                assigned_index
            )

        return

    if assignable_villagers.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, RegionUI.ASSIGNMENT_LIST_START_Y + 20)
            ),
            "No compatible unassigned villagers available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var visible_count: int = min(
        assignable_villagers.size(),
        RegionUI.get_assignment_visible_row_count()
    )

    for villager_index in range(visible_count):
        draw_assignment_villager_row(
            node,
            assignable_villagers[villager_index],
            villager_index
        )


static func get_assigned_villager_names_text(assigned_villager_data: Array) -> String:
    if assigned_villager_data.is_empty():
        return ""

    var name_parts: Array = []

    for villager_index in range(assigned_villager_data.size()):
        var villager_variant: Variant = assigned_villager_data[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var villager_name: String = str(villager_data.get("name", "Villager"))

        if villager_name == "":
            continue

        name_parts.append(villager_name)

    return ", ".join(name_parts)


static func draw_assignment_villager_row(
    node: CanvasItem,
    villager_data: Dictionary,
    villager_index: int
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var villager_button_screen_rect: Rect2 = RegionUI.get_assignment_villager_button_screen_rect(
        node.get_viewport().get_visible_rect().size,
        villager_index
    )

    var villager_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        villager_button_screen_rect
    )

    node.draw_rect(villager_button_world_rect, Color(0.12, 0.10, 0.07, 0.95), true)

    node.draw_rect(
        villager_button_world_rect,
        Color(0.65, 0.55, 0.32, 0.95),
        false,
        get_small_border_width(world_per_screen_y)
    )

    var villager_name: String = str(villager_data.get("name", "Villager"))
    var level: int = int(villager_data.get("level", 0))
    var speed: int = int(villager_data.get("speed", 100))
    var health: int = int(villager_data.get("health", 5))
    var max_health: int = int(villager_data.get("max_health", 5))
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(role)
    var skills: Dictionary = villager_data.get("skills", {})

    var top_line: String = (
        villager_name
        + " — "
        + role_name
        + " — Lv "
        + str(level)
    )

    var stat_line: String = (
        "Health "
        + str(health)
        + "/"
        + str(max_health)
        + " | Speed "
        + str(speed)
        + " | Gather "
        + str(int(skills.get(VillagerManager.SKILL_GATHERING, 0)))
        + " | Build "
        + str(int(skills.get(VillagerManager.SKILL_BUILDING, 0)))
        + " | Mine "
        + str(int(skills.get(VillagerManager.SKILL_MINING, 0)))
        + " | WoodCut "
        + str(int(skills.get(VillagerManager.SKILL_WOODCUTTING, 0)))
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            villager_button_screen_rect.position + Vector2(8, 14)
        ),
        top_line,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            villager_button_screen_rect.position + Vector2(8, 29)
        ),
        stat_line,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(0.88, 0.88, 0.88, 1.0)
    )


static func draw_village_log_button(
    node: CanvasItem,
    show_village_log_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_village_log_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

    if show_village_log_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(0.95, 0.82, 0.45, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(12, 18)
        ),
        "Village Log",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_village_log_panel(
    node: CanvasItem,
    show_village_log_panel: bool,
    village_log_messages: Array
) -> void:
    if not show_village_log_panel:
        return

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_village_log_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        "Village Log",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if village_log_messages.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, 46)
            ),
            "No events yet.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var max_visible_rows: int = int(floor(float(RegionUI.VILLAGE_LOG_PANEL_HEIGHT - 44) / float(RegionUI.VILLAGE_LOG_ROW_HEIGHT)))
    var start_index: int = max(0, village_log_messages.size() - max_visible_rows)

    var draw_row: int = 0

    for message_index in range(start_index, village_log_messages.size()):
        var message_text: String = str(village_log_messages[message_index])

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(
                    10,
                    46 + draw_row * RegionUI.VILLAGE_LOG_ROW_HEIGHT
                )
            ),
            message_text,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_small_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )

        draw_row += 1


static func draw_villager_hover_panel(
    node: CanvasItem,
    villager_data: Dictionary
) -> void:
    var mouse_screen_position: Vector2 = node.get_viewport().get_mouse_position()
    var panel_screen_position: Vector2 = mouse_screen_position + RegionUI.VILLAGER_HOVER_PANEL_OFFSET

    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size

    if panel_screen_position.x + RegionUI.VILLAGER_HOVER_PANEL_WIDTH > viewport_size.x:
        panel_screen_position.x = mouse_screen_position.x - RegionUI.VILLAGER_HOVER_PANEL_WIDTH - RegionUI.VILLAGER_HOVER_PANEL_OFFSET.x

    if panel_screen_position.y + RegionUI.VILLAGER_HOVER_PANEL_HEIGHT > viewport_size.y:
        panel_screen_position.y = mouse_screen_position.y - RegionUI.VILLAGER_HOVER_PANEL_HEIGHT - RegionUI.VILLAGER_HOVER_PANEL_OFFSET.y

    var panel_screen_rect := Rect2(
        panel_screen_position,
        Vector2(
            RegionUI.VILLAGER_HOVER_PANEL_WIDTH,
            RegionUI.VILLAGER_HOVER_PANEL_HEIGHT
        )
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.94), true)

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    draw_villager_hover_panel_text(
        node,
        villager_data,
        panel_screen_rect
    )


static func draw_villager_hover_panel_text(
    node: CanvasItem,
    villager_data: Dictionary,
    panel_screen_rect: Rect2
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var title_font_size: int = get_title_font_size(world_per_screen_y)
    var body_font_size: int = get_small_font_size(world_per_screen_y)

    var villager_name: String = str(villager_data.get("name", "Villager"))
    var gender: String = str(villager_data.get("gender", "unknown"))
    var level: int = int(villager_data.get("level", 0))
    var speed: int = int(villager_data.get("speed", 100))
    var health: int = int(villager_data.get("health", 5))
    var max_health: int = int(villager_data.get("max_health", 5))
    var hunger: int = int(villager_data.get("hunger", 100))
    var health_state: String = str(villager_data.get("health_state", "healthy"))
    var current_state: String = str(villager_data.get("state", "idle"))
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(role)
    var assigned_role: String = str(villager_data.get("assigned_building_role", ""))
    var assigned_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assigned_role)
    var assigned_building_instance_id: int = int(villager_data.get("assigned_building_instance_id", 0))
    var is_housed: bool = bool(villager_data.get("is_housed", false))
    var housed_text: String = "Housed"

    if not is_housed:
        housed_text = "Unhoused"

    var belongings: Array = villager_data.get("belongings", [])
    var belonging_slots: int = int(villager_data.get("belonging_slots", villager_data.get("max_belongings", 1)))
    var tool_slots: int = int(villager_data.get("tool_slots", 0))
    var weapon_slots: int = int(villager_data.get("weapon_slots", 0))
    var armor_slots: int = int(villager_data.get("armor_slots", 0))

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

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        villager_name + " (" + gender + ")",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Role: " + role_name + "    Level: " + str(level),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Speed: " + str(speed) + "    Health: " + str(health) + "/" + str(max_health),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Hunger: " + str(hunger) + "/100    Condition: " + health_state,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "State: " + current_state + "    " + housed_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    var assigned_line: String = "Assigned: None"

    if assigned_role != "":
        assigned_line = (
            "Assigned: "
            + assigned_role_name
            + " / Building #"
            + str(assigned_building_instance_id)
        )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        assigned_line,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Slots: Belong " + str(belongings.size()) + "/" + str(belonging_slots) + " | Tool " + str(tool_slots) + " | Weapon " + str(weapon_slots) + " | Armor " + str(armor_slots),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Statuses: " + statuses_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 20.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Core Skills",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 15.0

    draw_villager_skill_line(node, "Gathering", int(skills.get(VillagerManager.SKILL_GATHERING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line(node, "Building", int(skills.get(VillagerManager.SKILL_BUILDING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line(node, "Mining", int(skills.get(VillagerManager.SKILL_MINING, 0)), text_x, text_y, body_font_size)
    text_y += 14.0
    draw_villager_skill_line(node, "WoodCutting", int(skills.get(VillagerManager.SKILL_WOODCUTTING, 0)), text_x, text_y, body_font_size)

    text_y += 18.0

    text_y = draw_villager_existing_skill_group(
        node,
        "Role Skills",
        [
            {
                "label": "Crafting",
                "key": VillagerManager.SKILL_CRAFTING
            },
            {
                "label": "Thinking",
                "key": VillagerManager.SKILL_THINKING
            },
            {
                "label": "Stoneworking",
                "key": VillagerManager.SKILL_STONEWORKING
            },
            {
                "label": "Woodworking",
                "key": VillagerManager.SKILL_WOODWORKING
            },
            {
                "label": "Rituals",
                "key": VillagerManager.SKILL_RITUALS
            }
        ],
        skills,
        text_x,
        text_y,
        body_font_size
    )

    var has_combat_stats: bool = villager_data.has("attack") or villager_data.has("defense")
    var has_combat_skills: bool = (
        skills.has(VillagerManager.SKILL_RANGED_WEAPONS)
        or skills.has(VillagerManager.SKILL_MELEE_WEAPONS)
        or skills.has(VillagerManager.SKILL_EVADE)
        or skills.has(VillagerManager.SKILL_PARRY)
    )

    if has_combat_stats or has_combat_skills:
        text_y += 18.0

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
            "Combat",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            body_font_size,
            Color(1.0, 0.95, 0.75, 1.0)
        )

        text_y += 15.0

        if has_combat_stats:
            var attack_text: String = "-"

            if villager_data.has("attack"):
                attack_text = str(int(villager_data.get("attack", 0)))

            var defense_text: String = "-"

            if villager_data.has("defense"):
                defense_text = str(int(villager_data.get("defense", 0)))

            node.draw_string(
                ThemeDB.fallback_font,
                RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
                "Attack: " + attack_text + "    Defense: " + defense_text,
                HORIZONTAL_ALIGNMENT_LEFT,
                -1,
                body_font_size,
                Color(1.0, 1.0, 1.0, 1.0)
            )

            text_y += 14.0

        if skills.has(VillagerManager.SKILL_RANGED_WEAPONS):
            draw_villager_skill_line(node, "Ranged Weapons", int(skills.get(VillagerManager.SKILL_RANGED_WEAPONS, 0)), text_x, text_y, body_font_size)
            text_y += 14.0

        if skills.has(VillagerManager.SKILL_MELEE_WEAPONS):
            draw_villager_skill_line(node, "Melee Weapons", int(skills.get(VillagerManager.SKILL_MELEE_WEAPONS, 0)), text_x, text_y, body_font_size)
            text_y += 14.0

        if skills.has(VillagerManager.SKILL_EVADE):
            draw_villager_skill_line(node, "Evade", int(skills.get(VillagerManager.SKILL_EVADE, 0)), text_x, text_y, body_font_size)
            text_y += 14.0

        if skills.has(VillagerManager.SKILL_PARRY):
            draw_villager_skill_line(node, "Parry", int(skills.get(VillagerManager.SKILL_PARRY, 0)), text_x, text_y, body_font_size)
            text_y += 14.0


static func draw_villager_existing_skill_group(
    node: CanvasItem,
    group_label: String,
    skill_entries: Array,
    skills: Dictionary,
    text_x: float,
    text_y: float,
    font_size: int
) -> float:
    var existing_entries: Array = []

    for entry_index in range(skill_entries.size()):
        var entry: Dictionary = skill_entries[entry_index]
        var skill_key: String = str(entry.get("key", ""))

        if skill_key == "":
            continue

        if not skills.has(skill_key):
            continue

        existing_entries.append(entry)

    if existing_entries.is_empty():
        return text_y

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        group_label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 15.0

    for entry_index in range(existing_entries.size()):
        var entry: Dictionary = existing_entries[entry_index]
        var skill_label: String = str(entry.get("label", "Skill"))
        var skill_key: String = str(entry.get("key", ""))

        draw_villager_skill_line(
            node,
            skill_label,
            int(skills.get(skill_key, 0)),
            text_x,
            text_y,
            font_size
        )

        text_y += 14.0

    return text_y


static func draw_villager_skill_line(
    node: CanvasItem,
    skill_label: String,
    skill_value: int,
    text_x: float,
    text_y: float,
    font_size: int
) -> void:
    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        skill_label + ": " + str(skill_value),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_storage_selector(
    node: CanvasItem,
    storage_selector_open: bool,
    selector_origin: Vector2,
    storage_selector_options: Array,
    button_width: int,
    button_height: int,
    button_gap: int
) -> void:
    if not storage_selector_open:
        return

    for option_index in range(storage_selector_options.size()):
        var resource_name: String = str(storage_selector_options[option_index])

        var option_position := selector_origin + Vector2(
            0,
            option_index * (button_height + button_gap)
        )

        var option_rect := Rect2(
            option_position,
            Vector2(
                button_width,
                button_height
            )
        )

        node.draw_rect(option_rect, Color(0.08, 0.07, 0.05, 0.92), true)

        node.draw_rect(
            option_rect,
            Color(0.95, 0.82, 0.45, 1.0),
            false,
            1.5
        )

        node.draw_string(
            ThemeDB.fallback_font,
            option_position + Vector2(6, 15),
            resource_name,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            14,
            Color(1.0, 1.0, 1.0, 1.0)
        )


static func draw_debug_button(
    node: CanvasItem,
    show_debug_panel: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_screen_rect: Rect2 = RegionUI.get_debug_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var button_fill_color := Color(0.13, 0.08, 0.08, 0.95)

    if show_debug_panel:
        button_fill_color = Color(0.35, 0.12, 0.10, 0.98)

    node.draw_rect(button_world_rect, button_fill_color, true)

    node.draw_rect(
        button_world_rect,
        Color(1.0, 0.45, 0.35, 1.0),
        false,
        get_button_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(12, 18)
        ),
        "Debug",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_body_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func draw_debug_panel(
    node: CanvasItem,
    show_debug_panel: bool
) -> void:
    if not show_debug_panel:
        return

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var panel_screen_rect: Rect2 = RegionUI.get_debug_panel_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    node.draw_rect(panel_world_rect, Color(0.045, 0.025, 0.025, 0.96), true)

    node.draw_rect(
        panel_world_rect,
        Color(1.0, 0.45, 0.35, 1.0),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 20)
        ),
        RegionDebugPanel.DEBUG_PANEL_TITLE,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.85, 0.78, 1.0)
    )

    var actions: Array = RegionDebugPanel.get_actions()

    for action_index in range(actions.size()):
        var action_data: Dictionary = actions[action_index]
        var action_label: String = str(action_data.get("label", "Action"))

        var button_screen_rect: Rect2 = RegionUI.get_debug_action_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            action_index
        )

        var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
            node,
            button_screen_rect
        )

        node.draw_rect(button_world_rect, Color(0.14, 0.08, 0.07, 0.98), true)

        node.draw_rect(
            button_world_rect,
            Color(0.85, 0.35, 0.28, 1.0),
            false,
            get_small_border_width(world_per_screen_y)
        )

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                button_screen_rect.position + Vector2(8, 19)
            ),
            action_label,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_small_font_size(world_per_screen_y),
            Color(1.0, 1.0, 1.0, 1.0)
        )


static func get_resource_cost_text(cost_variant: Variant) -> String:
    if typeof(cost_variant) != TYPE_DICTIONARY:
        return "Free"

    var cost: Dictionary = cost_variant

    if cost.is_empty():
        return "Free"

    var parts: Array = []
    var resource_names: Array = cost.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name: String = str(resource_names[resource_index])
        var amount: int = int(cost.get(resource_name, 0))

        if amount <= 0:
            continue

        parts.append(resource_name + " " + str(amount))

    if parts.is_empty():
        return "Free"

    return ", ".join(parts)


static func get_item_cost_text(item_cost_variant: Variant) -> String:
    if typeof(item_cost_variant) != TYPE_DICTIONARY:
        return "Free"

    var item_cost: Dictionary = item_cost_variant

    if item_cost.is_empty():
        return "Free"

    var parts: Array = []
    var item_ids: Array = item_cost.keys()
    item_ids.sort()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var amount: int = int(item_cost.get(item_id, 0))

        if amount <= 0:
            continue

        parts.append(get_item_display_name(item_id) + " " + str(amount))

    if parts.is_empty():
        return "Free"

    return ", ".join(parts)


static func get_item_display_name(item_id: String) -> String:
    if item_id == RegionRecipeData.ITEM_POINTED_STICK:
        return "Pointed Stick"

    if item_id == RegionRecipeData.ITEM_SIMPLE_HAND_AXE:
        return "Simple Hand Axe"

    if item_id == RegionRecipeData.ITEM_SHARP_STONE_KNIFE:
        return "Sharp Stone Knife"

    if item_id == RegionRecipeData.ITEM_CRUDE_CONTAINER:
        return "Crude Container"

    if item_id == RegionRecipeData.ITEM_SLING:
        return "Sling"

    if item_id == RegionRecipeData.ITEM_HERBAL_POULTICE:
        return "Herbal Poultice"

    if item_id == RegionRecipeData.ITEM_THROWING_SPEAR:
        return "Throwing Spear"

    if item_id == RegionRecipeData.ITEM_STONE_TIPPED_SPEAR:
        return "Stone-Tipped Spear"

    if item_id == RegionRecipeData.ITEM_STONE_CLUB:
        return "Stone Club"

    if item_id == RegionRecipeData.ITEM_STONE_SCRAPER:
        return "Stone Scraper"

    if item_id == RegionRecipeData.ITEM_WORKED_HAND_AXE:
        return "Worked Hand Axe"

    if item_id == RegionRecipeData.ITEM_DRAG_SLED:
        return "Drag Sled"

    if item_id == RegionRecipeData.ITEM_TENT_KIT:
        return "Tent Kit"

    if item_id == RegionRecipeData.ITEM_ADVANCED_SLING:
        return "Advanced Sling"

    if item_id == RegionRecipeData.ITEM_FLINT_TIPPED_HUNTING_SPEAR:
        return "Flint-Tipped Hunting Spear"

    if item_id == RegionRecipeData.ITEM_FLINT_EDGED_HAND_AXE:
        return "Flint-Edged Hand Axe"

    if item_id == RegionRecipeData.ITEM_FLINT_EDGED_WOODSMAN_AXE:
        return "Flint-Edged Woodsman Axe"

    if item_id == RegionRecipeData.ITEM_FLINT_TIPPED_MINING_PICK:
        return "Flint-Tipped Mining Pick"

    return item_id.capitalize()
