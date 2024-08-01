extends BTAction

@export var position_var : StringName = &"position"

func _tick(tick : float) -> Status:
	var transport : float = GameManager.town_model.get_transport_position()
	blackboard.set_var(position_var, transport)
	return SUCCESS
