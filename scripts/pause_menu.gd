extends Control



func _on_resume() -> void:
	get_tree().paused = false
	visible = false


func _on_button_pressed() -> void:
	_on_resume()
