extends Node
class_name TemporaryObject

@export var object_id: StringName

func _ready() -> void:
	var object_state_manager := World.get_objects()

	if object_state_manager.should_remove(object_id):
		queue_free()

func remove_from_world() -> void:
	var object_state_manager := World.get_objects()
	object_state_manager.remove(object_id)
	queue_free()
