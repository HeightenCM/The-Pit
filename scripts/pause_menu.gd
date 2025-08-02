extends Control

@onready var ui = get_parent().get_node("UI")
var revolver_slots := []
var shotgun_slots := []
var rifle_slots := []

func _on_resume() -> void:
	ui.visible = true
	get_tree().paused = false
	visible = false

func show_pause_menu() -> void:
	visible = true
	get_tree().paused = true


func _on_button_pressed() -> void:
	_on_resume()


func _on_ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	revolver_slots.resize(6)
	revolver_slots.fill(null)
	shotgun_slots.resize(6)
	shotgun_slots.fill(null)
	rifle_slots.resize(6)
	rifle_slots.fill(null)
