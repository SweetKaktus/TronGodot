extends Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Récupère la position du joueur dans l'autoload
	EVENTS.game_over.connect(over_the_game)
	EVENTS.run_game.connect(start_game)
	EVENTS.change_dir.connect(_add_point_on_change_dir)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if EVENTS.running:
		# Récupère la position du joueur dans l'autoload
		set_point_position(len(points) - 1, EVENTS.player_position)


func over_the_game():
	clear_points()

func start_game():
	add_point(EVENTS.initial_position)
	add_point(EVENTS.initial_position)
	add_segment_to_tab(points[-2], points[-1])
	print(EVENTS.segments_tab)

func _add_point_on_change_dir():
	add_point(EVENTS.player_position)
	add_segment_to_tab(points[-3], points[-2])
	print(EVENTS.segments_tab)

func add_segment_to_tab(A: Vector2, B: Vector2):
	var segment = [A, B]
	EVENTS.segments_tab.append(segment)
