extends CharacterBody2D

const SPEED = 5000.0

@export var orbit_radius: float = 25.0  # Distance from parent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hp_bar
var current_weapon: Weapon = null

var revolver_slots := []
var shotgun_slots := []
var rifle_slots := []
var inventory := []
var pause_menu
var hp = 100

func _ready() -> void:
	revolver_slots.resize(6)
	revolver_slots.fill("")
	shotgun_slots.resize(12)
	shotgun_slots.fill("")
	rifle_slots.resize(16)
	rifle_slots.fill("")
	inventory.resize(40)
	inventory.fill("")
	if has_node("PauseLayer/PauseMenu"):
		pause_menu = get_node("PauseLayer/PauseMenu")
		pause_menu.revolver_slots = revolver_slots;
		pause_menu.shotgun_slots = shotgun_slots;
		pause_menu.rifle_slots = rifle_slots;
		pause_menu.inventory = inventory;
		pause_menu.refresh_slots()
		pause_menu.refresh_inventory()
	current_weapon = preload("res://scenes/revolver.tscn").instantiate()
	add_child(current_weapon)
	if has_node("UI/HBoxContainer2/ProgressBar"):
		hp_bar = get_node("UI/HBoxContainer2/ProgressBar")

func _process(_delta):
	if current_weapon:
		orbit_weapon()

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	input_vector *= delta
	if input_vector.x > 0:
		animated_sprite_2d.flip_h = false
	elif input_vector.x < 0:
		animated_sprite_2d.flip_h = true
	if input_vector.x == 0 and input_vector.y == 0:
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("move")
	velocity = input_vector * SPEED
	move_and_slide()

func orbit_weapon():
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	current_weapon.position = dir * orbit_radius
	current_weapon.rotation = dir.angle()
	if mouse_pos.x < global_position.x:
		current_weapon.scale.y = -1
	else:
		current_weapon.scale.y = 1

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	var dist = global_position.distance_to(mouse_pos)-15
	if event.is_action_pressed("ui_accept") and current_weapon and dist >= orbit_radius:
		current_weapon.shoot()


func _on_interact_area_area_entered(area: Area2D) -> void:
	if area.name == "EnemyAttackArea":
		hp -= 10
		hp_bar.value = hp
		start_countdown(area)

func start_countdown(area: Area2D) -> void:
	await get_tree().create_timer(1.0).timeout
	if area in get_node("InteractArea").get_overlapping_areas():
		hp -= 10
		hp_bar.value = hp
		start_countdown(area)
