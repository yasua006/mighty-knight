extends Control

var rydder = null
var ny_rydder = null


func _ready() -> void:
	$level_label.hide()
	$level_label_timer.start()


func _on_level_label_timer_timeout() -> void:
	$level_label.show()
	
	# vis nivå animasjon
	$level_label/anim.play("fade_label")


func _on_anim_animation_finished(_anim_name: StringName) -> void:
	$level_label.hide()
