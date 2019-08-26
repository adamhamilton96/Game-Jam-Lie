extends KinematicBody2D

const gravity = 200.0
const walkSpeed = 200

var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walkSpeed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  walkSpeed
	else:
		velocity.x = 0
	move_and_slide(velocity, Vector2(0, -1))