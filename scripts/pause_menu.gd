extends Control

@onready var ui = get_parent().get_parent().get_node("UI")
var revolver_slots := []
var shotgun_slots := []
var rifle_slots := []
@onready var ammo_hbox = $ScrollContainer/Ammo_HBox
@onready var inventory_container = $Inventory_GridContainer
@export var slot_scene: PackedScene

func _on_resume() -> void:
	ui.visible = true
	get_tree().paused = false
	visible = false

func show_pause_menu() -> void:
	visible = true
	get_tree().paused = true


func _on_button_pressed() -> void:
	_on_resume()


func _on_ready() -> void:
	slot_scene = load("res://scenes/slot_scene.tscn")
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	revolver_slots.resize(6)
	revolver_slots.fill(null)
	shotgun_slots.resize(6)
	shotgun_slots.fill(null)
	rifle_slots.resize(6)
	rifle_slots.fill(null)
	refresh_slots()
	populate_inventory()
	
func refresh_slots() -> void:
	for child in ammo_hbox.get_children():
		child.queue_free()
	for i in range(revolver_slots.size()):
		var slot = slot_scene.instantiate()
		ammo_hbox.add_child(slot)
		print("Adding slot", i)

func populate_inventory() -> void:
	for i in range(40):
		var slot = slot_scene.instantiate()
		inventory_container.add_child(slot)
		print("added inventory slot", i)
