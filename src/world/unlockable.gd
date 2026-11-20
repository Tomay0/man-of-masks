extends Node2D

@export var key_id: StringName

func _on_body_entered(body: Node2D) -> void:
	var inventory := World.get_inventory()
	if inventory.has_collected_item(key_id):
		inventory.use_item(key_id)
		get_parent().remove_from_world()
