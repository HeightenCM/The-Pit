extends Control

@onready var ui = get_parent().get_parent().get_node("UI")
var revolver_slots := []
var shotgun_slots := []
var rifle_slots := []
@onready var ammo_hbox = $ScrollContainer/Ammo_HBox
@onready var inventory_container = $Inventory_GridContainer
@export var slot_scene: PackedScene
@onready var resume_button = $VBoxContainer/Button
var index_selecting:int = -1

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
	disable_inventory()
	
func refresh_slots() -> void:
	for child in ammo_hbox.get_children():
		child.queue_free()
	for i in range(revolver_slots.size()):
		var slot = slot_scene.instantiate()
		slot.index = i
		slot.isEquippable = true
		slot.item = ""
		ammo_hbox.add_child(slot)
		print("Adding slot", i)

func populate_inventory() -> void:
	for i in range(40):
		var slot = slot_scene.instantiate()
		slot.index = i
		slot.isEquippable = false
		slot.item = ""
		inventory_container.add_child(slot)
		print("added inventory slot", i)

func disable_inventory() -> void:
	inventory_container.modulate.a = 0.5
	for child in inventory_container.get_children():
		child.get_child(0).disabled = true
		child.get_child(0).mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func enable_inventory() -> void:
	inventory_container.modulate.a = 1
	for child in inventory_container.get_children():
		child.get_child(0).disabled = false
		child.get_child(0).mouse_filter = Control.MOUSE_FILTER_STOP

func start_selection(index: int) -> void:
	index_selecting = index
	enable_inventory()
	resume_button.disabled = true
	
func select(index:int) -> void:
	resume_button.disabled = false
	var item_aux:String = ammo_hbox.get_child(index_selecting).item
	ammo_hbox.get_child(index_selecting).item = inventory_container.get_child(index).item
	inventory_container.get_child(index).item = item_aux
	disable_inventory()
