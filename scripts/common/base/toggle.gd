class_name ToggleButton
extends Button

@export var is_on : bool = false
@export var select_color : Color
var normal_color : Color

@export var bind_data : int

signal selected(bind_data : int)
signal unselected(bind_data : int)

func _init() -> void:
	toggle_mode = true
	button_group.pressed.connect(button_clicked)
	normal_color = self_modulate

func button_clicked(button : BaseButton) -> void:
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])
	is_on = button == self
	if is_on:
		self_modulate = select_color
		selected.emit(bind_data)
	else:
		self_modulate = normal_color
		unselected.emit(bind_data)
