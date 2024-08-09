class_name BuildingSystem
extends Node

func _ready() -> void:
	EventBus.subscribe(GameEvents.BUILDING_LEVEL_UP, check_level_up)

func build(slot : Node2D, building : Building) -> void:
	slot.build(building)
	GameManager.town_model.build_complete(building)
	if building.building_config.id == &"au":
		EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_LEVEL_UP, [0, 1, 0])

func check_level_up(need : Array[int], building : Building) -> void:
	if GameManager.town_model.can_level_up(need):
		EventBus.push_event(GameEvents.BUILDING_LEVEL_UP_FINISH, building)
