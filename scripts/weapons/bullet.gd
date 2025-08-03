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
			$BulletDamageArea/CollisionShape2D.shape.radius = 11
			set_process(false)
			await get_tree().create_timer(1).timeout
			queue_free()
		data.BulletType.Electro:
			enemy.stun(1)
			queue_free()
