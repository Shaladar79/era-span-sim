extends Camera2D

@export var move_speed: float = 500.0
@export var zoom_step: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0


func _process(delta: float) -> void:
    handle_movement(delta)


func _unhandled_input(event: InputEvent) -> void:
    handle_zoom(event)


func handle_movement(delta: float) -> void:
    var direction := Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        direction.x += 1

    if Input.is_action_pressed("ui_left"):
        direction.x -= 1

    if Input.is_action_pressed("ui_down"):
        direction.y += 1

    if Input.is_action_pressed("ui_up"):
        direction.y -= 1

    if direction != Vector2.ZERO:
        position += direction.normalized() * move_speed * delta


func handle_zoom(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            zoom -= Vector2(zoom_step, zoom_step)
            zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

        if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            zoom += Vector2(zoom_step, zoom_step)
            zoom = zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
