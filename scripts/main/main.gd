extends Node2D

@onready var world: Node2D = $World
@onready var region: Node2D = $Region
@onready var main_camera: Camera2D = $MainCamera


func _ready() -> void:
    if world.has_signal("region_requested"):
        world.connect("region_requested", Callable(self, "_on_world_region_requested"))

    if region.has_signal("return_to_world_requested"):
        region.connect("return_to_world_requested", Callable(self, "_on_region_return_to_world_requested"))

    enter_world_mode()


func enter_world_mode() -> void:
    world.visible = true
    region.visible = false

    if world.has_method("activate"):
        world.call("activate")

    if region.has_method("deactivate"):
        region.call("deactivate")

    if world.has_method("get_map_center"):
        main_camera.position = world.call("get_map_center")


func enter_region_mode(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    world.visible = false
    region.visible = true

    if world.has_method("deactivate"):
        world.call("deactivate")

    if region.has_method("activate"):
        region.call("activate")

    if region.has_method("generate_from_world_selection"):
        region.call(
            "generate_from_world_selection",
            selected_world_tiles,
            source_world_seed,
            selection_origin,
            source_resource_totals
        )

    if region.has_method("get_map_center"):
        main_camera.position = region.call("get_map_center")


func _on_world_region_requested(
    selected_world_tiles: Array,
    source_world_seed: int,
    selection_origin: Vector2i,
    source_resource_totals: Dictionary
) -> void:
    enter_region_mode(
        selected_world_tiles,
        source_world_seed,
        selection_origin,
        source_resource_totals
    )


func _on_region_return_to_world_requested() -> void:
    enter_world_mode()
