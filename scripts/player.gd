extends CharacterBody2D

const SPEED = 300.0

@export var orbit_radius: float = 150.0  # Distance from parent

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	$GunPivot.position = dir * orbit_radius

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()*delta
	velocity = input_vector * SPEED
	print(position)
	move_and_slide()
