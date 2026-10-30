extends Area2D

func _on_body_entered(body: Node2D) -> void:

	var world := get_tree().current_scene
	
	world.reset_room()
