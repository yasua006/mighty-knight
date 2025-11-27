extends CharacterBody2D
 
@export var speed: int = 500
var jump_velocity: int = -650
var gravity: int = 1500


func handle_hackers(value: int) -> void:
	if value < 0 or is_nan(float(value)):
		value = 0


func _physics_process(delta: float):
	handle_hackers(speed)
	handle_hackers(jump_velocity)
	handle_hackers(gravity)
	
	# unngå dobbel hopp, trippel hopp, osv.
	if not is_on_floor():
		velocity.y += gravity * delta
 
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity
 
	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed
 
	move_and_slide()
