extends CharacterBody2D

const SPEED = 300.0

@export var orbit_radius: float = 30.0  # Distance from parent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun_pivot: Node2D = $GunPivot


func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	gun_pivot.position = dir * orbit_radius
	gun_pivot.rotation = dir.angle()
	if mouse_pos.x < global_position.x:
		gun_pivot.get_node("Sprite2D").flip_v = true
	else:
		gun_pivot.get_node("Sprite2D").flip_v = false

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()*delta
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
