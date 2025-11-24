extends CharacterBody2D
 
@export var speed: int = 500
var JUMP_VELOCITY: float = -600.0   # negative = up in Godot
var gravity: float = 1500.0         # typical platformer gravity
var pos = position
 
func _physics_process(delta: float):
 
	# Apply gravity only when not on floor
	if not is_on_floor():
		velocity.y += gravity * delta
 
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
 
	# Horizontal movement
	var dir := Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed
 
	# Move the character
	move_and_slide()
 
 
	
 
 
func _on_area_2d_area_entered(area: Area2D) -> void:
	position.y -= 300
