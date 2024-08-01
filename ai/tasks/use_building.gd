extends BTAction

@export var building_var : StringName = &"building"
@export var feature : Building.Feature

func _tick(tick : float) -> Status:
	var building : Building = blackboard.get_var(building_var)
	if not building.build_completed:
		return RUNNING
	elif building.use(agent, feature):
		return SUCCESS
	else:
		return FAILURE
