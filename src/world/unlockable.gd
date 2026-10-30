extends Node2D

@export var key_id: StringName

func _on_body_entered(body: Node2D) -> void:
	var world : World = get_tree().current_scene
	if world.has_collected_item(key_id):
		world.use_item(key_id)
		get_parent().remove_from_world()
