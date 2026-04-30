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
    var button_border_color := Color(0.95, 0.82, 0.45, 1.0)

    if show_resource_inventory_panel:
        button_fill_color = Color(0.32, 0.24, 0.10, 0.98)

    node.draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

    node.draw_rect(
        button_world_rect,
        button_border_color,
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

    node.draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

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

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.92),
        true
    )

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

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

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

        node.draw_rect(
            plan_button_world_rect,
            Color(0.12, 0.10, 0.07, 0.95),
            true
        )

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

    node.draw_rect(
        button_world_rect,
        button_fill_color,
        true
    )

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

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

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

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

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
        "Level: " + str(snappedf(level, 0.1)) + "    Speed: " + str(speed),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(0.90, 0.95, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Health: " + health_state + "    " + housed_text,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "State: " + current_state,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 1.0, 1.0, 1.0)
    )

    text_y += 16.0

    node.draw_string(
        ThemeDB.fallback_font,
        RegionUI.screen_position_to_world_position(node, Vector2(text_x, text_y)),
        "Belongings: " + str(belongings.size()) + "/" + str(max_belongings),
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
        "Skills",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        body_font_size,
        Color(1.0, 0.95, 0.75, 1.0)
    )

    text_y += 15.0

    draw_villager_skill_line(
        node,
        "Gathering",
        int(skills.get(VillagerManager.SKILL_GATHERING, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Wood Working",
        int(skills.get(VillagerManager.SKILL_WOOD_WORKING, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Stone Working",
        int(skills.get(VillagerManager.SKILL_STONE_WORKING, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Building",
        int(skills.get(VillagerManager.SKILL_BUILDING, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Hauling",
        int(skills.get(VillagerManager.SKILL_HAULING, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Medicine",
        int(skills.get(VillagerManager.SKILL_MEDICINE, 0)),
        text_x,
        text_y,
        body_font_size
    )

    text_y += 14.0

    draw_villager_skill_line(
        node,
        "Thinking",
        int(skills.get(VillagerManager.SKILL_THINKING, 0)),
        text_x,
        text_y,
        body_font_size
    )


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

    node.draw_rect(
        panel_world_rect,
        Color(0.04, 0.035, 0.025, 0.94),
        true
    )

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

        node.draw_rect(
            recipe_button_world_rect,
            Color(0.12, 0.10, 0.07, 0.95),
            true
        )

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

        node.draw_rect(
            option_rect,
            Color(0.08, 0.07, 0.05, 0.92),
            true
        )

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
