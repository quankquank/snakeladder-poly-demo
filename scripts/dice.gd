extends Button

@export var dice_faces: Array[Texture]

var current_value:= 0

func roll() -> int:
	current_value = randi_range(1, 6)
	$Faces.texture = dice_faces[current_value - 1]
	return current_value
	
