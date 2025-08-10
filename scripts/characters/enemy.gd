extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
var player
@export var speed: float = 50.0
@export var damage: int = 10
@export var hp: int = 20
@export var isStuned: bool = false
@onready var health_bar = $HealthBar
var pickup_scene: PackedScene
var game

	

func _on_ready() -> void:
	#health_bar = get_node("HealthBar")
	pickup_scene = preload("res://scenes/pickup.tscn")
	health_bar.value = health_bar.max_value
	player = get_parent().get_node("Pete")
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 8.0
	game = get_tree().get_current_scene()

func _physics_process(_delta):
	if player and !isStuned:
		agent.set_target_position(player.global_position)

		if agent.is_navigation_finished():
			return

		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		velocity = direction * speed
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		move_and_slide()



func _on_enemy_attack_area_area_entered(area: Area2D) -> void:
	pass

func receive_damage(area: Area2D) -> void:
	var bullet = area.get_parent() as Bullet
	var bullet_damage = bullet.data.damage
	bullet.on_hit_enemy(self)
	set_hp(hp-bullet_damage)
	if hp <= 0:
		die()

func die() -> void:
	game.update_enemies_left()
	print(game.enemy_counter)
	decide_drop()
	if game.enemy_counter <= 0:
		game.finish_wave()
	queue_free()

func stun(time) -> void:
	isStuned = !isStuned
	await get_tree().create_timer(time).timeout
	isStuned = !isStuned


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "BulletDamageArea":
		receive_damage(area)

func set_max_hp(value) -> void:
	set_hp(value)
	health_bar.max_value = value
	
func set_hp(value: int) -> void:
	hp = value
	health_bar.value = value

func decide_drop() -> void:
	var rand_int = randi() % 100 + 1
	if rand_int == 1:
		spawn_pickup_bullet(load("res://resources/explosive_bullet.tres"))
	elif rand_int <= 11:
		spawn_pickup_bullet(load("res://resources/normal_bullet.tres"))
	elif  rand_int <= 15:
		spawn_pickup_bullet(load("res://resources/electro_bullet.tres"))

func spawn_pickup_bullet(type):
	var pickup = pickup_scene.instantiate()
	pickup.set_item(type)
	pickup.global_position = global_position
	game.call_deferred("add_child", pickup)
