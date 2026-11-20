extends Node2D
class_name World

const FIRST_ROOM = "room1"
const FIRST_ROOM_PATH = "res://src/world/rooms/room1.tscn"

@onready var player: Player = $Player
@onready var camera: Camera = $Player/Camera
@onready var rooms: RoomManager = $RoomManager
@onready var inventory: Inventory = $Inventory
@onready var objects: ObjectStateManager = $ObjectStateManager

var removed_objects := {}

static var _instance: World = null

static func get_instance() -> World:
	return _instance

static func get_player() -> Player:
	return _instance.player

static func get_camera() -> Camera:
	return _instance.camera

static func get_rooms() -> RoomManager:
	return _instance.rooms

static func get_inventory() -> Inventory:
	return _instance.inventory
	
static func get_objects() -> ObjectStateManager:
	return _instance.objects

func _enter_tree() -> void:
	_instance = self

func _exit_tree() -> void:
	if _instance == self:
		_instance = null

func _ready() -> void:
	rooms.load_room(FIRST_ROOM, preload(FIRST_ROOM_PATH))
	rooms.set_current_room(FIRST_ROOM)
