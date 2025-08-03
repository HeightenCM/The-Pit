extends CanvasLayer

var maxHealth : int = 100
var currentHealth : int = maxHealth
@onready var pause_menu = get_parent().get_node("PauseLayer").get_node("PauseMenu")
var start_wave_button


func set_hp(hp):
	currentHealth = hp
	


func _on_button_pressed() -> void:
	visible = false
	pause_menu.refresh_slots()
	pause_menu.refresh_inventory()
	pause_menu.show_pause_menu()


func _on_start_wave_button_pressed() -> void:
	get_tree().get_current_scene().start_wave()
	start_wave_button.visible = false
	


func _on_ready() -> void:
	start_wave_button = get_node("HBoxContainer3/StartWaveButton")
