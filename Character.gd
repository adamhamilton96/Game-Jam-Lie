extends KinematicBody2D

const gravity = 20
const walkSpeed = 200

#Jump 
export var fallMultiplier = 2 
export var lowJumpMultiplier = 10 
export var jumpVelocity = 400 #Jump height

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
	
	handleJump()


func handleJump():
	# Jump code from this post -> https://godotengine.org/qa/25897/2d-platformer-how-to-control-jump-height-mario-like-jumps
	velocity.y += gravity 
	
	if velocity.y > 0: 
	    velocity += Vector2.UP * (-9.81) * (fallMultiplier) 
	
	elif velocity.y < 0 && Input.is_action_just_released("ui_up"): 
	    velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier)
	
	if is_on_floor():
	    if Input.is_action_just_pressed("ui_up"): 
	        velocity = Vector2.UP * jumpVelocity
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
