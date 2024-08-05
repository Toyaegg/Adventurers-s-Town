class_name TownModel
extends Node

var buildings : Array[Building]
var house_count : int = 0
var transport_position : float
var resource_1 : int
var resource_2 : int
var resource_3 : int
var gold : int
var reputation : int

func _ready() -> void:
	print("TownModel ready")

func build_complete(b : Building) -> void:
	var key : String = b.id
	buildings.append(b)
	EventBus.push_event(GameEvents.BUILD_BUILDING_COMPLETE, b)

func get_buildings() -> Array[Building]:
	return buildings

func find_buildings(id : String) -> Array[Building]:
	var fbuildings : Array[Building]
	for b in buildings:
		if b.building_config.id == id:
			fbuildings.append(b)

	return fbuildings

func get_transport_position() -> float:
	return transport_position

func has_building_only_one(id : StringName) -> bool:
	var result : bool = false

	for building in buildings:
		print("%s %s %s" % [building.building_config.id, id, str(building.id == id)])
		if building.building_config.id == id:
			print(building.display_name)
			result = building.building_config.only_one

	return result

func can_level_up(need : Array[int]) -> bool:
	var result := true
	if need[0] > resource_1:
		result = false
	if need[1] > resource_2:
		result = false
	if need[2] > resource_3:
		result = false
	return result
