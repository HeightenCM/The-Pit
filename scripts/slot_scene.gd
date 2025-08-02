extends Control

@export var index: int
@export var item: String
@export var isEquippable: bool

var pause_menu



func _on_button_pressed() -> void:
	if isEquippable:
		pause_menu.start_selection(index)


func _on_ready() -> void:
	pause_menu = get_parent().get_parent().get_parent()
