extends Weapon
class_name Revolver

@export var bullet_scene: PackedScene
@export var smoke_texture: Texture2D 
@export var effect_offset: Vector2 = Vector2(8, 0) 

func shoot(bullet_data: BulletData):
	var muzzle_flash_sprite := $BulletSpawn/MuzzleFlash

	if bullet_data:
		var mouse_pos = get_global_mouse_position()
		var bullet_instance = bullet_scene.instantiate() as Bullet
		bullet_instance.data = bullet_data
		bullet_instance.direction = (mouse_pos - global_position).normalized()
		bullet_instance.global_position = global_position
		get_tree().current_scene.add_child(bullet_instance)
		muzzle_flash_sprite.position = effect_offset
		show_muzzle_flash(bullet_data.muzzle_flash)
		
	else:
		muzzle_flash_sprite.position = effect_offset
		muzzle_flash_sprite.texture = smoke_texture
		muzzle_flash_sprite.visible = true
		await get_tree().create_timer(0.15).timeout
		muzzle_flash_sprite.visible = false
func show_muzzle_flash(texture: Texture2D) -> void:
	var muzzle_flash_sprite := $BulletSpawn/MuzzleFlash
	muzzle_flash_sprite.texture = texture
	muzzle_flash_sprite.visible = true
	await get_tree().create_timer(0.1).timeout
	muzzle_flash_sprite.visible = false
