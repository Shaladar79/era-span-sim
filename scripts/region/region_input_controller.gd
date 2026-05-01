extends RefCounted
class_name RegionInputController

var region: Node = null


func setup(region_node: Node) -> void:
    region = region_node


func handle_unhandled_input(event: InputEvent) -> void:
    if region == null:
        return

    if event is InputEventMouseButton:
        handle_mouse_button(event)

    if event is InputEventKey and event.pressed and not event.echo:
        handle_key(event)


func handle_mouse_button(event: InputEventMouseButton) -> void:
    if event.button_index != MOUSE_BUTTON_LEFT:
        return

    if event.pressed:
        handle_left_mouse_pressed(event.position)
    else:
        handle_left_mouse_released()


func handle_left_mouse_pressed(mouse_screen_position: Vector2) -> void:
    if region.try_handle_village_log_click(mouse_screen_position):
        return

    if region.try_handle_top_info_panel_click(mouse_screen_position):
        return

    if region.building_manager.is_in_build_mode():
        region.try_place_current_building(region.hovered_tile)
        return

    region.try_start_villager_drag_or_select()


func handle_left_mouse_released() -> void:
    if region.is_dragging_villager:
        region.finish_villager_drag_assignment()


func handle_key(event: InputEventKey) -> void:
    match event.keycode:
        KEY_SPACE:
            region.toggle_simulation_pause()

        KEY_R:
            region.regenerate_region()

        KEY_T:
            region.toggle_resource_markers()

        KEY_G:
            region.toggle_campfire_radius()

        KEY_C:
            region.start_campfire_placement()

        KEY_ESCAPE:
            handle_escape_key()

        _:
            pass


func handle_escape_key() -> void:
    if region.show_assignment_panel:
       region.close_assignment_panel()
       return
    
    if region.storage_selector_open:
        region.close_storage_selector()
        return

    if region.building_manager.is_in_build_mode():
        region.cancel_build_mode()
        return

    if region.is_dragging_villager:
        region.cancel_villager_drag()
        return

    region.emit_signal("return_to_world_requested")
