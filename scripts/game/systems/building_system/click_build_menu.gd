extends Control

var pointer_entered : bool = false
var p : Node2D

func _ready() -> void:
	p = get_parent() as Node2D

func on_pointer_enter() -> void:
	print("on_pointer_enter")
	pointer_entered = true

func on_pointer_exit() -> void:
	print("on_pointer_exit")
	pointer_entered = false

func on_pointer_press() -> void:
	print("on_pointer_press  [%s] " % str(p.id))

func on_pointer_release() -> void:
	print("on_pointer_release  [%s] " % str(p.id))
	#EventBus.push_event(GameEvents.GAME_HANDLE_SELECT_BUILDING_SLOT, p.id)
	EventBus.push_event(GameEvents.GAME_HANDLE_CLICK_BUILD_MENU, [p.id, get_parent().global_position + Vector2(-500, -300)])

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and pointer_entered:
		on_pointer_press()
		get_viewport().set_input_as_handled()
	if event.is_action_released("click") and pointer_entered:
		on_pointer_release()
		get_viewport().set_input_as_handled()
