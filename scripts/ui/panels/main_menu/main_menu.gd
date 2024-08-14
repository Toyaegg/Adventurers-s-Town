extends Control

@onready var start_game: Button = %StartGame
@onready var continue_game: Button = %ContinueGame
@onready var load_game: Button = %LoadGame
@onready var settings: Button = %Settings
@onready var credits: Button = %Credits
@onready var exit_game: Button = %ExitGame
@onready var version: Label = %Version
@onready var text_title: Label = %TextTitle

func _ready() -> void:
	start_game.pressed.connect(on_click_start_game)
	continue_game.pressed.connect(on_click_continue_game)
	load_game.pressed.connect(on_click_load_game)
	settings.pressed.connect(on_click_settings)
	credits.pressed.connect(on_click_credits)
	exit_game.pressed.connect(on_click_exit_game)

	version.text = ProjectSettings.get_setting("application/config/version")
	text_title.text = ProjectSettings.get_setting("application/config/name")
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["bgm", "bgm"])

func on_click_start_game() -> void:
	print("on_click_start_game")
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.HUD)
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.GAME_START, GameManager.NewGame)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func on_click_continue_game() -> void:
	print("on_click_continue_game")
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.HUD)
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.GAME_START, GameManager.LoadGame)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func on_click_load_game() -> void:
	print("on_click_load_game")
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.SaveFiles)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func on_click_settings() -> void:
	print("on_click_settings")
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.Settings)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func on_click_credits() -> void:
	print("on_click_credits")
	EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.MainMenu)
	EventBus.push_event(GameEvents.UI_OPEN, UIPanel.Credits)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func on_click_exit_game() -> void:
	print("on_click_exit_game")
	EventBus.push_event(GameEvents.GAME_EXIT)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		EventBus.push_event(GameEvents.GAME_EXIT)
