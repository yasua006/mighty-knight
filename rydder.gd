extends CharacterBody2D

@export var speed: int = 600


func _process(_delta: float) -> void:
	velocity = Vector2.ZERO
	
	# bevegelser
	if Input.is_action_pressed("move_right"):
		velocity.x += 20
	if Input.is_action_pressed("move_left"):
		velocity.x -= 20
	if Input.is_action_pressed("move_down"):
		velocity.y += 20
	if Input.is_action_pressed("move_up"):
		velocity.y -= 20
	
	# håndtere samtidig bevegelser
	if velocity.length() < 0:
		velocity = velocity.normalized() * speed
	
	# bevege
	move_and_slide()
