extends "res://scripts/weapon.gd"

@onready var bulletScene = preload("res://scenes/normal_bullet.tscn")
var player

func shoot(): #for testing
	var mouse_pos = get_global_mouse_position()
	var bullet = bulletScene.instantiate()
	bullet.set_type("stun_bullet") #for testing
	$BulletSpawn/AnimatedSprite2D.play("default")
	get_parent().get_parent().add_child(bullet)
	var firing_point = $BulletSpawn.global_position
	bullet.global_position = firing_point
	bullet.direction = (mouse_pos - firing_point).normalized()

func shoot_type():
	var mouse_pos = get_global_mouse_position()
	var bullet = bulletScene.instantiate()
	bullet.set_type(player.get_next_round("revolver"))
	if bullet.type != "":
		$BulletSpawn.get_node("AnimatedSprite2D").play("default")
		get_parent().get_parent().add_child(bullet)
		var firing_point = $BulletSpawn.global_position
		bullet.global_position = firing_point
		bullet.direction = (mouse_pos - firing_point).normalized()


func _on_ready() -> void:
	player = get_tree().get_current_scene().get_node("Pete")
