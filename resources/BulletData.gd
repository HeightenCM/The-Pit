extends Resource
class_name BulletData

enum BulletType {Normal, Ice, Fire, Electro, Explosive}

@export var type: BulletType
@export var sprite: Texture2D
@export var muzzle_flash: Texture2D
@export var inventory_icon: Texture2D
@export var speed: float = 300
@export var damage: float = 10
@export var status_effect: String = ""
