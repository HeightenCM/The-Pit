extends Node2D

var isWave = false
var tutorial_complete = false
var start_wave_button

func _ready() -> void:
	var sheet = preload("res://assets/sprites/cursors_improved.png")
	var atlas = AtlasTexture.new()
	atlas.atlas = sheet
	atlas.region = Rect2(Vector2(0, 0), Vector2(32, 32))
	Input.set_custom_mouse_cursor(atlas, Input.CURSOR_ARROW, Vector2(32, 32))
	start_wave_button = get_node("Pete/UI/HBoxContainer3/StartWaveButton")
