extends Control
#
#var previous_speed: int = 0
#
#
#func _ready() -> void:
	#$level_label.hide()
	#$level_label_timer.start()
#
#
#func _on_level_label_timer_timeout() -> void:
	#$level_label.show()
	#
	#previous_speed = $"/root/Rydder".speed
	#$"/root/Rydder".speed = 0
	##$"/root/Rydder".hide()
	#
	## spill animasjon
	#$level_label/anim.play("fade_label")
#
#
#func _on_anim_animation_finished(anim_name: StringName) -> void:
	#if not anim_name.is_empty():
		#$level_label.hide()
		#$"/root/Rydder".speed = previous_speed
		##$"/root/Rydder".show()
