extends Node2D
class_name RoomManager

const FIRST_ROOM = "room1"
const FIRST_ROOM_PATH = "res://src/world/rooms/room1.tscn"

@onready var rooms_node := $LoadedRooms
var current_room: Room = null
var current_checkpoint: Vector2

var current_room_id: StringName
var loaded_rooms := {}

func load_room(room_id: StringName, room_scene: PackedScene=null):	
	var room_path := "res://src/world/rooms/%s.tscn" % room_id
	
	if room_scene == null:
		room_scene = load(room_path)
		if room_scene == null:
			push_error("Could not load room: " + str(room_path))
			return
	
	var room : Room = room_scene.instantiate()
	loaded_rooms[room_id] = room
	rooms_node.add_child(room)

func unload_room(room_id: StringName):
	var room : Room = loaded_rooms[room_id]
	if room == null:
		return
		
	rooms_node.remove_child(room)
	loaded_rooms.erase(room_id)
	room.queue_free()

func _get_closest_position(start_position: Vector2, possible_positions: Array[Vector2]) -> Vector2:
	var closest_position: Vector2 = Vector2.ZERO
	var closest_distance: float = INF

	for pos in possible_positions:
		var distance = start_position.distance_squared_to(pos)

		if distance < closest_distance:
			closest_distance = distance
			closest_position = pos

	return closest_position

func set_current_room(room_id: StringName):
	if room_id == current_room_id:
		return
	
	print("setting current room to " + room_id)
	current_room = loaded_rooms[room_id]
	
	current_checkpoint = _get_closest_position(World.get_player().global_position, current_room.get_checkpoints())

	current_room_id = room_id
	
	set_loaded_rooms()
	
	if Debug.FREE_CAM:
		return
	
	World.get_camera().smooth_transition_into_room(current_room)


# when transitioning to a new room - load all adjacent rooms to it and unload any that are not.
func set_loaded_rooms():
	for room_id in current_room.adjacent_room_ids:
		if not loaded_rooms.keys().has(room_id):
			load_room(room_id)
	
	for room_id in loaded_rooms.keys():
		if room_id != current_room_id and room_id not in current_room.adjacent_room_ids:
			unload_room(room_id)

func reset_room():
	if current_room == null:
		return
	
	unload_room(current_room_id)
	load_room(current_room_id)
	current_room = loaded_rooms[current_room_id]
	World.get_player().global_position = current_checkpoint
