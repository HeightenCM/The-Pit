extends Control

@export var index: int
@export var item: String
@export var isEquippable: bool

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

func set_item(new_item) -> void:
	item = new_item
	if item != "":
		add_sprite()

func add_sprite() -> void:
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://icon.svg")
	sprite.scale = Vector2(0.2, 0.2)
	add_child(sprite)
