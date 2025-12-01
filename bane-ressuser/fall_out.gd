extends Area2D




func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "ridder":
		get_tree().change_scene_to_file("res://bane-ressuser/main.tscn")
