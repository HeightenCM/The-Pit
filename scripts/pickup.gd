extends Node2D

@export var item: BulletData
var player


func set_item(new_item: BulletData) -> void:
	item = new_item
	

func _on_ready() -> void:
	player = get_parent().get_node("Pete")
	var sprite = Sprite2D.new()
	sprite.texture = preload("res://icon.svg")
	sprite.scale = Vector2(0.2, 0.2)
	add_child(sprite)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "InteractArea":
		print("Player's pickup detector entered")
		player = area.get_parent()
		var i:int = 0
		while i < player.inventory.size() && player.inventory[i]!=null:
			i += 1
		if i < player.inventory.size():
			player.inventory[i] = item
		print("added to player inventory: ", player.inventory[i])
		queue_free()
