extends Control


export var habitat = "Farm"
export var background_texture = "res://assets/images/farm/FarmBackground.png"
signal HabitatSelected(habitat)


func _ready():
	$TextureButton/Label.text = habitat
	$TextureButton.texture_normal = load(background_texture)

func _on_TextureButton_pressed():
	emit_signal("HabitatSelected",habitat)
