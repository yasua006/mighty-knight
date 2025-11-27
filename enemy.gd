extends CharacterBody2D

@export var player = Node
var chase: bool = false

const SPEED: int = 150
const JUMP_VELOCITY: int = -400


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction: int = 0
	
	if chase:
		if player.global_position.x < global_position.x:
			direction = -1
		else:
			direction = 1
			
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "ridder":
		chase = true


func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "ridder":
		chase = false
