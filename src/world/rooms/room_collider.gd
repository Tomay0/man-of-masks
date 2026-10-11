extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	var world := get_tree().current_scene # TODO: better way to get the world manager
	
	world.set_current_room(get_parent().room_id)
