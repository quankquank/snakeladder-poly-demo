extends TextureRect

var board_size = 1000
var cell_size = 100
var jumps = {
	9: 27,
	16: 7,
	18: 37,
	25: 54,
	28: 51,
	56: 64,
	59: 17,
	63: 19,
	68: 88,
	67: 30,
	76: 97,
	79: 100,
	87: 24,
	93: 69,
	95: 75,
	99: 77
}

func _ready() -> void:
	pass
	
func tile_to_position(index: int) -> Vector2:
	var row := (index - 1) / 10
	var col := (index - 1) % 10
	if row % 2 == 0:
		col = 9 - col
	var x = (9 - col) * cell_size + cell_size / 2
	var y = (9 - row) * cell_size + cell_size / 2
	return Vector2(x, y)
	
func position_to_tile(pos: Vector2) -> int:
	if pos.x < 0 || pos.x > 1000 || pos.y < 0 || pos.y > 1000:
		return -1
	var col = int(pos.x / cell_size)
	var row = int(pos.y / cell_size)
	if row % 2 == 0:
		col = 9 - col
	return (9 - row) * 10 + col + 1
