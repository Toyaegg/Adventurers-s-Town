extends BTAction

@export var building_var : StringName = &"building"

func _tick(tick : float) -> Status:
	var building : Building = blackboard.get_var(building_var)
	building.enter(agent)
	agent.hide()
	return SUCCESS
