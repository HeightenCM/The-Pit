extends Control

@export var offset := Vector2(-40, -60)

func _process(delta):
	position = get_viewport().get_mouse_position() - size/2 + offset
