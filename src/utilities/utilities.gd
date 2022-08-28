extends Node

var rng = RandomNumberGenerator.new()

# Gets the Height and Width of an Animal pattern based on its coordinates
func get_animal_dimensions(pattern):
	var width = 0
	var height = 0
	for block in pattern:
		if (block[0] >= width):
			width = block[0] + 1
		if (block[1] >= height):
			height = block[1]+ 1
	return [width,height]
	
# Checks if two arrays are equal
func check_arrays_are_equal(arr,arr2):
	for x in range(max(len(arr),len(arr2))):
		if arr[x] != arr2[x]:
			return false
	return true
	
# Checks if a given array is present within another given array
func check_if_array_in_array(arr,arr2):
	for x in range(len(arr)):
		if check_arrays_are_equal(arr[x],arr2):
			return true
	return false
	
# Returns the habitat of an animal based on the given Animal ID
func get_habitat_from_animal(animal_id):
	for x in GlobalVariables.habitat_data:
		if animal_id in GlobalVariables.habitat_data[x]["animals"]:
			return x
			
# Returns a random texture from the list in habitat data for the given habitat
func get_random_background_texture(habitat):
	rng.randomize()
	var randNum = rng.randi_range(0,len(GlobalVariables.habitat_data[habitat]["backgrounds"])-1)
	return GlobalVariables.habitat_data[habitat]["backgrounds"][randNum]
		
