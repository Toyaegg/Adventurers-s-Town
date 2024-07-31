extends BTAction

@export var building_var : StringName = &"building"

func _tick(tick ) -> Status:
	var building : Building = blackboard.get_var(building_var)
	building.enter(agent)
	return SUCCESS
