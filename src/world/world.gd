extends Node2D
class_name World

const FIRST_ROOM = "room1"
const FIRST_ROOM_PATH = "res://src/world/rooms/room1.tscn"
const DEBUG_FREE_CAM = false

@onready var player := $Player
@onready var camera := $Player/Camera

@onready var rooms_node := $LoadedRooms
var current_room: Room

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
	

func set_current_room(room_id: StringName):
	if room_id == current_room_id:
		return

	current_room_id = room_id
	current_room = loaded_rooms[room_id]
	
	set_loaded_rooms()
	
	if DEBUG_FREE_CAM:
		return
	
	camera.smooth_transition_into_room(current_room)

# when transitioning to a new room - load all adjacent rooms to it and unload any that are not.
func set_loaded_rooms():
	for room_id in current_room.adjacent_room_ids:
		if not loaded_rooms.keys().has(room_id):
			load_room(room_id)
	
	for room_id in loaded_rooms.keys():
		if room_id != current_room_id and room_id not in current_room.adjacent_room_ids:
			unload_room(room_id)


func _ready() -> void:
	load_room(FIRST_ROOM, preload(FIRST_ROOM_PATH))
	set_current_room(FIRST_ROOM)
