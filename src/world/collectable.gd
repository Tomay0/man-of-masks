extends Area2D

@export var item_id: StringName

func _on_body_entered(body: Node2D) -> void:
	World.get_inventory().collect_item(item_id)
	get_parent().remove_from_world()
