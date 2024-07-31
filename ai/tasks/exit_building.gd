extends BTAction

@export var building_var : StringName = &"building"

func _tick(tick ) -> Status:
	var building : Building = blackboard.get_var(building_var)
	building.exit(agent)
	return SUCCESS
