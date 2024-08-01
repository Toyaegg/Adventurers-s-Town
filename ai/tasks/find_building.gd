extends BTAction

@export var building_id : StringName
@export var building_var : StringName = &"building"
@export var feature : Building.Feature

func _tick(tick : float) -> Status:
	var building : Building= GameManager.town_model.find_building(String(building_id), feature)

	if building == null:
		return FAILURE
	else:
		blackboard.set_var(building_var, building)
		if building.visitors.users.size() != 0:
			print(building.visitors.users[0].display_name)
		return SUCCESS
