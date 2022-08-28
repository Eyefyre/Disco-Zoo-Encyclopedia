extends Node

var animal_data = null
var habitat_data = null

func _ready():
	var file = File.new()
	file.open("res://assets/data/animal_data.json", File.READ)
	var data = file.get_as_text()
	var d = JSON.parse(data).result
	animal_data = d
	file = File.new()
	file.open("res://assets/data/habitat_data.json", File.READ)
	data = file.get_as_text()
	d = JSON.parse(data).result
	habitat_data = d
