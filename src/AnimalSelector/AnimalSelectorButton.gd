extends Control

var is_selected = false
var animal_id = "0"
signal AnimalSelected(animal_id)


func _on_TextureButton_pressed():
	emit_signal("AnimalSelected",animal_id)

