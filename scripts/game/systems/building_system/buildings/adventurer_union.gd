class_name AdventurerUnion
extends Building

func _ready() -> void:
	focused = ValueWithSignal.new()
	focused.value_changed.connect(update_focused)

	set_ready()

	#var adv = Adventurer.new()
	#adv.display_name = "ddadwaw"
	#visitors.enter(adv)
#
	#print(adv.display_name)
	#print(adv)

func update_focused(v : bool) -> void:
	print("update_focused " + str(v))
	EventBus.push_event(GameEvents.UI_VISIBLE_BUILDING_INFO, [self, v])

#func show_info(config : BuildingConfig) -> void:
#	pass
#region
#endregion
