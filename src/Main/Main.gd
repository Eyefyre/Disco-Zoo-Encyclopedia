extends Control


var grid_scene = preload("res://src/PatternDisplay/Grid.tscn")

# Connects Signals to Animal and Habitat buttons
func _ready():
	for child in $HBoxContainer/HabitatSelector/HabitatSelectorGrid.get_children():
		child.connect("HabitatSelected",self,"habitat_selected")
	for child in $HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children():
		child.connect("AnimalSelected",self,"animal_selected")


# Called when habitat is selected
# Sets the opacity of all Habitats except one selected to 0.5
# Sets opacity of Animal Selector to 1 and enables all buttons
func habitat_selected(habitat):
	$HBoxContainer/AnimalSelector.modulate = Color(1,1,1,1)
	$HBoxContainer/PatternDisplay.modulate = Color(1,1,1,0)
	for child in $HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children():
		child.modulate = Color(1,1,1,0.5)
	for child in $HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children():
		child.get_node("TextureButton").disabled = false
	for child in $HBoxContainer/HabitatSelector/HabitatSelectorGrid.get_children():
		if child.habitat != habitat:
			child.modulate = Color(1,1,1,0.5)
		else:
			child.modulate = Color(1,1,1,1)
	update_animal_selector(habitat)


# Sets the opacity of all Animals except one selected to 0.5
# Disables the current chosen animal button so it can't be picked again pointlessly and enables all other animal buttons
# Generates the grid for the chosen animal
func animal_selected(animal_id):
	$HBoxContainer/PatternDisplay.modulate = Color(1,1,1,1)
	for child in $HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children():
		if child.animal_id != animal_id:
			child.modulate = Color(1,1,1,0.5)
			child.get_node("TextureButton").disabled = false
		else:
			child.modulate = Color(1,1,1,1)
			child.get_node("TextureButton").disabled = true
	generate_grid(animal_id)
	

# Generates the pattern grid based on the given animal_id
# Firstly emptys GridContainer in Grid, then updates the Animal name above grid
# Gets the animal dimensions based on the pattern
# Uses nested loops to loop through and add either empty tile or Animal tile depending on if the pattern exists in that coordinate
# Background textures are random 
func generate_grid(animal_id):
	var hab = Utilities.get_habitat_from_animal(animal_id)
	for x in $HBoxContainer/PatternDisplay/VBoxContainer/Grid/GridContainer.get_children():
		x.queue_free()
	$HBoxContainer/PatternDisplay/VBoxContainer/Label.text = GlobalVariables.animal_data[animal_id]["name"]
	var animal_dimensions = Utilities.get_animal_dimensions(GlobalVariables.animal_data[animal_id]["pattern"])
	$HBoxContainer/PatternDisplay/VBoxContainer/Grid.set_columns(animal_dimensions[0])
	for height in range(animal_dimensions[1]):
		for width in range(animal_dimensions[0]):
			if Utilities.check_if_array_in_array(GlobalVariables.animal_data[animal_id]["pattern"],[width,height]):
				$HBoxContainer/PatternDisplay/VBoxContainer/Grid.add_grid_square(GlobalVariables.animal_data[animal_id]["tile_image_path"],GlobalVariables.habitat_data[hab]["backgrounds"][0])
			else:
				$HBoxContainer/PatternDisplay/VBoxContainer/Grid.add_grid_square("res://assets/images/TransparentTile.png",Utilities.get_random_background_texture(hab))


# Updates the texture for each animal button to match the animals in the given habitat
# Updates the animal_id for the animal button as well

func update_animal_selector(habitat):
	for animal_id in range(len(GlobalVariables.habitat_data[habitat]["animals"])):
		var animalId = GlobalVariables.habitat_data[habitat]["animals"][animal_id]
		$HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children()[animal_id].get_node("TextureButton").texture_normal = load(GlobalVariables.animal_data[animalId]["tile_image_path"])
		$HBoxContainer/AnimalSelector/AnimalSelectorGrid.get_children()[animal_id].animal_id = animalId
