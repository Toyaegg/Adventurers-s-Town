extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)
		EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.SaveFiles)
		get_viewport().set_input_as_handled()
