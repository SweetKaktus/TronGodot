extends CharacterBody2D

var dir = Vector2.ZERO
var speed = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = Vector2.ZERO
	position = EVENTS.initial_position
	EVENTS.game_over.connect(over_the_game)
	EVENTS.run_game.connect(start_game)


func _process(delta: float) -> void:
	handle_rotation()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if EVENTS.running:
		velocity = speed * dir * delta * 100
		move_and_slide()
		# Envoi la position du joueur dans l'autoload pour que le Line2D du joueur y accède
		EVENTS.player_position = position
		if is_on_wall():
			EVENTS.game_over.emit()
		
func _input(event: InputEvent) -> void:
	if EVENTS.running:
		if Input.is_action_just_pressed("up") and dir != Vector2.DOWN:
			dir = Vector2.UP
			EVENTS.change_dir.emit()
		elif Input.is_action_just_pressed("down") and dir != Vector2.UP:
			dir = Vector2.DOWN
			EVENTS.change_dir.emit()
		elif Input.is_action_just_pressed("left") and dir != Vector2.RIGHT:
			dir = Vector2.LEFT
			EVENTS.change_dir.emit()
		elif Input.is_action_just_pressed("right") and dir != Vector2.LEFT:
			dir = Vector2.RIGHT
			EVENTS.change_dir.emit()
	if Input.is_action_just_pressed("start"):
		if not EVENTS.running:
			EVENTS.run_game.emit()

func over_the_game():
	position = EVENTS.initial_position
	rotation_degrees = 0
	dir = Vector2.ZERO

func start_game():
	EVENTS.last_player_position = position
	EVENTS.previous_last_player_position = position
	dir = Vector2.UP

func handle_rotation():
	if dir == Vector2.UP:
		rotation_degrees = 0
	if dir == Vector2.DOWN:
		rotation_degrees = 180
	if dir == Vector2.RIGHT:
		rotation_degrees = 90
	if dir == Vector2.LEFT:
		rotation_degrees = 270
		
# Si dir.x = 0 et dir.y != 0 alors pour elemnt dans EVENTS.segment_tab,
# si player.x est entre les 2 elemnts et que player.y passe par 
# un [element.b.y, element.a.y] alors BOOM
# vice-versa pour dir.x et dir.y
