extends CanvasLayer

var label

func set_text(text) -> void:
	label.text = text
	label.visible = true
	await get_tree().create_timer(3.5).timeout
	label.visible = false
	

func _on_ready() -> void:
	label = get_node("Label")
	label.visible = false
