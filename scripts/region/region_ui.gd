extends RefCounted
class_name RegionUI

const TOP_INFO_PANEL_WIDTH: int = 240
const TOP_INFO_PANEL_HEIGHT: int = 112
const TOP_INFO_PANEL_MARGIN: int = 12

const TOP_INFO_RESOURCE_BUTTON_WIDTH: int = 92
const TOP_INFO_RESOURCE_BUTTON_HEIGHT: int = 22

const TOP_INFO_INVENTORY_BUTTON_WIDTH: int = 92
const TOP_INFO_INVENTORY_BUTTON_HEIGHT: int = 22

const TOP_INFO_RESEARCH_BUTTON_WIDTH: int = 92
const TOP_INFO_RESEARCH_BUTTON_HEIGHT: int = 22

const TOP_INFO_BUILD_BUTTON_WIDTH: int = 92
const TOP_INFO_BUILD_BUTTON_HEIGHT: int = 22

const RESOURCE_LIST_PANEL_WIDTH: int = 240
const RESOURCE_LIST_ROW_HEIGHT: int = 20
const RESOURCE_LIST_PANEL_GAP: int = 4

const INVENTORY_LIST_PANEL_WIDTH: int = 240
const INVENTORY_LIST_ROW_HEIGHT: int = 20
const INVENTORY_LIST_PANEL_GAP: int = 4

const RESEARCH_PANEL_WIDTH: int = 360
const RESEARCH_PANEL_HEIGHT: int = 260
const RESEARCH_PANEL_GAP: int = 4
const RESEARCH_ROW_HEIGHT: int = 30

const BUILD_PANEL_WIDTH: int = 420
const BUILD_PANEL_HEIGHT: int = 320
const BUILD_PANEL_GAP: int = 4
const BUILD_ROW_HEIGHT: int = 34

const BUILD_AGE_BUTTON_HEIGHT: int = 24
const BUILD_CATEGORY_BUTTON_HEIGHT: int = 24
const BUILD_FILTER_BUTTON_GAP: int = 4

const BUILD_AGE_ROW_Y: int = 34
const BUILD_CATEGORY_ROW_Y: int = 64
const BUILD_LIST_START_Y: int = 98

const CRAFTING_PANEL_WIDTH: int = 360
const CRAFTING_PANEL_HEIGHT: int = 260
const CRAFTING_PANEL_GAP: int = 4
const CRAFTING_ROW_HEIGHT: int = 42

const VILLAGER_HOVER_PANEL_WIDTH: int = 250
const VILLAGER_HOVER_PANEL_HEIGHT: int = 225
const VILLAGER_HOVER_PANEL_OFFSET: Vector2 = Vector2(18, 18)

const VILLAGE_LOG_BUTTON_WIDTH: int = 110
const VILLAGE_LOG_BUTTON_HEIGHT: int = 26
const VILLAGE_LOG_PANEL_WIDTH: int = 360
const VILLAGE_LOG_PANEL_HEIGHT: int = 220
const VILLAGE_LOG_MARGIN: int = 12
const VILLAGE_LOG_BOTTOM_OFFSET: int = 52
const VILLAGE_LOG_ROW_HEIGHT: int = 18

const DEBUG_BUTTON_WIDTH: int = 80
const DEBUG_BUTTON_HEIGHT: int = 26
const DEBUG_BUTTON_GAP: int = 8

const DEBUG_PANEL_WIDTH: int = 260
const DEBUG_PANEL_HEIGHT: int = 280
const DEBUG_PANEL_ROW_HEIGHT: int = 28
const DEBUG_PANEL_GAP: int = 6


static func get_top_info_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    return Rect2(
        Vector2(
            viewport_size.x - TOP_INFO_PANEL_WIDTH - TOP_INFO_PANEL_MARGIN,
            TOP_INFO_PANEL_MARGIN
        ),
        Vector2(
            TOP_INFO_PANEL_WIDTH,
            TOP_INFO_PANEL_HEIGHT
        )
    )


static func get_resources_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(10, 54),
        Vector2(
            TOP_INFO_RESOURCE_BUTTON_WIDTH,
            TOP_INFO_RESOURCE_BUTTON_HEIGHT
        )
    )


static func get_inventory_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(112, 54),
        Vector2(
            TOP_INFO_INVENTORY_BUTTON_WIDTH,
            TOP_INFO_INVENTORY_BUTTON_HEIGHT
        )
    )


static func get_research_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(10, 82),
        Vector2(
            TOP_INFO_RESEARCH_BUTTON_WIDTH,
            TOP_INFO_RESEARCH_BUTTON_HEIGHT
        )
    )


static func get_build_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(112, 82),
        Vector2(
            TOP_INFO_BUILD_BUTTON_WIDTH,
            TOP_INFO_BUILD_BUTTON_HEIGHT
        )
    )


static func get_resource_list_panel_screen_rect(
    viewport_size: Vector2,
    visible_resource_count: int
) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)
    var row_count: int = max(1, visible_resource_count)

    return Rect2(
        Vector2(
            panel_rect.position.x,
            panel_rect.position.y + panel_rect.size.y + RESOURCE_LIST_PANEL_GAP
        ),
        Vector2(
            RESOURCE_LIST_PANEL_WIDTH,
            30 + row_count * RESOURCE_LIST_ROW_HEIGHT
        )
    )


static func get_village_inventory_panel_screen_rect(
    viewport_size: Vector2,
    visible_item_count: int
) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)
    var row_count: int = max(1, visible_item_count)

    return Rect2(
        Vector2(
            panel_rect.position.x,
            panel_rect.position.y + panel_rect.size.y + INVENTORY_LIST_PANEL_GAP
        ),
        Vector2(
            INVENTORY_LIST_PANEL_WIDTH,
            30 + row_count * INVENTORY_LIST_ROW_HEIGHT
        )
    )


static func get_research_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            panel_rect.position.x - RESEARCH_PANEL_WIDTH + TOP_INFO_PANEL_WIDTH,
            panel_rect.position.y + panel_rect.size.y + RESEARCH_PANEL_GAP
        ),
        Vector2(
            RESEARCH_PANEL_WIDTH,
            RESEARCH_PANEL_HEIGHT
        )
    )


static func get_research_plan_button_screen_rect(
    viewport_size: Vector2,
    plan_index: int
) -> Rect2:
    var panel_rect: Rect2 = get_research_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(
            10,
            34 + plan_index * RESEARCH_ROW_HEIGHT
        ),
        Vector2(
            RESEARCH_PANEL_WIDTH - 20,
            RESEARCH_ROW_HEIGHT - 4
        )
    )


static func get_build_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            panel_rect.position.x - BUILD_PANEL_WIDTH + TOP_INFO_PANEL_WIDTH,
            panel_rect.position.y + panel_rect.size.y + BUILD_PANEL_GAP
        ),
        Vector2(
            BUILD_PANEL_WIDTH,
            BUILD_PANEL_HEIGHT
        )
    )


static func get_build_age_button_screen_rect(
    viewport_size: Vector2,
    age_index: int,
    age_count: int
) -> Rect2:
    var panel_rect: Rect2 = get_build_panel_screen_rect(viewport_size)
    var button_width: int = get_build_filter_button_width(
        BUILD_PANEL_WIDTH - 20,
        age_count
    )

    return Rect2(
        panel_rect.position + Vector2(
            10 + age_index * (button_width + BUILD_FILTER_BUTTON_GAP),
            BUILD_AGE_ROW_Y
        ),
        Vector2(
            button_width,
            BUILD_AGE_BUTTON_HEIGHT
        )
    )


static func get_build_category_button_screen_rect(
    viewport_size: Vector2,
    category_index: int,
    category_count: int
) -> Rect2:
    var panel_rect: Rect2 = get_build_panel_screen_rect(viewport_size)
    var button_width: int = get_build_filter_button_width(
        BUILD_PANEL_WIDTH - 20,
        category_count
    )

    return Rect2(
        panel_rect.position + Vector2(
            10 + category_index * (button_width + BUILD_FILTER_BUTTON_GAP),
            BUILD_CATEGORY_ROW_Y
        ),
        Vector2(
            button_width,
            BUILD_CATEGORY_BUTTON_HEIGHT
        )
    )


static func get_build_filter_button_width(
    available_width: int,
    button_count: int
) -> int:
    if button_count <= 0:
        return available_width

    var total_gap_width: int = max(0, button_count - 1) * BUILD_FILTER_BUTTON_GAP

    return int(floor(float(available_width - total_gap_width) / float(button_count)))


static func get_building_button_screen_rect(
    viewport_size: Vector2,
    building_index: int
) -> Rect2:
    var panel_rect: Rect2 = get_build_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(
            10,
            BUILD_LIST_START_Y + building_index * BUILD_ROW_HEIGHT
        ),
        Vector2(
            BUILD_PANEL_WIDTH - 20,
            BUILD_ROW_HEIGHT - 4
        )
    )


static func get_build_visible_row_count() -> int:
    return int(floor(float(BUILD_PANEL_HEIGHT - BUILD_LIST_START_Y - 10) / float(BUILD_ROW_HEIGHT)))


static func get_crafting_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            panel_rect.position.x - CRAFTING_PANEL_WIDTH + TOP_INFO_PANEL_WIDTH,
            panel_rect.position.y + panel_rect.size.y + CRAFTING_PANEL_GAP
        ),
        Vector2(
            CRAFTING_PANEL_WIDTH,
            CRAFTING_PANEL_HEIGHT
        )
    )


static func get_crafting_recipe_button_screen_rect(
    viewport_size: Vector2,
    recipe_index: int
) -> Rect2:
    var panel_rect: Rect2 = get_crafting_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(
            10,
            34 + recipe_index * CRAFTING_ROW_HEIGHT
        ),
        Vector2(
            CRAFTING_PANEL_WIDTH - 20,
            CRAFTING_ROW_HEIGHT - 4
        )
    )


static func get_village_log_button_screen_rect(viewport_size: Vector2) -> Rect2:
    return Rect2(
        Vector2(
            VILLAGE_LOG_MARGIN,
            viewport_size.y - VILLAGE_LOG_BUTTON_HEIGHT - VILLAGE_LOG_MARGIN - VILLAGE_LOG_BOTTOM_OFFSET
        ),
        Vector2(
            VILLAGE_LOG_BUTTON_WIDTH,
            VILLAGE_LOG_BUTTON_HEIGHT
        )
    )


static func get_debug_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var village_log_button_rect: Rect2 = get_village_log_button_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            village_log_button_rect.position.x + village_log_button_rect.size.x + DEBUG_BUTTON_GAP,
            village_log_button_rect.position.y
        ),
        Vector2(
            DEBUG_BUTTON_WIDTH,
            DEBUG_BUTTON_HEIGHT
        )
    )


static func get_debug_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    var debug_button_rect: Rect2 = get_debug_button_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            debug_button_rect.position.x,
            debug_button_rect.position.y - DEBUG_PANEL_HEIGHT - DEBUG_PANEL_GAP
        ),
        Vector2(
            DEBUG_PANEL_WIDTH,
            DEBUG_PANEL_HEIGHT
        )
    )


static func get_debug_action_button_screen_rect(
    viewport_size: Vector2,
    action_index: int
) -> Rect2:
    var panel_rect: Rect2 = get_debug_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(
            10,
            34 + action_index * DEBUG_PANEL_ROW_HEIGHT
        ),
        Vector2(
            DEBUG_PANEL_WIDTH - 20,
            DEBUG_PANEL_ROW_HEIGHT - 4
        )
    )


static func get_village_log_panel_screen_rect(viewport_size: Vector2) -> Rect2:
    var button_rect: Rect2 = get_village_log_button_screen_rect(viewport_size)

    return Rect2(
        Vector2(
            VILLAGE_LOG_MARGIN,
            button_rect.position.y - VILLAGE_LOG_PANEL_HEIGHT - 6
        ),
        Vector2(
            VILLAGE_LOG_PANEL_WIDTH,
            VILLAGE_LOG_PANEL_HEIGHT
        )
    )


static func screen_rect_to_world_rect(
    node: CanvasItem,
    screen_rect: Rect2
) -> Rect2:
    var canvas_transform: Transform2D = node.get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    var world_per_screen_x: float = inverse_transform.basis_xform(Vector2.RIGHT).length()
    var world_per_screen_y: float = inverse_transform.basis_xform(Vector2.DOWN).length()

    return Rect2(
        inverse_transform * screen_rect.position,
        Vector2(
            screen_rect.size.x * world_per_screen_x,
            screen_rect.size.y * world_per_screen_y
        )
    )


static func screen_position_to_world_position(
    node: CanvasItem,
    screen_position: Vector2
) -> Vector2:
    var canvas_transform: Transform2D = node.get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    return inverse_transform * screen_position


static func get_world_per_screen_y(node: CanvasItem) -> float:
    var canvas_transform: Transform2D = node.get_viewport().get_canvas_transform()
    var inverse_transform: Transform2D = canvas_transform.affine_inverse()

    return inverse_transform.basis_xform(Vector2.DOWN).length()
