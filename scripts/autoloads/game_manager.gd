extends Node

enum {
	NewGame,
	LoadGame
}

enum GameState{
	Start,
	Playing,
	Pause,
}

var ui_manager : UIManager
var audio_manager : AudioManager
var timer : Timer

func initialize() -> void:
	create_ui_manager()
	create_audio_manager()

	EventBus.subscribe(GameEvents.GAME_START, start_game)
	EventBus.subscribe(GameEvents.GAME_LOAD, load_save_files)
	EventBus.subscribe(GameEvents.GAME_EXIT, exit_game)

	print("game initialized")

func create_ui_manager() -> void:
	ui_manager = UIManager.new()
	ui_manager.name = "UIManager"
	add_child(ui_manager)
	ui_manager.initialize()

func create_audio_manager() -> void:
	audio_manager = AudioManager.new()
	audio_manager.name = "AudioManager"
	add_child(audio_manager)
	audio_manager.initialize()

func start_game(method : int) -> void:
	match method:
		0:
			start_new_game()
		1:
			start_loaded_game()

func start_new_game() -> void:
	print("start_new_game")

func start_loaded_game() -> void:
	print("start_loaded_game")

func load_save_files() -> void:
	print("load_save_files")

func exit_game() -> void:
	EventBus.push_event(GameEvents.UI_TIPS_OPEN, [Tip.TipType.Select, "确定要退出游戏吗？",
		func():
			get_tree().quit(),
		func():
			EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.Tips)])
