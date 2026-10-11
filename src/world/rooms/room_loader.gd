extends Area2D

@export var target_room_id: StringName
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	var world := get_tree().current_scene # TODO: better way to get the world manager
	
	world.ensure_room_loaded(target_room_id)

func _on_body_exited(body: Node2D) -> void:
	var world := get_tree().current_scene
	
	world.ensure_room_unloaded(target_room_id)
