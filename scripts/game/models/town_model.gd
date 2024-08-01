class_name TownModel
extends Node

var buildings : Array[Building]
var house_count : int = 0
var transport_position : float

func _ready() -> void:
	print("TownModel ready")
	EventBus.subscribe(GameEvents.BUILD_BUILDING_COMPLETE, build_complete)

func build_complete(b : Building) -> void:
	var key : String = b.id
	if not b.building_config.only_one:
		pass
	buildings.append(b)

func get_buildings() -> Array[Building]:
	return buildings

func find_building(id : String, feature : Building.Feature) -> Building:
	var building : Building
	for b in buildings:
		if b.has_feature(feature):
			building = b

	return building

func get_transport_position() -> float:
	return transport_position


