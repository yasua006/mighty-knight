extends Control

var ridder = null
var ny_ridder = null

var old_speed: int = 0


func _ready() -> void:
	$level_label.hide()
	$level_label_timer.start()
	
	ridder = get_tree().root.get_child(1).get_child(1)
	old_speed = ridder.speed
	#print("gammel hastighet (HUD) ", old_speed)
	ridder.speed = 0


func _on_level_label_timer_timeout() -> void:
	$level_label.show()
	
	if not $level_label/anim.active:
		$level_label.position = Vector2(300, 150)
		$anim_av_timer.start()
	else:
		$level_label/anim.play("fade_label")


func anim_hjelper() -> void:
	$level_label.hide()
	ridder.speed = old_speed


func _on_anim_av_timer_timeout() -> void:
	anim_hjelper()


func _on_anim_animation_finished(_anim_name: StringName) -> void:
	anim_hjelper()
