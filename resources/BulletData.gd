extends Resource
class_name BulletData

enum BulletType {Normal, Ice, Fire, Electro, Explosive}

@export var type: BulletType
@export var sprite: Texture2D
@export var muzzle_flash: Texture2D
@export var inventory_icon: Texture2D
@export var hit_effect: Texture2D
@export var speed: float = 300
@export var damage: float = 10
@export var status_effect: String = ""

func get_description() -> String:
	match type:
		BulletType.Normal:
			return "This is a normal bullet. Causes direct damage to enemies."
		BulletType.Ice:
			return "This bullet slows enemies for 3 seconds."
		BulletType.Fire:
			return "This bullet burns ene,ies dealing damage over time."
		BulletType.Electro:
			return "This bullet can stun enemies, keeping them immobilized for 1 second."
		BulletType.Explosive:
			return "This bullet explodes, dealing heavy damage over a wide area."
		_:
			return "This is a bullet"
