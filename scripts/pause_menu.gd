extends Control



func _on_resume() -> void:
	get_tree().paused = false
	visible = false

func show_pause_menu() -> void:
	visible = true
	get_tree().paused = true


func _on_button_pressed() -> void:
	_on_resume()


func _on_ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
