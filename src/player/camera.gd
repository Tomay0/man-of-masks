extends Camera2D

# @export var CAMERA_SMOOTHING_SPEED: float = 5.0

var transitioning_room: Room = null
var tween: Tween = null

func smooth_transition_into_room(room: Room):
	if camera_is_contained(room):
		set_limit_to_room(room)
		return
	
	transitioning_room = room
	
	set_global_position_by_limit()
	increase_limits_into_transitioning_room()
	tween_to_transitioning_room()

# Before transitioning, the camera bounds is outside the room's limits.
# We need to adjust the camera back into the current limits before starting the animation
func set_global_position_by_limit():
	var half_view: Vector2 = get_viewport_rect().size / zoom / 2.0
	
	if (global_position.x > limit_right - half_view.x):
		global_position.x = limit_right - half_view.x
	elif (global_position.x < limit_left + half_view.x):
		global_position.x = limit_left + half_view.x
		
	if (global_position.y > limit_bottom - half_view.y):
		global_position.y = limit_bottom - half_view.y
	elif (global_position.y < limit_top + half_view.y):
		global_position.y = limit_top + half_view.y
	

func increase_limits_into_transitioning_room():
	var bounds := transitioning_room.get_room_bounds()
	
	limit_left = min(floori(bounds.position.x), limit_left)
	limit_top = min(floori(bounds.position.y), limit_top)
	limit_right = max(ceili(bounds.end.x), limit_right)
	limit_bottom = max(ceili(bounds.end.y), limit_bottom)
	

func tween_to_transitioning_room():
	if (tween != null):
		tween.kill()

	var target_pos = target_position(transitioning_room)

	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	
	if (target_pos.x == global_position.x):
		tween.tween_property(self, "global_position:y", target_pos.y, 0.25)
	elif (target_pos.y == global_position.y):
		tween.tween_property(self, "global_position:x", target_pos.x, 0.25)
	else:
		tween.tween_property(self, "global_position", target_position(transitioning_room), 0.25)
	tween.tween_callback(tween_callback)

func tween_callback():
	tween = null
	set_limit_to_room(transitioning_room)

func set_limit_to_room(room: Room):
	var bounds := room.get_room_bounds()
	
	limit_left = floori(bounds.position.x)
	limit_top = floori(bounds.position.y)
	limit_right = ceili(bounds.end.x)
	limit_bottom = ceili(bounds.end.y)
	
	# reset tween
	if (tween != null):
		tween.kill()
		tween = null
	
	# resets player offsets from tween animation
	position.x = 0
	position.y = 0
	
	transitioning_room = null

func camera_is_contained(room: Room) -> bool:
	var bounds = room.get_room_bounds()
	var view_bounds := get_viewport_rect().size / zoom

	var camera_bounds := Rect2(
		global_position - view_bounds / 2.0,
		view_bounds
	)

	return bounds.encloses(camera_bounds)

func target_position(room: Room) -> Vector2:
	print("CALCULATING TARGET POS")
	print("global: " + str(global_position))
	var bounds := room.get_room_bounds()
	print("room bounds: " + str(bounds))
	print("viewport size: " + str(get_viewport_rect().size / zoom))
	var half_view: Vector2 = get_viewport_rect().size / zoom / 2.0

	var target_x: float = global_position.x
	var target_y: float = global_position.y
	
	print(bounds.end.x - half_view.x)

	if global_position.x < bounds.position.x + half_view.x:
		target_x = bounds.position.x + half_view.x
	elif global_position.x > bounds.end.x - half_view.x:
		target_x = bounds.end.x - half_view.x

	if global_position.y < bounds.position.y + half_view.y:
		target_y = bounds.position.y + half_view.y
	elif global_position.y > bounds.end.y - half_view.y:
		target_y = bounds.end.y - half_view.y
		
	print("target: " + str(target_x) + ", " + str(target_y))

	return Vector2(target_x, target_y)
	


func _process(delta: float) -> void:
	if transitioning_room == null:
		return
	
	if (camera_is_contained(transitioning_room)):
		set_limit_to_room(transitioning_room)
