extends Control

@onready var save_game_: Button = %SaveGame
@onready var load_game: Button = %LoadGame
@onready var settings: Button = %Settings
@onready var exit_game: Button = %ExitGame

func _ready() -> void:
	save_game_.pressed.connect(_save_game)
	load_game.pressed.connect(_load_game)
	settings.pressed.connect(_setting)
	exit_game.pressed.connect(_exit_game)

func _save_game() ->void:
	EventBus.push_event(GameEvents.GAME_SAVE)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["sfx", "click"])

func _load_game() ->void:
	EventBus.push_event(GameEvents.GAME_LOAD)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["sfx", "click"])

func _setting() ->void:
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.Settings)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["sfx", "click"])

func _exit_game() ->void:
	_save_game()
	await SaveSystem.saved
	get_tree().unload_current_scene()
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.HUD)
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.HUDMenu)
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.GAME_RESET)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.HUDMenu)
		get_viewport().set_input_as_handled()
	
