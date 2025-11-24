extends CharacterBody2D
 
@export var speed: int = 500
var JUMP_VELOCITY: float = -600
var gravity: float = 1500 # typisk platformer gravitasjon


func _physics_process(delta: float):
	# unngå dobbel hopp, trippel hopp, osv.
	if not is_on_floor():
		velocity.y += gravity * delta
 
	# hopp
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
 
	# horizontal bevegelse
	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * speed
 
	move_and_slide()
	

# brukes ikke
#func _on_area_2d_area_entered(_area: Area2D) -> void:
	#position.y -= 300
	
