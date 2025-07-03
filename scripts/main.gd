extends Node2D

@onready var board := $MainScreen/AspectMenu/Board
@onready var side_menu := $MainScreen/SideMenu
@onready var dice := $MainScreen/SideMenu/Dice
@onready var pieces_container := $PiecesContainer	# Piece container is specifically for the visible pieces

@export var current_turn_icon : Array[Texture]

# Player variables
var piece_scene = preload("res://scenes/pieces.tscn")
var player_count := 2 # TODO: More players, from 2 to 4
var player_nodes : Array = [] # This array is to store data of all players
var current_player : int
var won : int = -1

func _ready() -> void:
	new_game()

func setup_player(count):
	player_nodes.clear()
	for child in pieces_container.get_children():
		child.queue_free()
	for i in range(count):
		var p = piece_scene.instantiate()
		p.board = $MainScreen/AspectMenu/Board
		p.position = board.tile_to_position(1)
		p.tile_index = 1
		p.draw_pieces(i)
		pieces_container.add_child(p)
		player_nodes.append(p)

func new_game():
	setup_player(player_count)
	current_player = 0
	won = -1
	$MainScreen/SideMenu/MoveLog.clear()
	update_menu_elements()
	
# Mostly for debug really. Actual logic goes to _on_dice_pressed() below.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and won == -1:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var tile_pressed = board.position_to_tile(event.position)
			pass
	
func move_player(steps: int):
	var start = player_nodes[current_player].tile_index
	var end = player_nodes[current_player].tile_index + steps
	log_move(current_player, start, end, steps, "move")
	player_nodes[current_player].move_to_tile(end)
	if board.jumps.has(end):
		start = end
		end = board.jumps[end]
		if start < end:
			log_move(current_player, start, end, steps, "ladder")
		else:
			log_move(current_player, start, end, steps, "snake")
	
func check_win():
	if player_nodes[current_player].tile_index == 100:
		won = current_player
	
func update_menu_elements():
	if won != -1:
		$MainScreen/SideMenu/PlayerText.text = "Player %s won!" % current_player
	else:
		$MainScreen/SideMenu/PlayerText.text = "Current turn:"
		$MainScreen/SideMenu/CurrentTurnIcon.texture = current_turn_icon[current_player]
	
func _on_dice_pressed() -> void:
	var value = dice.roll()
	if player_nodes[current_player].tile_index + value <= 100 and won == -1:
		move_player(value)
		
		check_win()
		current_player = (current_player + 1) % player_count
		update_menu_elements()
	
func log_move(player_no: int, from_tile: int, to_tile: int, roll: int, move_type: String):
	var log := $"MainScreen/SideMenu/MoveLog"
	var msg : String
	if move_type == "move":
		msg = "Player %d rolled %d: %d → %d\n" % [player_no, roll, from_tile, to_tile]
	if move_type == "ladder":
		msg = "Player %d climbed from %d → %d\n" % [player_no, from_tile, to_tile]
	if move_type == "snake":
		msg = "Player %d slipped from %d → %d\n" % [player_no, from_tile, to_tile]
	log.append_text(msg)
	if to_tile == 100:
		msg = "Player %d reached 100 and won!" % player_no
		log.append_text(msg)

func _on_restart_button_pressed() -> void:
	new_game()
