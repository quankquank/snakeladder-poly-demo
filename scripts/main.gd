extends Node2D

@onready var side_menu := $MainScreen/SideMenu

# Board variables
var board_size = 1000
var cell_size = 100
var grid_data: Array
var snakes = {
	16: 7,
	59: 17,
	63: 19,
	67: 30,
	87: 24,
	93: 69,
	95: 75,
	99: 77
}
var ladders = {
	9: 27,
	18: 37,
	25: 54,
	28: 51,
	56: 64,
	68: 88,
	76: 97,
	79: 100
}

# Player variables
const PLAYER_COUNT := 2 # TODO: More players, from 2 to 4
var player_positions : Array
var current_player : int

func _ready() -> void:
	new_game()
	
func new_game():
	player_positions = [1, 1]
	current_player = 0
	
func roll_dice():
	pass
	
func move_player(steps:):
	pass
	
func draw_pieces():
	pass
	
func check_win() -> bool:
	return player_positions[current_player] == 100
	
