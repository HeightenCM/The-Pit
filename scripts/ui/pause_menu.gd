extends Control

@onready var ui = get_parent().get_parent().get_node("UI")
var revolver_slots : Array[BulletData]
var shotgun_slots : Array[BulletData]
var rifle_slots : Array[BulletData]
var current_array: Array[BulletData]
var inventory : Array[BulletData]
@onready var ammo_hbox = $ScrollContainer/MarginContainer/Ammo_HBox
@onready var inventory_container = $Inventory_GridContainer
@export var slot_scene: PackedScene
@onready var resume_button = $VBoxContainer/Button
var index_selecting:int = -1
var weapon_used:String = "revolver"
var game

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
	game = get_tree().get_current_scene()
	slot_scene = load("res://scenes/ui/slot_scene.tscn")
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func refresh_slots() -> void:
	for child in ammo_hbox.get_children():
		child.queue_free()
	if weapon_used == "revolver":
		current_array = revolver_slots
	elif weapon_used == "shotgun":
		current_array = shotgun_slots
	elif weapon_used == "rifle":
		current_array = rifle_slots
	for i in range(current_array.size()):
		var slot = slot_scene.instantiate()
		slot.index = i
		slot.isEquippable = true
		slot.set_item(current_array[i])
		ammo_hbox.add_child(slot)
		print("Adding slot", i)
		
func refresh_inventory() -> void:
	for child in inventory_container.get_children():
		child.queue_free()
	for i in range(inventory.size()):
		var slot = slot_scene.instantiate()
		slot.index = i
		slot.isEquippable = false
		slot.set_item(inventory[i])
		inventory_container.add_child(slot)
		print("added inventory slot", i, " ", slot.item)
	disable_inventory()

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
	if !game.isWave:
		index_selecting = index
		enable_inventory()
		resume_button.disabled = true
	else:
		game.get_node("Announcement").set_text("You can't switch ammo while fighting a wave")
	
func select(index:int) -> void:
	resume_button.disabled = false
	var item_aux:BulletData = current_array[index_selecting]
	current_array[index_selecting] = inventory[index]
	inventory[index] = item_aux
	#var item_aux:String = ammo_hbox.get_child(index_selecting).item
	#ammo_hbox.get_child(index_selecting).set_item(inventory_container.get_child(index).item)
	#inventory_container.get_child(index).set_item(item_aux)
	refresh_slots()
	refresh_inventory()


func _on_visibility_changed() -> void:
	if visible:
		get_node("CanvasLayer").visible = true
	else:
		get_node("CanvasLayer").visible = false
