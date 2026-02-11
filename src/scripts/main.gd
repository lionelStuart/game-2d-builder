extends Node2D

const CAMERA_SPEED: float = 600.0
const ZOOM_STEP: float = 0.1
const ZOOM_MIN: float = 0.6
const ZOOM_MAX: float = 2.0
const GRID_SIZE: int = 32
const HALF_GRID: float = GRID_SIZE / 2.0

const PREVIEW_VALID_COLOR: Color = Color(0.3, 0.95, 0.45, 0.45)
const PREVIEW_BLOCKED_COLOR: Color = Color(0.95, 0.3, 0.3, 0.45)
const PLACED_TILE_COLOR: Color = Color(0.71, 0.58, 0.37, 1.0)

@onready var camera: Camera2D = $Camera2D
@onready var placement_layer: Node2D = $PlacementLayer
@onready var hud_label: Label = $CanvasLayer/MarginContainer/Label

var occupied_cells: Dictionary = {}
var preview_tile: Polygon2D

func _ready() -> void:
	preview_tile = _create_tile(PREVIEW_VALID_COLOR)
	preview_tile.z_index = 10
	add_child(preview_tile)
	_update_hud_text()

func _process(delta: float) -> void:
	_handle_camera_pan(delta)
	_update_preview_tile()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_set_zoom(camera.zoom.x - ZOOM_STEP)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_set_zoom(camera.zoom.x + ZOOM_STEP)
		elif event.button_index == MOUSE_BUTTON_LEFT:
			_try_place_tile()

func _handle_camera_pan(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

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

func _update_preview_tile() -> void:
	var cell: Vector2i = _mouse_cell()
	preview_tile.position = _cell_to_world(cell)
	preview_tile.color = PREVIEW_BLOCKED_COLOR if occupied_cells.has(cell) else PREVIEW_VALID_COLOR

func _try_place_tile() -> void:
	var cell: Vector2i = _mouse_cell()
	if occupied_cells.has(cell):
		return

	occupied_cells[cell] = true
	var placed_tile: Polygon2D = _create_tile(PLACED_TILE_COLOR)
	placed_tile.position = _cell_to_world(cell)
	placement_layer.add_child(placed_tile)
	_update_hud_text()

func _mouse_cell() -> Vector2i:
	return _world_to_cell(get_global_mouse_position())

func _world_to_cell(world_position: Vector2) -> Vector2i:
	return Vector2i(
		int(floor(world_position.x / float(GRID_SIZE))),
		int(floor(world_position.y / float(GRID_SIZE)))
	)

func _cell_to_world(cell: Vector2i) -> Vector2:
	return Vector2(
		float(cell.x * GRID_SIZE) + HALF_GRID,
		float(cell.y * GRID_SIZE) + HALF_GRID
	)

func _create_tile(tile_color: Color) -> Polygon2D:
	var tile: Polygon2D = Polygon2D.new()
	tile.polygon = PackedVector2Array([
		Vector2(-HALF_GRID, -HALF_GRID),
		Vector2(HALF_GRID, -HALF_GRID),
		Vector2(HALF_GRID, HALF_GRID),
		Vector2(-HALF_GRID, HALF_GRID)
	])
	tile.color = tile_color
	return tile

func _update_hud_text() -> void:
	hud_label.text = "2D Builder - Day 2 Prototype\nLeft Click: Place tile | Mouse wheel: Zoom\nPlaced tiles: %d" % occupied_cells.size()

func _set_zoom(next_zoom: float) -> void:
	var clamped_zoom: float = clampf(next_zoom, ZOOM_MIN, ZOOM_MAX)
	camera.zoom = Vector2.ONE * clamped_zoom
