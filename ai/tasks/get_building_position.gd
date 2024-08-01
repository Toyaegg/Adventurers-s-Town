extends BTAction

@export var position_var : StringName = &"position"
@export var building_var : StringName = &"building"

func _tick(tick : float) -> Status:
	var building : Building = blackboard.get_var(building_var)

	if not building.build_completed:
		return RUNNING
	elif building == null:
		return FAILURE
	else:
		var building_position : float = building.door.global_position.x
		blackboard.set_var(position_var, building_position)
		return SUCCESS
