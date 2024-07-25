extends Node

@export var init_time := 2

func _ready() -> void:
	get_tree().create_timer(init_time).timeout.connect(enter_game)
	initialize_game_data()
	initialize_game()

func enter_game() -> void:
	var main = load("res://scenes/game/main.tscn")
	get_tree().change_scene_to_packed(main)
	#GameManager.open_ui(UIPanel.MainMenu)
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)

func initialize_game_data() -> void:
	print("initialize_game_data")

func initialize_game() -> void:
	GameManager.initialize()
