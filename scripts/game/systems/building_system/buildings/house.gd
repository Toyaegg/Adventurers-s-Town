class_name House
extends Building


func _ready() -> void:
	focused = ValueWithSignal.new()
	focused.value_changed.connect(update_focused)

func update_focused(v : bool) -> void:
	print("update_focused " + str(v))
	EventBus.push_event(GameEvents.UI_VISIBLE_BUILDING_INFO, [self, v])
