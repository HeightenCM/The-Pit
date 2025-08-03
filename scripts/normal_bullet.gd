extends Area2D

var SPEED := 500
var direction := Vector2.ZERO
@export var damage:int = 10
@export var type:String = "normal_bullet"
var bullet_damage_shape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_damage_shape = get_node("BulletDamageArea/CollisionShape2D").shape


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction.normalized() * SPEED * delta
		rotation = direction.angle()

func set_type(new_type: String):
	type = new_type
	if type == "normal_bullet":
		damage = 10
	elif type == "explosive_round":
		damage = 25
	elif type == "stun_bullet":
		damage = 15

func on_hit_enemy(enemy) -> void:
	if type == "normal_bullet":
		queue_free()
	elif type == "explosive_round":
		set_process(false)
		bullet_damage_shape.radius = 11
		await get_tree().create_timer(0.1).timeout
		queue_free()
	elif type == "stun_bullet":
		damage = 15
	
