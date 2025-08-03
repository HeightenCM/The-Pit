extends CanvasLayer

var maxHealth : int = 100
var currentHealth : int = maxHealth
@onready var pause_menu = get_parent().get_node("PauseLayer").get_node("PauseMenu")
var start_wave_button
var enemies_left_label
var player
var game


func set_hp(hp):
	currentHealth = hp
	


func _on_button_pressed() -> void:
	visible = false
	pause_menu.refresh_slots()
	pause_menu.refresh_inventory()
	pause_menu.show_pause_menu()


func _on_start_wave_button_pressed() -> void:
	if is_empty():
		game.get_node("Announcement").set_text("You must have at least one bullet equipped to start a wave")
		return
	get_tree().get_current_scene().start_wave()
	start_wave_button.visible = false
	enemies_left_label.text = "Enemies left: " + str(get_tree().get_current_scene().enemy_counter)
	enemies_left_label.visible = true
	
func is_empty() -> bool:
	for slot in player.revolver_slots:
		if slot != "":
			return false
	for slot in player.shotgun_slots:
		if slot != "":
			return false
	for slot in player.rifle_slots:
		if slot != "":
			return false
	return true

func _on_ready() -> void:
	game = get_tree().get_current_scene()
	player = game.get_node("Pete")
	enemies_left_label = get_node("EnemiesLeftLabel")
	enemies_left_label.visible = false
	start_wave_button = get_node("HBoxContainer3/StartWaveButton")
