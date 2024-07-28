class_name TownModel
extends Node

var adventurer_union : AdventurerUnion
var inns : Array[Inn]

func _ready() -> void:
	print("TownModel ready")
	EventBus.subscribe(GameEvents.GAME_HANDLE_BUILDING_COMPLETE, build_complete)

func build_complete(b : Building) -> void:
	if b.id == &"au":
		print("建筑物[%s]加入town_model" % b.display_name)
		adventurer_union = b

