extends Camera2D

@export var CAMERA_SMOOTHING_SPEED: float = 5.0

var transitioning_room: Room = null

func get_bounds() -> Rect2:
	return transitioning_room.get_room_bounds()

func set_room_bounds(room: Room):
	transitioning_room = room
	if camera_is_contained():
		transitioning_room = null
		return
	
	var bounds := get_bounds()
	
	limit_left = min(floori(bounds.position.x), limit_left)
	limit_top = min(floori(bounds.position.y), limit_top)
	limit_right = max(ceili(bounds.end.x), limit_right)
	limit_bottom = max(ceili(bounds.end.y), limit_bottom)

func half_view() -> Vector2:
	return get_viewport_rect().size / zoom / 2.0

func camera_is_contained() -> bool:
	var bounds = get_bounds()
	var half_view := half_view()

	var camera_bounds := Rect2(
		global_position - half_view,
		half_view * 2.0
	)
	
	print(camera_bounds)
	print(bounds)

	return bounds.encloses(camera_bounds)

func target_position() -> Vector2:
	var bounds := get_bounds()
	var half_view: Vector2 = get_viewport_rect().size / zoom / 2.0

	var target_x: float
	var target_y: float

	if global_position.x < bounds.get_center().x:
		target_x = bounds.position.x + half_view.x
	else:
		target_x = bounds.end.x - half_view.x

	if global_position.y < bounds.get_center().y:
		target_y = bounds.position.y + half_view.y
	else:
		target_y = bounds.end.y - half_view.y

	return Vector2(target_x, target_y)
	


func _process(delta: float) -> void:
	if transitioning_room == null:
		return
	
	var target_position = target_position()
	
	var bounds := get_bounds()

	# Calculate where the camera should be in the new room.
	

	# Smoothly move towards the target.
	var weight := 1.0 - exp(-CAMERA_SMOOTHING_SPEED * delta)
	global_position = global_position.lerp(target_position, weight)

	# Finish when close enough to the target.
	if global_position.distance_to(target_position) < 1.0:
		global_position = target_position
	
	print(camera_is_contained())
	
	if camera_is_contained():
		limit_left = floori(bounds.position.x)
		limit_top = floori(bounds.position.y)
		limit_right = ceili(bounds.end.x)
		limit_bottom = ceili(bounds.end.y)
		transitioning_room = null
