extends BTAction

@export var building_position_var : StringName = &"building_position"
@export var tolerance : float = 10

func _tick(tick : float) -> Status:
	var target_position : float = blackboard.get_var(building_position_var)
	var distance : float = target_position - agent.global_position.x

	var dir : int

	if distance > 0:
		dir = 1
	elif distance < 0:
		dir = -1
	else:
		dir = 0

	if abs(distance) >= tolerance:
		agent.move_dir(dir, tick)
		return RUNNING
	else:
		return SUCCESS


