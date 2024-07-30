class_name TownModel
extends Node

var buildings : Array[Building]

func _ready() -> void:
	print("TownModel ready")
	EventBus.subscribe(GameEvents.BUILD_BUILDING_COMPLETE, build_complete)

func build_complete(b : Building) -> void:
	#if b.id == &"au":
		#print("建筑物[%s]加入town_model" % b.display_name)
		#adventurer_union = b
	buildings.append(b)

func get_buildings() -> Array[Building]:
	return buildings
