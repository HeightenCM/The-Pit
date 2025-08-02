extends "res://scripts/weapon.gd"

@onready var bulletScene = preload("res://scenes/normal_bullet.tscn")

func shoot():
	var mouse_pos = get_global_mouse_position()
	var bullet = bulletScene.instantiate()
	$BulletSpawn.get_node("AnimatedSprite2D").play("default")
	get_parent().get_parent().add_child(bullet)
	var firing_point = $BulletSpawn.global_position
	bullet.global_position = firing_point
	bullet.direction = (mouse_pos - firing_point).normalized()
