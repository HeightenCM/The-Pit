extends Control

@export var data : BulletData



func updateInfoBulletData(bulletData : BulletData):
	if bulletData == null:
		return
	var title_enum_number = bulletData.type
	var text : String = bulletData.get_description()
	var titleLabel : Label = get_node("Panel/Label")
	var descriptionLabel : Label = get_node("Panel/Label2")
	titleLabel.text = BulletTypeDef.Type.keys()[title_enum_number]
	descriptionLabel.text = text
	
