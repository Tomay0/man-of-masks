extends Area2D

func _on_body_entered(body):
	body.jump(1.25)
