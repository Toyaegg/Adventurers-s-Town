extends BTAction

@export var building_position_var : StringName = &"building_position"
@export var building_var : StringName = &"building"

func _tick(tick ) -> Status:
	var building : Building = blackboard.get_var(building_var)
	if building == null:
		return FAILURE
	else:
		var building_position : float = building.door.global_position.x
		blackboard.set_var(building_position_var, building_position)
		return SUCCESS
