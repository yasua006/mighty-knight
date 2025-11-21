extends CharacterBody2D

@export var speed: int = 500
var JUMP_VELOCITY: int = 600
var basis = 5
var gravity: int = 500.0

func _physics_process(delta: float):
	velocity = Vector2.ZERO
	velocity.y += gravity*delta
	
	# hopp (space)
	if Input.is_action_pressed("jump") and  is_on_floor():
		velocity.y = JUMP_VELOCITY
	# bevegelser (WASD / ←↑↓→)
	if Input.is_action_pressed("move_right"):
		velocity.x += basis
	if Input.is_action_pressed("move_left"):
		velocity.x -= basis
	if Input.is_action_pressed("move_down"):
		velocity.y += 5
	if Input.is_action_pressed("move_up"):
		velocity.y -= 5

	
	# håndtere samtidig bevegelser
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	# bevege med delta
	move_and_slide()
	
