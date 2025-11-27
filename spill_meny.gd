extends Control

var music = null
var ridder = null

var old_speed: int = 0

var debounce_esc: bool = false

var is_closed: bool = false # brukt for håndtering av esc meny visning
var is_start_done: bool = false # brukt for å få ikke esc menyen, før man trykker på start


func _ready() -> void:
	music = get_tree().root.get_child(0)
	music.playing = false
	
	ridder = get_tree().root.get_child(1).get_child(1)
	old_speed = ridder.speed
	
	ridder.speed = 0


# ----hoved menyen----
func _on_start_btn_pressed() -> void:
	$hoved_container.hide()
	$bakgrunn_bilde.hide()
	
	# start å spille musikk
	music.playing = true
	
	# få førrige hastigheten
	ridder.speed = old_speed
	
	is_start_done = true


func _on_settings_btn_pressed() -> void:
	$hoved_container.hide()
	$settings_container.show()


func _on_exit_btn_pressed() -> void:
	get_tree().quit()


# ----innstillinger menyen----
func _on_animations_btn_toggled(toggled_on: bool) -> void:
	var anim: AnimationPlayer = get_tree().root.get_child(1).get_child(3).get_child(0).get_child(0)
	
	if toggled_on:
		anim.active = false
	else:
		anim.active = true


func _on_shadows_btn_toggled(toggled_on: bool) -> void:
	var lys: PointLight2D = $"/root/main/ridder/PointLight2D"
	
	if toggled_on:
		lys.shadow_enabled = true
	else:
		lys.shadow_enabled = false


func _on_close_btn_pressed() -> void:
	$hoved_container.show()
	$settings_container.hide()


func esc_meny_hjelper() -> void:
	$esc_container.hide()
	music.stream_paused = false
	ridder.speed = old_speed
	is_closed = false


# ----esc menyen----
func _input(event: InputEvent) -> void:
	if not is_start_done: return
	
	if event.is_action_pressed("esc"):
		if debounce_esc: return
		debounce_esc = true
		$esc_container/debounce_esc.start()
		
		if not is_closed:
			$esc_container.show()
			# pause musikken
			music.stream_paused = true
			ridder.speed = 0
			is_closed = true
		else:
			esc_meny_hjelper()


func _on_debounce_esc_timeout() -> void:
	debounce_esc = false


func _on_resume_btn_pressed() -> void:
	esc_meny_hjelper()
