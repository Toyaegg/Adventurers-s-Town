class_name Church
extends Building


func _ready() -> void:
	focused = ValueWithSignal.new()
	focused.value_changed.connect(update_focused)
	set_ready()


func use(user : Adventurer, f : Feature) -> bool:
	var result : bool = false

	if visitors.has_user(user):
		match f:
			Feature.Treat:
				user.add_hp(100)
				result = true

	return result

func update_focused(v : bool) -> void:
	print("update_focused " + str(v))
	EventBus.push_event(GameEvents.UI_VISIBLE_BUILDING_INFO, [self, v])
