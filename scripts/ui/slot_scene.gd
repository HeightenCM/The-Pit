extends Control

@export var index: int
@export var item: BulletData
@export var isEquippable: bool
@onready var infoPanel: Control

var pause_menu

func _on_button_pressed() -> void:
	if isEquippable:
		pause_menu.start_selection(index)
	else:
		pause_menu.select(index)

func _on_ready() -> void:
	if isEquippable:
		pause_menu = get_parent().get_parent().get_parent().get_parent()
	else:
		pause_menu = get_parent().get_parent()
	infoPanel = pause_menu.get_node("info_panel")

func set_item(new_item) -> void:
	item = new_item
	if item:
		$TextureRect.texture = item.inventory_icon


func _on_mouse_entered() -> void:
	infoPanel.updateInfoBulletData(item)
	
