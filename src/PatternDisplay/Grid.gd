extends Control


var square_scene = preload("res://src/PatternDisplay/GridSquare.tscn")

# Updates the number of columns for the Gridcontainer based on the width of the Animal Pattern
func set_columns(width):
	$GridContainer.columns = width
	
	
# Adds a new square to the GridContainer and loads the appropriate textures, then centers the gridcontainer
func add_grid_square(texture,habitat):
	var new_square = square_scene.instance()
	new_square.get_node("TextureRect").texture = load(texture)
	new_square.get_node("TextureRect2").texture = load(habitat)
	$GridContainer.add_child(new_square)
	$GridContainer.anchor_left = 0.5
	$GridContainer.anchor_right = 0.5
	$GridContainer.anchor_top = 0.5
	$GridContainer.anchor_bottom = 0.5

