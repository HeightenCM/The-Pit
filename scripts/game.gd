extends Node2D

var isWave = false
var tutorial_complete = false
var start_wave_button
var no_wave = 0
@export var enemy_scene: PackedScene

var enemies := []
var enemy_counter: int
var speed_multiplier := []
var damage_multiplier := []

func _ready() -> void:
	enemy_scene = preload("res://scenes/enemy.tscn")
	var sheet = preload("res://assets/sprites/cursors_improved.png")
	var atlas = AtlasTexture.new()
	atlas.atlas = sheet
	atlas.region = Rect2(Vector2(0, 0), Vector2(32, 32))
	Input.set_custom_mouse_cursor(atlas, Input.CURSOR_ARROW, Vector2(32, 32))
	start_wave_button = get_node("Pete/UI/HBoxContainer3/StartWaveButton")

func start_wave() -> void:
	isWave = true
	print("wave ", no_wave, " started")
	if no_wave == 0:
		enemies.resize(10)
		enemies.fill(20)
		speed_multiplier.resize(10)
		speed_multiplier.fill(1)
		damage_multiplier.resize(10)
		damage_multiplier.fill(1.0)
	else:
		enemies.append(20)
		speed_multiplier.append(1.0)
		damage_multiplier.append(1)
		for i in enemies.size():
			speed_multiplier[i] += [0.0, 0.0, 0.0, 0.1, 0.2, 0.3].pick_random()
			enemies[i] += randi() % 6
			if randf() < 0.05:
				damage_multiplier[i] += 1
	enemy_counter = enemies.size()
	for i in enemies.size():
		var enemy = enemy_scene.instantiate()
		enemy.hp = enemies[i]
		enemy.speed = 50 * speed_multiplier[i]
		enemy.damage = 10 * damage_multiplier[i]
		var spawn_position = get_random_spawn_position()
		enemy.global_position = spawn_position
		add_child(enemy)
		await get_tree().create_timer(0.2).timeout
	
func get_random_spawn_position() -> Vector2:
	#376 396 772 792 x
	#504 484 172 152 y
	var region1_y = Vector2(112, 160)
	var region1_x = Vector2(432, 448)
	var x = 400
	var y = 400
	while x>=296 && x<=772 && y<= 484 && y >= 172:
		x = randf_range(376, 792)
		y = randf_range(152, 504)
	return Vector2(
		x,
		y
	)

func finish_wave() -> void:
	print("Wave ", no_wave, " completed")
	isWave = false
	start_wave_button.visible = true
	no_wave += 1
