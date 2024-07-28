extends Control

var selected_slot_id : int

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel") and GameManager.build_mode_progress.value and visible:
		visible = not visible
