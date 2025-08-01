extends CanvasLayer

var maxHealth : int = 100
var currentHealth : int = maxHealth
@onready var pause_menu = get_parent().get_node("PauseMenu")


func set_hp(hp):
	currentHealth = hp
	


func _on_button_pressed() -> void:
	pause_menu.show_pause_menu()
