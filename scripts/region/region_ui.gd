extends RefCounted
class_name RegionUI

const TOP_INFO_PANEL_WIDTH: int = 240
const TOP_INFO_PANEL_HEIGHT: int = 112
const TOP_INFO_PANEL_MARGIN: int = 12

const TOP_INFO_RESOURCE_BUTTON_WIDTH: int = 92
const TOP_INFO_RESOURCE_BUTTON_HEIGHT: int = 22

const TOP_INFO_RESEARCH_BUTTON_WIDTH: int = 92
const TOP_INFO_RESEARCH_BUTTON_HEIGHT: int = 22

const RESOURCE_LIST_PANEL_WIDTH: int = 240
const RESOURCE_LIST_ROW_HEIGHT: int = 20
const RESOURCE_LIST_PANEL_GAP: int = 4

const RESEARCH_PANEL_WIDTH: int = 360
const RESEARCH_PANEL_HEIGHT: int = 260
const RESEARCH_PANEL_GAP: int = 4
const RESEARCH_ROW_HEIGHT: int = 30

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


static func get_research_button_screen_rect(viewport_size: Vector2) -> Rect2:
    var panel_rect: Rect2 = get_top_info_panel_screen_rect(viewport_size)

    return Rect2(
        panel_rect.position + Vector2(10, 82),
        Vector2(
            TOP_INFO_RESEARCH_BUTTON_WIDTH,
            TOP_INFO_RESEARCH_BUTTON_HEIGHT
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
