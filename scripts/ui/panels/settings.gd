extends Control

@onready var game: ScrollContainer = %Game
@onready var video: ScrollContainer = %Video
@onready var sound: ScrollContainer = %Sound
@onready var game_input: ScrollContainer = %GameInput
@onready var settings_tab: TabBar = %SettingsTab

func _ready() -> void:
	game.visible = true
	video.visible = false
	sound.visible = false
	game_input.visible = false
	settings_tab.tab_changed.connect(switch_content)

func switch_content(index : int) -> void:
	match index:
		0:
			game.visible = true
			video.visible = false
			sound.visible = false
			game_input.visible = false
		1:
			game.visible = false
			video.visible = true
			sound.visible = false
			game_input.visible = false
		2:
			game.visible = false
			video.visible = false
			sound.visible = true
			game_input.visible = false
		3:
			game.visible = false
			video.visible = false
			sound.visible = false
			game_input.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)
		EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.Settings)
		get_viewport().set_input_as_handled()
