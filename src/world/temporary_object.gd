extends Node
class_name TemporaryObject

@export var object_id: StringName

func _ready() -> void:
	var world : World = get_tree().current_scene
	
	if world.should_remove_object(object_id):
		queue_free()

func remove_from_world() -> void:
	var world : World = get_tree().current_scene
	world.remove_object(object_id)
	queue_free()
