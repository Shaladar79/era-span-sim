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

static func get_display_amount(amount: float) -> String:
    if is_equal_approx(amount, round(amount)):
        return str(int(round(amount)))

    return "%.1f" % amount

static func draw_top_info_panel(
    node: CanvasItem,
    research_points: float,
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

    var panel_border_width: float = max(1.0, 1.5 * world_per_screen_y)
    var button_border_width: float = max(1.0, 1.25 * world_per_screen_y)

    var title_font_size: int = int(max(10.0, 13.0 * world_per_screen_y))
    var font_size: int = int(max(10.0, 14.0 * world_per_screen_y))
    var small_font_size: int = int(max(9.0, 12.0 * world_per_screen_y))
    var button_font_size: int = int(max(9.0, 12.0 * world_per_screen_y))

    node.draw_rect(
        panel_rect,
        Color(0.05, 0.05, 0.05, 0.82),
        true
    )

    node.draw_rect(
        panel_rect,
        Color(0.85, 0.75, 0.45, 0.95),
        false,
        panel_border_width
    )

    var settlement_name: String = "New Settlement"

    if node.has_method("get_region_name"):
        settlement_name = str(node.call("get_region_name")).strip_edges()

    if settlement_name == "":
        settlement_name = "New Settlement"

    var ideas_text := "Ideas: " + get_display_amount(research_points)
    var villager_text := "Villagers: " + str(villager_count)
    var shelter_text := "Shelter: " + str(available_shelter) + " open"

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 18)
        ),
        settlement_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 40)
        ),
        ideas_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(126, 40)
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
            panel_screen_rect.position + Vector2(126, 62)
        ),
        shelter_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    var resources_button_screen_rect: Rect2 = RegionUI.get_resources_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var inventory_button_screen_rect: Rect2 = RegionUI.get_inventory_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var research_button_screen_rect: Rect2 = RegionUI.get_research_button_screen_rect(
        node.get_viewport().get_visible_rect().size
    )

    var button_data: Array = [
        {
            "rect": resources_button_screen_rect,
            "label": "Resources",
            "active": show_resource_inventory_panel
        },
        {
            "rect": inventory_button_screen_rect,
            "label": "Inventory",
            "active": show_village_inventory_panel
        },
        {
            "rect": research_button_screen_rect,
            "label": "Ideas",
            "active": show_research_panel
        }
    ]

    for button_index in range(button_data.size()):
        var button_entry: Dictionary = button_data[button_index]
        var button_screen_rect: Rect2 = button_entry.get("rect", Rect2())
        var button_label: String = str(button_entry.get("label", "Button"))
        var is_active: bool = bool(button_entry.get("active", false))

        var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
            node,
            button_screen_rect
        )

        var button_fill_color := Color(0.16, 0.13, 0.08, 0.95)

        if is_active:
            button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

        node.draw_rect(
            button_world_rect,
            button_fill_color,
            true
        )

        node.draw_rect(
            button_world_rect,
            Color(0.95, 0.82, 0.45, 1.0),
            false,
            button_border_width
        )

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                button_screen_rect.position + Vector2(8, 16)
            ),
            button_label,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            button_font_size,
            Color(1.0, 1.0, 1.0, 1.0)
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
        "Ideas",
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
    research_categories: Array,
    selected_research_category: String,
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
        "Available Ideas",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_title_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.75, 1.0)
    )

    draw_research_category_buttons(
        node,
        research_categories,
        selected_research_category
    )

    if buyable_plans.is_empty():
        var selected_category_name: String = StoneAgeResearchData.get_research_category_name(
            selected_research_category
        )

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, RegionUI.RESEARCH_LIST_START_Y + 20)
            ),
            "No affordable " + selected_category_name + " ideas available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var visible_count: int = min(
        buyable_plans.size(),
        RegionUI.get_research_visible_row_count()
    )

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

        var plan_name: String = str(plan.get("name", "Idea"))
        var plan_cost: int = int(plan.get("cost", 0))
        var plan_text: String = plan_name + " — " + str(plan_cost) + " Ideas"

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

static func draw_research_category_buttons(
    node: CanvasItem,
    research_categories: Array,
    selected_research_category: String
) -> void:
    for category_index in range(research_categories.size()):
        var category_data: Dictionary = research_categories[category_index]
        var category_id: String = str(category_data.get("id", ""))
        var category_name: String = str(category_data.get("name", category_id))

        var category_button_screen_rect: Rect2 = RegionUI.get_research_category_button_screen_rect(
            node.get_viewport().get_visible_rect().size,
            category_index,
            research_categories.size()
        )

        draw_research_filter_button(
            node,
            category_button_screen_rect,
            category_name,
            category_id == selected_research_category
        )

static func draw_research_filter_button(
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
            button_screen_rect.position + Vector2(5, 16)
        ),
        label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(1.0, 1.0, 1.0, 1.0)
    )

static func draw_build_panel(
    node: CanvasItem,
    build_ages: Array,
    selected_build_age: String,
    build_categories: Array,
    selected_build_category: String,
    unlocked_buildings: Array,
    build_list_scroll_index: int
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

    var visible_row_count: int = RegionUI.get_build_visible_row_count()
    var max_scroll_index: int = max(0, unlocked_buildings.size() - visible_row_count)
    var safe_scroll_index: int = clampi(
        build_list_scroll_index,
        0,
        max_scroll_index
    )

    var visible_count: int = min(
        visible_row_count,
        unlocked_buildings.size() - safe_scroll_index
    )

    for visible_index in range(visible_count):
        var actual_building_index: int = safe_scroll_index + visible_index

        if actual_building_index < 0:
            continue

        if actual_building_index >= unlocked_buildings.size():
            continue

        draw_building_button_row(
            node,
            unlocked_buildings[actual_building_index],
            visible_index
        )

    draw_build_scroll_buttons(
        node,
        safe_scroll_index,
        max_scroll_index,
        unlocked_buildings.size(),
        visible_row_count
    )
    
static func draw_build_scroll_buttons(
    node: CanvasItem,
    build_list_scroll_index: int,
    max_scroll_index: int,
    total_buildings: int,
    visible_row_count: int
) -> void:
    if total_buildings <= visible_row_count:
        return

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size

    var up_button_screen_rect: Rect2 = RegionUI.get_build_scroll_up_button_screen_rect(
        viewport_size
    )

    var down_button_screen_rect: Rect2 = RegionUI.get_build_scroll_down_button_screen_rect(
        viewport_size
    )

    draw_build_scroll_button(
        node,
        up_button_screen_rect,
        "Up",
        build_list_scroll_index > 0
    )

    draw_build_scroll_button(
        node,
        down_button_screen_rect,
        "Down",
        build_list_scroll_index < max_scroll_index
    )

    var panel_screen_rect: Rect2 = RegionUI.get_build_panel_screen_rect(viewport_size)
    var range_start: int = build_list_scroll_index + 1
    var range_end: int = min(total_buildings, build_list_scroll_index + visible_row_count)

    var range_text: String = str(range_start) + "-" + str(range_end) + " / " + str(total_buildings)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, RegionUI.BUILD_PANEL_HEIGHT - 13)
        ),
        range_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(0.88, 0.88, 0.82, 1.0)
    )
    
static func draw_build_scroll_button(
    node: CanvasItem,
    button_screen_rect: Rect2,
    label: String,
    is_enabled: bool
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var fill_color := Color(0.12, 0.10, 0.07, 0.95)
    var border_color := Color(0.65, 0.55, 0.32, 0.95)
    var text_color := Color(1.0, 1.0, 1.0, 1.0)

    if not is_enabled:
        fill_color = Color(0.07, 0.065, 0.055, 0.80)
        border_color = Color(0.28, 0.25, 0.18, 0.90)
        text_color = Color(0.45, 0.45, 0.42, 1.0)

    node.draw_rect(
        button_world_rect,
        fill_color,
        true
    )

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
            button_screen_rect.position + Vector2(9, 15)
        ),
        label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        text_color
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
    recipe_rows: Array
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

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_screen_rect.position + Vector2(10, 42)
        ),
        "Known recipes for: " + selected_crafting_building_id,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        Color(0.80, 0.86, 0.92, 1.0)
    )

    if recipe_rows.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_screen_rect.position + Vector2(10, RegionUI.CRAFTING_LIST_START_Y + 20)
            ),
            "No known recipes yet. Research more plans.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            get_body_font_size(world_per_screen_y),
            Color(0.85, 0.85, 0.85, 1.0)
        )
        return

    var visible_count: int = min(
        recipe_rows.size(),
        RegionUI.get_crafting_visible_row_count()
    )

    for recipe_index in range(visible_count):
        draw_crafting_recipe_row(
            node,
            recipe_rows[recipe_index],
            recipe_index
        )

static func draw_crafting_recipe_row(
    node: CanvasItem,
    recipe_row: Dictionary,
    recipe_index: int
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    var recipe_button_screen_rect: Rect2 = RegionUI.get_crafting_recipe_button_screen_rect(
        node.get_viewport().get_visible_rect().size,
        recipe_index
    )

    var recipe_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        recipe_button_screen_rect
    )

    var can_craft: bool = bool(recipe_row.get("can_craft", false))

    var fill_color := Color(0.12, 0.10, 0.07, 0.95)
    var border_color := Color(0.65, 0.55, 0.32, 0.95)
    var name_color := Color(1.0, 1.0, 1.0, 1.0)
    var detail_color := Color(0.88, 0.88, 0.88, 1.0)
    var status_color := Color(0.65, 1.0, 0.65, 1.0)

    if not can_craft:
        fill_color = Color(0.075, 0.065, 0.055, 0.92)
        border_color = Color(0.32, 0.28, 0.20, 0.95)
        name_color = Color(0.72, 0.72, 0.68, 1.0)
        detail_color = Color(0.58, 0.58, 0.55, 1.0)
        status_color = Color(1.0, 0.62, 0.45, 1.0)

    node.draw_rect(recipe_button_world_rect, fill_color, true)

    node.draw_rect(
        recipe_button_world_rect,
        border_color,
        false,
        get_small_border_width(world_per_screen_y)
    )

    var recipe_name: String = str(recipe_row.get("name", "Recipe"))
    var output_text: String = str(recipe_row.get("output_text", ""))
    var cost_text: String = str(recipe_row.get("cost_text", ""))
    var missing_text: String = str(recipe_row.get("missing_text", ""))

    var status_text: String = "Ready"

    if not can_craft:
        if missing_text == "":
            status_text = "Unavailable"
        else:
            status_text = "Missing: " + missing_text

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            recipe_button_screen_rect.position + Vector2(8, 15)
        ),
        recipe_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        name_color
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            recipe_button_screen_rect.position + Vector2(8, 31)
        ),
        "Makes: " + output_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        detail_color
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            recipe_button_screen_rect.position + Vector2(8, 46)
        ),
        "Cost: " + cost_text + " | " + status_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_tiny_font_size(world_per_screen_y),
        status_color
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

static func draw_selected_building_panel(
    node: CanvasItem,
    building_data: Dictionary,
    assigned_villager_data: Array,
    storage_current_amount: int,
    building_actions: Array
) -> void:
    if building_data.is_empty():
        return

    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_screen_rect: Rect2 = RegionUI.get_selected_building_panel_screen_rect(viewport_size)
    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var title_font_size: int = get_title_font_size(world_per_screen_y)
    var body_font_size: int = get_body_font_size(world_per_screen_y)
    var small_font_size: int = get_small_font_size(world_per_screen_y)

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.96),
        true
    )

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.98),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    draw_selected_building_panel_close_button(node)

    draw_selected_building_panel_text(
        node,
        building_data,
        assigned_villager_data,
        storage_current_amount,
        panel_screen_rect,
        title_font_size,
        body_font_size,
        small_font_size
    )

    draw_selected_building_action_buttons(
        node,
        building_actions,
        body_font_size,
        small_font_size
    )


static func draw_selected_building_panel_close_button(node: CanvasItem) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var close_button_screen_rect: Rect2 = RegionUI.get_selected_building_close_button_screen_rect(
        viewport_size
    )
    var close_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        close_button_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(
        close_button_world_rect,
        Color(0.28, 0.08, 0.06, 0.98),
        true
    )

    node.draw_rect(
        close_button_world_rect,
        Color(1.0, 0.55, 0.45, 1.0),
        false,
        get_small_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            close_button_screen_rect.position + Vector2(6, 16)
        ),
        "X",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.90, 1.0)
    )


static func draw_selected_building_panel_text(
    node: CanvasItem,
    building_data: Dictionary,
    assigned_villager_data: Array,
    storage_current_amount: int,
    panel_screen_rect: Rect2,
    title_font_size: int,
    body_font_size: int,
    small_font_size: int
) -> void:
    var building_name: String = str(building_data.get("name", "Building"))
    var building_id: String = str(building_data.get("id", ""))
    var instance_id: int = int(building_data.get("instance_id", 0))
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 1))
    var height: int = int(building_data.get("height", 1))
    var center_tile := Vector2i(
        tile_x + int(floor(float(width) / 2.0)),
        tile_y + int(floor(float(height) / 2.0))
    )

    var text_x: float = panel_screen_rect.position.x + 10.0
    var text_y: float = panel_screen_rect.position.y + 20.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        building_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 22.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "ID: " + building_id + " | #" + str(instance_id),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Origin: " + str(tile_x) + ", " + str(tile_y) + " | Size: " + str(width) + "x" + str(height),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.92, 0.92, 0.88, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Center: " + str(center_tile.x) + ", " + str(center_tile.y),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.92, 0.92, 0.88, 1.0)
    )

    text_y += 22.0

    draw_selected_building_summary_lines(
        node,
        building_data,
        assigned_villager_data,
        storage_current_amount,
        Vector2(text_x, text_y),
        body_font_size,
        small_font_size
    )


static func draw_selected_building_summary_lines(
    node: CanvasItem,
    building_data: Dictionary,
    assigned_villager_data: Array,
    storage_current_amount: int,
    screen_position: Vector2,
    body_font_size: int,
    small_font_size: int
) -> void:
    var text_y: float = screen_position.y

    if bool(building_data.get("assignment_enabled", false)):
        var assignment_role: String = str(building_data.get("assignment_role", ""))
        var assignment_role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(assignment_role)
        var assignment_slots: int = int(building_data.get("assignment_slots", 0))
        var assigned_villagers: Array = building_data.get("assigned_villagers", [])
        var assigned_names: String = get_assigned_villager_names_text(assigned_villager_data)

        if assigned_names == "":
            assigned_names = "None"

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(node, Vector2(screen_position.x, text_y)),
            "Assignment: " + assignment_role_name + " " + str(assigned_villagers.size()) + "/" + str(assignment_slots),
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.90, 0.95, 1.0, 1.0)
        )

        text_y += 18.0

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(node, Vector2(screen_position.x, text_y)),
            "Assigned: " + assigned_names,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.92, 0.92, 0.88, 1.0)
        )

        text_y += 20.0

    if str(building_data.get("id", "")) == RegionBuildingData.BUILDING_STORAGE_AREA:
        var storage_resource: String = str(building_data.get("storage_resource", ""))
        var storage_capacity: int = int(building_data.get("storage_capacity", RegionBuildingData.STORAGE_AREA_CAPACITY))

        if storage_resource == "":
            storage_resource = "Unassigned"

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(node, Vector2(screen_position.x, text_y)),
            "Storage: " + storage_resource + " " + str(storage_current_amount) + "/" + str(storage_capacity),
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.90, 0.95, 1.0, 1.0)
        )

        text_y += 20.0

    var building_id: String = str(building_data.get("id", ""))

    if ProtectionLightData.is_protection_light_building(building_id):
        var is_lit: bool = bool(
            building_data.get(
                RegionBuildingManager.KEY_IS_LIT,
                building_data.get(RegionBuildingManager.KEY_ACTIVE, true)
            )
        )
        var light_state: String = "Lit"

        if not is_lit:
            light_state = "Unlit"

        var radius_scale: float = ProtectionLightData.get_radius_scale_for_building(building_id)

        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(node, Vector2(screen_position.x, text_y)),
            "Light: " + light_state + " | Radius Scale: " + str(radius_scale),
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.90, 0.95, 1.0, 1.0)
        )


static func draw_selected_building_action_buttons(
    node: CanvasItem,
    building_actions: Array,
    body_font_size: int,
    small_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_rect: Rect2 = RegionUI.get_selected_building_panel_screen_rect(viewport_size)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_rect.position + Vector2(
                10,
                RegionUI.SELECTED_BUILDING_ACTION_START_Y - 10
            )
        ),
        "Actions",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if building_actions.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_rect.position + Vector2(
                    10,
                    RegionUI.SELECTED_BUILDING_ACTION_START_Y + 18
                )
            ),
            "No actions available.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )
        return

    var visible_count: int = min(
        building_actions.size(),
        RegionUI.get_selected_building_action_visible_row_count()
    )

    for action_index in range(visible_count):
        draw_selected_building_action_button(
            node,
            building_actions[action_index],
            action_index,
            small_font_size
        )


static func draw_selected_building_action_button(
    node: CanvasItem,
    action_data: Dictionary,
    action_index: int,
    small_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var button_screen_rect: Rect2 = RegionUI.get_selected_building_action_button_screen_rect(
        viewport_size,
        action_index
    )
    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var action_label: String = str(action_data.get("label", "Action"))

    node.draw_rect(
        button_world_rect,
        Color(0.12, 0.10, 0.07, 0.95),
        true
    )

    node.draw_rect(
        button_world_rect,
        Color(0.65, 0.55, 0.32, 0.95),
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
        small_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

static func get_selected_panel_belonging_id_from_variant(belonging_variant: Variant) -> String:
    if typeof(belonging_variant) == TYPE_STRING:
        return str(belonging_variant)

    if typeof(belonging_variant) != TYPE_DICTIONARY:
        return ""

    var belonging_data: Dictionary = belonging_variant

    return str(belonging_data.get("id", belonging_data.get("item_id", "")))


static func get_selected_panel_used_belonging_slots(belongings: Array) -> int:
    var used_slots: int = 0

    for belonging_index in range(belongings.size()):
        var normalized_belonging: Dictionary = StoneAgeBelongingData.normalize_belonging_entry(
            belongings[belonging_index]
        )

        if normalized_belonging.is_empty():
            continue

        used_slots += max(1, int(normalized_belonging.get("slot_cost", 1)))

    return used_slots


static func draw_selected_villager_panel(
    node: CanvasItem,
    villager_data: Dictionary,
    available_belonging_items: Array,
    skill_rows: Array,
    villager_actions: Array
) -> void:
    if villager_data.is_empty():
        return

    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_screen_rect: Rect2 = RegionUI.get_selected_villager_panel_screen_rect(viewport_size)
    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var title_font_size: int = get_title_font_size(world_per_screen_y)
    var body_font_size: int = get_body_font_size(world_per_screen_y)
    var small_font_size: int = get_small_font_size(world_per_screen_y)
    var tiny_font_size: int = get_tiny_font_size(world_per_screen_y)

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.96),
        true
    )

    node.draw_rect(
        panel_world_rect,
        Color(0.85, 0.75, 0.45, 0.98),
        false,
        get_panel_border_width(world_per_screen_y)
    )

    draw_selected_villager_panel_close_button(
        node,
        panel_screen_rect
    )

    draw_selected_villager_panel_header(
        node,
        villager_data,
        panel_screen_rect,
        title_font_size,
        body_font_size,
        small_font_size
    )

    draw_selected_villager_action_buttons(
        node,
        villager_actions,
        body_font_size,
        small_font_size
    )

    draw_selected_villager_skill_rows(
        node,
        skill_rows,
        body_font_size,
        small_font_size,
        tiny_font_size
    )

    draw_selected_villager_current_belongings(
        node,
        villager_data,
        body_font_size,
        small_font_size,
        tiny_font_size
    )

    draw_selected_villager_available_belongings(
        node,
        villager_data,
        available_belonging_items,
        body_font_size,
        small_font_size,
        tiny_font_size
    )


static func draw_selected_villager_panel_close_button(
    node: CanvasItem,
    _panel_screen_rect: Rect2
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var close_button_screen_rect: Rect2 = RegionUI.get_selected_villager_close_button_screen_rect(
        viewport_size
    )
    var close_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        close_button_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(
        close_button_world_rect,
        Color(0.28, 0.08, 0.06, 0.98),
        true
    )

    node.draw_rect(
        close_button_world_rect,
        Color(1.0, 0.55, 0.45, 1.0),
        false,
        get_small_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            close_button_screen_rect.position + Vector2(6, 16)
        ),
        "X",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        get_small_font_size(world_per_screen_y),
        Color(1.0, 0.95, 0.90, 1.0)
    )


static func draw_selected_villager_panel_header(
    node: CanvasItem,
    villager_data: Dictionary,
    panel_screen_rect: Rect2,
    title_font_size: int,
    body_font_size: int,
    small_font_size: int
) -> void:
    var villager_name: String = str(villager_data.get("name", "Villager"))
    var gender: String = str(villager_data.get("gender", "unknown"))
    var role: String = str(villager_data.get("role", StoneAgeVillagerAssignmentData.get_default_role()))
    var role_name: String = StoneAgeVillagerAssignmentData.get_role_display_name(role)
    var level: int = int(villager_data.get("level", 0))
    var health: int = int(villager_data.get("health", 5))
    var max_health: int = int(villager_data.get("max_health", 5))
    var hunger: int = int(villager_data.get("hunger", 100))
    var speed: int = int(villager_data.get("speed", 100))
    var health_state: String = str(villager_data.get("health_state", "healthy"))

    var belongings: Array = villager_data.get("belongings", [])
    var max_belongings: int = int(villager_data.get("max_belongings", villager_data.get("belonging_slots", 1)))
    var used_belonging_slots: int = get_selected_panel_used_belonging_slots(belongings)

    var text_x: float = panel_screen_rect.position.x + 10.0
    var text_y: float = panel_screen_rect.position.y + 20.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        villager_name + " (" + gender + ")",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 22.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Role: " + role_name + " | Level " + str(level),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Health: " + str(health) + "/" + str(max_health) + " | Hunger: " + str(hunger) + " | Speed: " + str(speed),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.92, 0.92, 0.88, 1.0)
    )

    text_y += 17.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "State: " + health_state.capitalize() + " | Belonging Slots: " + str(used_belonging_slots) + "/" + str(max_belongings),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.92, 0.92, 0.88, 1.0)
    )

static func draw_selected_villager_action_buttons(
    node: CanvasItem,
    villager_actions: Array,
    body_font_size: int,
    small_font_size: int
) -> void:
    if villager_actions.is_empty():
        return

    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_rect: Rect2 = RegionUI.get_selected_villager_panel_screen_rect(viewport_size)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_rect.position + Vector2(
                10,
                RegionUI.SELECTED_VILLAGER_ACTION_START_Y - 8
            )
        ),
        "Actions",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    var visible_count: int = min(
        villager_actions.size(),
        RegionUI.get_selected_villager_action_visible_row_count()
    )

    for action_index in range(visible_count):
        draw_selected_villager_action_button(
            node,
            villager_actions[action_index],
            action_index,
            small_font_size
        )


static func draw_selected_villager_action_button(
    node: CanvasItem,
    action_data: Dictionary,
    action_index: int,
    small_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var button_screen_rect: Rect2 = RegionUI.get_selected_villager_action_button_screen_rect(
        viewport_size,
        action_index
    )
    var button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        button_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var action_label: String = str(action_data.get("label", "Action"))

    node.draw_rect(
        button_world_rect,
        Color(0.12, 0.10, 0.07, 0.95),
        true
    )

    node.draw_rect(
        button_world_rect,
        Color(0.75, 0.62, 0.24, 0.95),
        false,
        get_small_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            button_screen_rect.position + Vector2(8, 18)
        ),
        action_label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

static func draw_selected_villager_skill_rows(
    node: CanvasItem,
    skill_rows: Array,
    body_font_size: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_rect: Rect2 = RegionUI.get_selected_villager_panel_screen_rect(viewport_size)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_rect.position + Vector2(
                10,
                RegionUI.SELECTED_VILLAGER_SKILLS_START_Y - 12
            )
        ),
        "Skills",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if skill_rows.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_rect.position + Vector2(
                    10,
                    RegionUI.SELECTED_VILLAGER_SKILLS_START_Y + 14
                )
            ),
            "No skills found.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )
        return

    var visible_count: int = min(
        skill_rows.size(),
        RegionUI.get_selected_villager_skill_visible_row_count()
    )

    for skill_index in range(visible_count):
        var skill_data: Dictionary = skill_rows[skill_index]
        draw_selected_villager_skill_row(
            node,
            skill_data,
            skill_index,
            small_font_size,
            tiny_font_size
        )


static func draw_selected_villager_skill_row(
    node: CanvasItem,
    skill_data: Dictionary,
    skill_index: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var row_screen_rect: Rect2 = RegionUI.get_selected_villager_skill_row_screen_rect(
        viewport_size,
        skill_index
    )
    var row_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        row_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(
        row_world_rect,
        Color(0.10, 0.09, 0.065, 0.86),
        true
    )

    var skill_name: String = str(skill_data.get("name", "Skill"))
    var base_skill: int = int(skill_data.get("base", 0))
    var bonus_skill: int = int(skill_data.get("bonus", 0))
    var effective_skill: int = int(skill_data.get("effective", base_skill + bonus_skill))

    var skill_text: String = skill_name + ": " + str(base_skill)

    if bonus_skill > 0:
        skill_text += " (+" + str(bonus_skill) + ") = " + str(effective_skill)
    elif bonus_skill < 0:
        skill_text += " (" + str(bonus_skill) + ") = " + str(effective_skill)
    else:
        skill_text += " = " + str(effective_skill)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            row_screen_rect.position + Vector2(8, 14)
        ),
        skill_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(0.92, 0.92, 0.88, 1.0)
    )

static func draw_selected_villager_current_belongings(
    node: CanvasItem,
    villager_data: Dictionary,
    body_font_size: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_rect: Rect2 = RegionUI.get_selected_villager_panel_screen_rect(viewport_size)
    var belongings: Array = villager_data.get("belongings", [])
    var visible_count: int = min(
        belongings.size(),
        RegionUI.get_selected_villager_current_belonging_visible_row_count()
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_rect.position + Vector2(10, RegionUI.SELECTED_VILLAGER_CURRENT_BELONGINGS_START_Y - 12)
        ),
        "Current Belongings",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if belongings.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_rect.position + Vector2(10, RegionUI.SELECTED_VILLAGER_CURRENT_BELONGINGS_START_Y + 18)
            ),
            "None",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )
        return

    for belonging_index in range(visible_count):
        var belonging_data: Dictionary = StoneAgeBelongingData.normalize_belonging_entry(
            belongings[belonging_index]
        )

        if belonging_data.is_empty():
            continue

        draw_selected_villager_current_belonging_row(
            node,
            belonging_data,
            belonging_index,
            small_font_size,
            tiny_font_size
        )


static func draw_selected_villager_current_belonging_row(
    node: CanvasItem,
    belonging_data: Dictionary,
    belonging_index: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var row_screen_rect: Rect2 = RegionUI.get_selected_villager_current_belonging_row_screen_rect(
        viewport_size,
        belonging_index
    )
    var row_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        row_screen_rect
    )

    var remove_button_screen_rect: Rect2 = RegionUI.get_selected_villager_remove_belonging_button_screen_rect(
        viewport_size,
        belonging_index
    )
    var remove_button_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        remove_button_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(
        row_world_rect,
        Color(0.12, 0.10, 0.07, 0.95),
        true
    )

    node.draw_rect(
        row_world_rect,
        Color(0.65, 0.55, 0.32, 0.95),
        false,
        get_small_border_width(world_per_screen_y)
    )

    var belonging_name: String = str(belonging_data.get("name", "Belonging"))
    var slot_cost: int = max(1, int(belonging_data.get("slot_cost", 1)))
    var effect_notes: String = str(belonging_data.get("effect_notes", ""))

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            row_screen_rect.position + Vector2(8, 13)
        ),
        belonging_name + " | Slots " + str(slot_cost),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    if effect_notes != "":
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                row_screen_rect.position + Vector2(8, 25)
            ),
            effect_notes,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            tiny_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )

    node.draw_rect(
        remove_button_world_rect,
        Color(0.28, 0.08, 0.06, 0.98),
        true
    )

    node.draw_rect(
        remove_button_world_rect,
        Color(1.0, 0.55, 0.45, 1.0),
        false,
        get_small_border_width(world_per_screen_y)
    )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            remove_button_screen_rect.position + Vector2(7, 16)
        ),
        "X",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        tiny_font_size,
        Color(1.0, 0.95, 0.90, 1.0)
    )


static func draw_selected_villager_available_belongings(
    node: CanvasItem,
    villager_data: Dictionary,
    available_belonging_items: Array,
    body_font_size: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var panel_rect: Rect2 = RegionUI.get_selected_villager_panel_screen_rect(viewport_size)
    var max_belongings: int = int(villager_data.get("max_belongings", villager_data.get("belonging_slots", 1)))
    var used_slots: int = get_selected_panel_used_belonging_slots(villager_data.get("belongings", []))
    var open_slots: int = max(0, max_belongings - used_slots)

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            panel_rect.position + Vector2(10, RegionUI.SELECTED_VILLAGER_AVAILABLE_BELONGINGS_START_Y - 12)
        ),
        "Available Belongings",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    if open_slots <= 0:
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_rect.position + Vector2(10, RegionUI.SELECTED_VILLAGER_AVAILABLE_BELONGINGS_START_Y + 18)
            ),
            "No open belonging slots.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )
        return

    if available_belonging_items.is_empty():
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                panel_rect.position + Vector2(10, RegionUI.SELECTED_VILLAGER_AVAILABLE_BELONGINGS_START_Y + 18)
            ),
            "No compatible belongings in inventory.",
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            small_font_size,
            Color(0.82, 0.82, 0.78, 1.0)
        )
        return

    var visible_count: int = min(
        available_belonging_items.size(),
        RegionUI.get_selected_villager_available_belonging_visible_row_count()
    )

    for item_index in range(visible_count):
        draw_selected_villager_available_belonging_row(
            node,
            available_belonging_items[item_index],
            item_index,
            small_font_size,
            tiny_font_size
        )


static func draw_selected_villager_available_belonging_row(
    node: CanvasItem,
    item_data: Dictionary,
    item_index: int,
    small_font_size: int,
    tiny_font_size: int
) -> void:
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size
    var row_screen_rect: Rect2 = RegionUI.get_selected_villager_available_belonging_row_screen_rect(
        viewport_size,
        item_index
    )
    var row_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        row_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(
        row_world_rect,
        Color(0.10, 0.13, 0.08, 0.95),
        true
    )

    node.draw_rect(
        row_world_rect,
        Color(0.55, 0.72, 0.38, 0.95),
        false,
        get_small_border_width(world_per_screen_y)
    )

    var item_name: String = str(item_data.get("belonging_name", item_data.get("name", "Belonging")))
    var amount: int = int(item_data.get("amount", 0))
    var slot_cost: int = int(item_data.get("slot_cost", 1))
    var role_text: String = str(item_data.get("allowed_roles_text", "Any role"))
    var effect_notes: String = str(item_data.get("effect_notes", ""))

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            row_screen_rect.position + Vector2(8, 13)
        ),
        item_name + " x" + str(amount) + " | Slots " + str(slot_cost),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        small_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    if effect_notes != "":
        node.draw_string(
            ThemeDB.fallback_font,
            RegionUI.screen_position_to_world_position(
                node,
                row_screen_rect.position + Vector2(8, 25)
            ),
            "Effect: " + effect_notes,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1,
            tiny_font_size,
            Color(0.82, 0.90, 0.78, 1.0)
        )

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(
            node,
            row_screen_rect.position + Vector2(8, 36)
        ),
        "Allowed: " + role_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        tiny_font_size,
        Color(0.78, 0.86, 0.72, 1.0)
    )

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
    
static func draw_wild_animal_hover_panel(
    node: CanvasItem,
    animal_data: Dictionary
) -> void:
    if animal_data.is_empty():
        return

    var mouse_screen_position: Vector2 = node.get_viewport().get_mouse_position()
    var panel_width: float = 290.0
    var panel_height: float = 210.0
    var panel_offset := Vector2(18.0, 18.0)

    var panel_screen_position: Vector2 = mouse_screen_position + panel_offset
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size

    if panel_screen_position.x + panel_width > viewport_size.x:
        panel_screen_position.x = mouse_screen_position.x - panel_width - panel_offset.x

    if panel_screen_position.y + panel_height > viewport_size.y:
        panel_screen_position.y = mouse_screen_position.y - panel_height - panel_offset.y

    var panel_screen_rect := Rect2(
        panel_screen_position,
        Vector2(panel_width, panel_height)
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)

    node.draw_rect(panel_world_rect, Color(0.04, 0.035, 0.025, 0.95), true)

    var dangerous: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_DANGEROUS, false))
    var is_unique: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_IS_UNIQUE, false))
    var border_color := Color(0.95, 0.82, 0.35, 0.95)

    if dangerous:
        border_color = Color(1.0, 0.25, 0.18, 0.98)

    if is_unique:
        border_color = Color(0.35, 0.65, 1.0, 1.0)

    node.draw_rect(
        panel_world_rect,
        border_color,
        false,
        get_panel_border_width(world_per_screen_y)
    )

    draw_wild_animal_hover_panel_text(
        node,
        animal_data,
        panel_screen_rect
    )
    
static func draw_hero_hover_panel(
    node: CanvasItem,
    hero_data: Dictionary
) -> void:
    if hero_data.is_empty():
        return

    var mouse_screen_position: Vector2 = node.get_viewport().get_mouse_position()
    var panel_width: float = 270.0
    var panel_height: float = 132.0
    var panel_offset := Vector2(18.0, 18.0)

    var panel_screen_position: Vector2 = mouse_screen_position + panel_offset
    var viewport_size: Vector2 = node.get_viewport().get_visible_rect().size

    if panel_screen_position.x + panel_width > viewport_size.x:
        panel_screen_position.x = mouse_screen_position.x - panel_width - panel_offset.x

    if panel_screen_position.y + panel_height > viewport_size.y:
        panel_screen_position.y = mouse_screen_position.y - panel_height - panel_offset.y

    var panel_screen_rect := Rect2(
        panel_screen_position,
        Vector2(panel_width, panel_height)
    )

    var panel_world_rect: Rect2 = RegionUI.screen_rect_to_world_rect(
        node,
        panel_screen_rect
    )

    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var hero_type: String = str(hero_data.get(HeroManager.KEY_HERO_TYPE, ""))
    var border_color: Color = HeroData.get_hero_color(hero_type)

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.95),
        true
    )

    node.draw_rect(
        panel_world_rect,
        border_color,
        false,
        get_panel_border_width(world_per_screen_y)
    )

    draw_hero_hover_panel_text(
        node,
        hero_data,
        panel_screen_rect
    )


static func draw_hero_hover_panel_text(
    node: CanvasItem,
    hero_data: Dictionary,
    panel_screen_rect: Rect2
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var title_font_size: int = get_title_font_size(world_per_screen_y)
    var body_font_size: int = get_small_font_size(world_per_screen_y)

    var hero_name: String = str(hero_data.get(HeroManager.KEY_NAME, "Hero"))
    var display_type: String = str(hero_data.get(HeroManager.KEY_DISPLAY_TYPE, "Hero"))
    var state: String = str(hero_data.get(HeroManager.KEY_STATE, HeroData.HERO_STATE_WANDERING))
    var visual_piece: String = str(hero_data.get(HeroManager.KEY_VISUAL_PIECE, "marker"))
    var source_building_instance_id: int = int(hero_data.get(HeroManager.KEY_SOURCE_BUILDING_INSTANCE_ID, 0))

    var text_x: float = panel_screen_rect.position.x + 10.0
    var text_y: float = panel_screen_rect.position.y + 20.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        hero_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 22.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Hero Type: " + display_type,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "State: " + state.capitalize() + " | Piece: " + visual_piece.capitalize(),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Source Building #: " + str(source_building_instance_id),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 22.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Hero system coming later.",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.88, 0.62, 1.0)
    )
    
static func draw_grave_hover_panel(
    canvas: CanvasItem,
    villager_data: Dictionary
) -> void:
    var viewport_size: Vector2 = canvas.get_viewport().get_visible_rect().size

    var panel_width: float = 260.0
    var panel_height: float = 88.0
    var panel_position := Vector2(
        viewport_size.x - panel_width - 12.0,
        176.0
    )

    var panel_rect := Rect2(
        panel_position,
        Vector2(panel_width, panel_height)
    )

    canvas.draw_rect(
        panel_rect,
        Color(0.08, 0.08, 0.08, 0.88),
        true
    )

    canvas.draw_rect(
        panel_rect,
        Color(0.75, 0.75, 0.75, 1.0),
        false,
        2.0
    )

    var villager_name: String = str(villager_data.get("name", "Unknown Villager"))
    var death_reason: String = str(villager_data.get("death_reason", ""))

    var text_x: float = panel_position.x + 10.0
    var text_y: float = panel_position.y + 22.0

    canvas.draw_string(
        ThemeDB.fallback_font,
        Vector2(text_x, text_y),
        "Grave Marker",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1.0,
        16,
        Color.WHITE
    )

    canvas.draw_string(
        ThemeDB.fallback_font,
        Vector2(text_x, text_y + 24.0),
        "Here lies: " + villager_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1.0,
        14,
        Color.WHITE
    )

    if death_reason != "":
        canvas.draw_string(
            ThemeDB.fallback_font,
            Vector2(text_x, text_y + 46.0),
            death_reason,
            HORIZONTAL_ALIGNMENT_LEFT,
            -1.0,
            12,
            Color(0.85, 0.85, 0.85, 1.0)
        )


static func draw_wild_animal_hover_panel_text(
    node: CanvasItem,
    animal_data: Dictionary,
    panel_screen_rect: Rect2
) -> void:
    var world_per_screen_y: float = RegionUI.get_world_per_screen_y(node)
    var title_font_size: int = get_title_font_size(world_per_screen_y)
    var body_font_size: int = get_small_font_size(world_per_screen_y)

    var animal_id: String = str(animal_data.get(RegionWildAnimalManager.KEY_ANIMAL_ID, ""))
    var animal_name: String = str(animal_data.get(RegionWildAnimalManager.KEY_NAME, "Wild Animal"))
    var dangerous: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_DANGEROUS, false))
    var is_unique: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_IS_UNIQUE, false))
    var danger_level: String = str(animal_data.get(RegionWildAnimalManager.KEY_DANGER_LEVEL, RegionWildAnimalData.DANGER_NONE))
    var required_hunters: int = int(animal_data.get(RegionWildAnimalManager.KEY_REQUIRED_HUNTERS, 1))
    var injury_chance: float = float(animal_data.get(RegionWildAnimalManager.KEY_INJURY_CHANCE, 0.0))
    var death_chance: float = float(animal_data.get(RegionWildAnimalManager.KEY_DEATH_CHANCE, 0.0))
    var hunt_damage: int = int(animal_data.get(RegionWildAnimalManager.KEY_HUNT_DAMAGE, 0))
    var hunt_time_modifier: float = float(animal_data.get(RegionWildAnimalManager.KEY_HUNT_TIME_MODIFIER, 0.0))
    var can_respawn: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_CAN_RESPAWN, false))
    var respawn_time: float = float(animal_data.get(RegionWildAnimalManager.KEY_RESPAWN_TIME, 0.0))
    var yields: Dictionary = animal_data.get(RegionWildAnimalManager.KEY_YIELDS, {})

    var kill_count: int = 0

    if node.has_method("get_animal_kill_count_for_hover"):
        kill_count = int(node.call("get_animal_kill_count_for_hover", animal_id))

    var danger_text: String = "Normal"

    if dangerous:
        danger_text = "Dangerous - " + danger_level.capitalize()

    if is_unique:
        danger_text = "Unique Dangerous - " + danger_level.capitalize()

    var yield_text: String = get_wild_animal_yield_text(yields)

    var injury_percent: int = int(round(injury_chance * 100.0))
    var death_percent: int = int(round(death_chance * 100.0))

    var respawn_text: String = "No"

    if can_respawn:
        respawn_text = str(int(round(respawn_time))) + "s"

    var text_x: float = panel_screen_rect.position.x + 10.0
    var text_y: float = panel_screen_rect.position.y + 20.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        animal_name,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        title_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 22.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Type: " + danger_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Required Hunters: " + str(required_hunters) + " | Kill Count: " + str(kill_count),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Hunt Damage: " + str(hunt_damage) + " | Time Mod: " + str(snapped(hunt_time_modifier, 0.1)) + "s",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Injury Risk: " + str(injury_percent) + "% | Death Risk: " + str(death_percent) + "%",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.82, 0.70, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Respawn: " + respawn_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 18.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Yields: " + yield_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )


static func get_wild_animal_yield_text(yields: Dictionary) -> String:
    if yields.is_empty():
        return "None"

    var parts: Array = []

    var resource_order: Array = [
        StoneAgeTuning.RESOURCE_MEAT,
        StoneAgeTuning.RESOURCE_HIDE,
        StoneAgeTuning.RESOURCE_BONE,
        StoneAgeTuning.RESOURCE_FEATHER
    ]

    for resource_index in range(resource_order.size()):
        var resource_name: String = str(resource_order[resource_index])
        var amount: int = int(yields.get(resource_name, 0))

        if amount <= 0:
            continue

        parts.append(resource_name + " " + str(amount))

    if parts.is_empty():
        return "None"

    return ", ".join(parts)

static func get_belonging_name_from_variant(belonging_variant: Variant) -> String:
    if typeof(belonging_variant) == TYPE_STRING:
        return StoneAgeBelongingData.get_belonging_name(str(belonging_variant))

    if typeof(belonging_variant) != TYPE_DICTIONARY:
        return ""

    var belonging_data: Dictionary = belonging_variant
    var belonging_id: String = str(belonging_data.get("id", belonging_data.get("item_id", "")))

    if belonging_id != "":
        return str(
            belonging_data.get(
                "name",
                StoneAgeBelongingData.get_belonging_name(belonging_id)
            )
        )

    return str(belonging_data.get("name", ""))


static func get_belongings_text(belongings: Array) -> String:
    if belongings.is_empty():
        return "None"

    var name_parts: Array = []

    for belonging_index in range(belongings.size()):
        var belonging_name: String = get_belonging_name_from_variant(
            belongings[belonging_index]
        )

        if belonging_name == "":
            continue

        name_parts.append(belonging_name)

    if name_parts.is_empty():
        return "None"

    return ", ".join(name_parts)

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
    var belongings_text: String = get_belongings_text(belongings)
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
        "Belongings: " + belongings_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.92, 0.88, 0.72, 1.0)
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
                "label": "Woodcarving",
                "key": VillagerManager.SKILL_WOODWORKING
            },
            {
                "label": "Bonecarving",
                "key": VillagerManager.SKILL_BONECARVING
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
