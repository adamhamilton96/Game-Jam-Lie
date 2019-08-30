extends KinematicBody2D

const walkSpeed = 100

#Jump 
export var fallMultiplier = 2 
export var lowJumpMultiplier = 10 
export var jumpVelocity = 400 #Jump height

var velocity = Vector2()
var gravity = 800

func _process(delta):
	if velocity.x == 0 && velocity.y == 0:
		$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("running")
		
	if velocity.x <0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walkSpeed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  walkSpeed
		kill()
	else:
		velocity.x = 0
	move_and_slide(velocity, Vector2(0, -1))
	
	handleJump()


func handleJump():
	# Jump code from this post -> https://godotengine.org/qa/25897/2d-platformer-how-to-control-jump-height-mario-like-jumps
	
	if velocity.y > 0: 
	    velocity += Vector2.UP * (-9.81) * (fallMultiplier) 
	
	elif velocity.y < 0 && Input.is_action_just_released("ui_up"): 
		velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier)
	
	if is_on_floor():
	    if Input.is_action_just_pressed("ui_up"): 
	        velocity = Vector2.UP * jumpVelocity
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
func kill():
	$Particles2D.emitting = true
	$AnimatedSprite.visible = false
	gravity = 0
	velocity.y = 0
