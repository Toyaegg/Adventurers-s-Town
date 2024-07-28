extends Control

@export var building_id : StringName
@export var menu : Control

func click_to_build(event : InputEvent) -> void:
	if event.is_action_released("click"):
		print("building item click_to_build")
		EventBus.push_event(GameEvents.GAME_HANDLE_BUILDING, [menu.selected_slot_id, building_id])
