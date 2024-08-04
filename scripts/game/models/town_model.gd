class_name TownModel
extends Node

var buildings : Array[Building]
var house_count : int = 0
var transport_position : float

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
