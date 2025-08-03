extends Area2D
class_name Bullet

var data: BulletData
var direction := Vector2.ZERO

func _ready() -> void:
	rotation = direction.angle()

func _process(delta: float) -> void:
	position += direction.normalized() * data.speed * delta

func on_hit_enemy(enemy) -> void:
	match data.type:
		data.BulletType.Normal:
			queue_free()
		data.BulletType.Explosive:
			set_process(false)
			#bullet_damage_shape.radius = 11
			await get_tree().create_timer(0.1).timeout
			queue_free()
		data.BulletType.Electro:
			enemy.stun(1)
			queue_free()
