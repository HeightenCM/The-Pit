extends "res://scripts/weapon.gd"

@onready var bulletScene = preload("res://scenes/normal_bullet.tscn")

func shoot():
	var mouse_pos = get_global_mouse_position()
	var bullet = bulletScene.instantiate()
	bullet.position = $Sprite2D.get_child(0).position
	bullet.direction = (mouse_pos - global_position)
	print(bullet.direction)
	get_parent().add_child(bullet)
