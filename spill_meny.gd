extends Control

var music = null
var ridder = null

var old_speed: int = 0

var is_start_done: bool = false # brukt for å få ikke esc menyen, før man trykker på start
var is_closed: bool = false # brukt for håndtering av esc meny visning

var debounces:= {
	"debounce_start_btn": false,
	"debounce_settings_btn": false,
	"debounce_quit_btn": false,
	"debounce_animations_btn": false,
	"debounce_shadows_btn": false,
	"debounce_close_btn": false,
	"debounce_esc": false,
	"debounce_resume_btn": false
}


func _ready() -> void:
	music = get_tree().root.get_child(0)
	music.playing = false
	
	ridder = get_tree().root.get_child(1).get_child(1)
	old_speed = 500
	#print("gammel hastighet (spill meny) ", old_speed)
	ridder.speed = 0


# ----hoved menyen----
func _on_start_btn_pressed() -> void:
	if debounces.debounce_start_btn: return
	debounces.debounce_start_btn = true
	$hoved_container/debounce_start_btn.start()
	
	$hoved_container.hide()
	$bakgrunn_bilde.hide()
	
	music.playing = true
	
	is_start_done = true


func _on_debounce_start_btn_timeout() -> void:
	debounces.debounce_start_btn = false


func _on_settings_btn_pressed() -> void:
	if debounces.debounce_settings_btn: return
	debounces.debounce_settings_btn = true
	$hoved_container/debounce_settings_btn.start()
	
	$hoved_container.hide()
	$settings_container.show()


func _on_debounce_settings_btn_timeout() -> void:
	debounces.debounce_settings_btn = false


func _on_quit_btn_pressed() -> void:
	if debounces.debounce_quit_btn: return
	debounces.debounce_quit_btn = true
	$hoved_container/debounce_quit_btn.start()
	
	get_tree().quit()


func _on_debounce_quit_btn_timeout() -> void:
	debounces.debounce_quit_btn = false


# ----innstillinger menyen----
func _on_animations_btn_toggled(toggled_on: bool) -> void:
	if debounces.debounce_animations_btn: return
	debounces.debounce_animations_btn = true
	$settings_container/debounce_animations_btn.start()
	
	var anim: AnimationPlayer = get_tree().root.get_child(1).get_child(3).get_child(0).get_child(0)
	
	if toggled_on:
		anim.active = false
	else:
		anim.active = true


func _on_debounce_animations_btn_timeout() -> void:
	debounces.debounce_animations_btn = false


func _on_shadows_btn_toggled(toggled_on: bool) -> void:
	if debounces.debounce_shadows_btn: return
	debounces.debounce_shadows_btn = true
	$settings_container/debounce_shadows_btn.start()
	
	var lys: PointLight2D = $"/root/main/ridder/PointLight2D"
	
	if toggled_on:
		lys.shadow_enabled = true
	else:
		lys.shadow_enabled = false


func _on_debounce_shadows_btn_timeout() -> void:
	debounces.debounce_shadows_btn = false


func _on_close_btn_pressed() -> void:
	if debounces.debounce_close_btn: return
	debounces.debounce_close_btn = true
	$settings_container/debounce_close_btn.start()
	
	$hoved_container.show()
	$settings_container.hide()


func _on_debounce_close_btn_timeout() -> void:
	debounces.debounce_close_btn = false


func esc_meny_hjelper() -> void:
	$esc_container.hide()
	music.stream_paused = false
	ridder.speed = old_speed
	is_closed = false


# ----esc menyen----
func _input(event: InputEvent) -> void:
	if not is_start_done: return
	
	if event.is_action_pressed("esc"):
		if debounces.debounce_esc: return
		debounces.debounce_esc = true
		$esc_container/debounce_esc.start()
		
		if not is_closed:
			$esc_container.show()
			music.stream_paused = true
			ridder.speed = 0
			is_closed = true
		else:
			esc_meny_hjelper()


func _on_debounce_esc_timeout() -> void:
	debounces.debounce_esc = false


func _on_resume_btn_pressed() -> void:
	if debounces.debounce_resume_btn: return
	debounces.debounce_resume_btn = true
	$esc_container/debounce_resume_btn.start()
	
	esc_meny_hjelper()


func _on_debounce_resume_btn_timeout() -> void:
	debounces.debounce_resume_btn = false
