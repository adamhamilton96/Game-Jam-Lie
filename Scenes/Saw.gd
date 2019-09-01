extends Area2D

func _process(delta):
	rotation_degrees += 1


func _on_Saw_body_entered(body):
	if body.get_name() == "Character":
		body.kill()
