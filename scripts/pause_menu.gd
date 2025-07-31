extends Control

func _on_resume() -> void:
	get_tree().paused = false
	visible = false
