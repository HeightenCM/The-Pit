extends CharacterBody2D

const SPEED = 5000.0

@export var orbit_radius: float = 25.0  # Distance from parent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var current_weapon: Node2D = null

func _ready() -> void:
	current_weapon = preload("res://scenes/revolver.tscn").instantiate()
	add_child(current_weapon)

func _process(delta):
	if current_weapon:
		print("ready")
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
	print(position)
	move_and_slide()

func orbit_weapon():
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	current_weapon.position = dir * orbit_radius
	current_weapon.rotation = dir.angle()
	if mouse_pos.x < global_position.x:
		current_weapon.get_node("Sprite2D").flip_v = true
	else:
		current_weapon.get_node("Sprite2D").flip_v = false
