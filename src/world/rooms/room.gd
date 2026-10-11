extends Node2D
class_name Room

var room_id: StringName

@export var adjacent_room_ids: Array[String] = []

@onready var border: CollisionShape2D = $RoomBorder/RoomBorderCollision

func _ready() -> void:
	room_id = scene_file_path.trim_prefix("res://src/world/rooms/").trim_suffix(".tscn")

func get_room_bounds() -> Rect2:
	var shape := border.shape as RectangleShape2D
	var size := shape.size
	var center := border.global_position

	return Rect2(center - size / 2.0, size)
