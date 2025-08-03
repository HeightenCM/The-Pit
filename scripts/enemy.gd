extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
var player
@export var speed: float = 50.0
@export var damage: int = 10
@export var hp: int = 20
var game


func _on_ready() -> void:
	player = get_parent().get_node("Pete")
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 8.0
	game = get_tree().get_current_scene()

func _physics_process(_delta):
	if player:
		agent.set_target_position(player.global_position)

		if agent.is_navigation_finished():
			return

		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		velocity = direction * speed
		move_and_slide()



func _on_enemy_attack_area_area_entered(area: Area2D) -> void:
	pass

func receive_damage(area: Area2D) -> void:
	var bullet = area.get_parent()
	var damage = bullet.damage
	bullet.on_hit_enemy(self)
	hp -= damage
	if hp <= 0:
		die()

func die() -> void:
	game.update_enemies_left()
	print(game.enemy_counter)
	if game.enemy_counter <= 0:
		game.finish_wave()
	queue_free()

func stun(time) -> void:
	set_physics_process(false)
	await get_tree().create_timer(time).timeout
	set_physics_process(true)


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "BulletDamageArea":
		receive_damage(area)
