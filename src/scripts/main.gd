extends Node2D

const CAMERA_SPEED := 600.0
const ZOOM_STEP := 0.1
const ZOOM_MIN := 0.6
const ZOOM_MAX := 2.0

@onready var camera: Camera2D = $Camera2D

func _process(delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		direction.y += 1.0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1.0

	if direction != Vector2.ZERO:
		camera.position += direction.normalized() * CAMERA_SPEED * delta

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_set_zoom(camera.zoom.x - ZOOM_STEP)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_set_zoom(camera.zoom.x + ZOOM_STEP)

func _set_zoom(next_zoom: float) -> void:
	var clamped_zoom: float = clampf(next_zoom, ZOOM_MIN, ZOOM_MAX)
	camera.zoom = Vector2.ONE * clamped_zoom
