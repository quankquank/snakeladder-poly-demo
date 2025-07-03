extends Node2D

@export var player_sprite: Array[Texture]

var board = Node
var tile_index : int

func draw_pieces(player: int):
	$PieceSprite.texture = player_sprite[player]
	
func move_to_tile(target_tile: int):
	tile_index = target_tile # TODO: Temporary code, animation later
	position = board.tile_to_position(tile_index)
