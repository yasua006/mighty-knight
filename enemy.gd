extends CharacterBody2D

@export var player = Node

var attack_sound: Resource = preload("res://attack_sound.tscn")
var new_attack_sound: AudioStreamPlayer2D = attack_sound.instantiate()

var is_chase: bool = false

var direction: float = 0

const SPEED: int = 150
const JUMP_VELOCITY: int = -400


func handle_hackers(value: int) -> void:
	if value < 0 or is_nan(float(value)):
		value = 0


func _physics_process(delta: float) -> void:
	handle_hackers(SPEED)
	handle_hackers(JUMP_VELOCITY)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_chase:
		$AnimatedSprite2D.play("Attack")
		
		if new_attack_sound.get_parent() == null:
			add_child(new_attack_sound)
		
		if player.global_position.x < global_position.x:
			direction = -1
			$AnimatedSprite2D.flip_h = true
		else:
			direction = 1
			$AnimatedSprite2D.flip_h = false
			
		if not new_attack_sound.playing:
			new_attack_sound.play()
	else:
		$AnimatedSprite2D.play("Idle")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func _on_ditection_area_body_entered(body: Node2D) -> void:
	#print(body.name)
	if body.name == "ridder":
		is_chase = true


func _on_ditection_area_body_exited(body: Node2D) -> void:
	if body.name == "ridder":
		is_chase = false
