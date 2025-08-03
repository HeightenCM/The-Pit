extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
var player
@export var speed: float = 50.0


func _on_ready() -> void:
	player = get_parent().get_node("Pete")
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 8.0

func _physics_process(_delta):
	if player:
		agent.set_target_position(player.global_position)

		if agent.is_navigation_finished():
			return

		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
