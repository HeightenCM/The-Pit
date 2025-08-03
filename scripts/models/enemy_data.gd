class_name EnemyData

extends RefCounted
class Enemy:
	@export var hp: int
	@export var damage: int
	@export var speed: float
	
	func _init(_hp: int = 20, _damage: int = 10, _speed: float = 50.0):
		hp = _hp
		damage = _damage
		speed = _speed
