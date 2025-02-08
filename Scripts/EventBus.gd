extends Node

signal game_over
signal run_game
signal change_dir

# Récupère la position du joueur pour que le Line2D player y accède
var player_position := Vector2.ZERO

var last_player_position := Vector2.ZERO

var previous_last_player_position := Vector2.ZERO

var initial_position := Vector2(745, 400)

var running : bool = false

var segments_tab = []

func _ready() -> void:
	segments_tab = []
	run_game.connect(start_game)
	game_over.connect(over_the_game)
	
func start_game():
	running = true
func over_the_game():
	running = false
