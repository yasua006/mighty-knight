extends CharacterBody2D

@export var speed: int = 500
var JUMP_VELOCITY: int = 400
var move_thingy: int = 5


func _physics_process(_delta: float) -> void:
	#velocity = Vector2.ZERO
	#
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	
	## hopp (space)
	#if Input.is_action_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	# bevegelser (WASD / ←↑↓→)
	if Input.is_action_pressed("move_right"):
		velocity.x += move_thingy
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_thingy
	if Input.is_action_pressed("move_down"):
		velocity.y += move_thingy
	if Input.is_action_pressed("move_up"):
		velocity.y -= move_thingy
	
	# håndtere samtidig bevegelser
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	# bevege med delta
	move_and_slide()
