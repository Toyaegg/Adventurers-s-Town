class_name BuildingSystem
extends Node

func _ready() -> void:
	EventBus.subscribe(GameEvents.BUILDING_LEVEL_UP, check_level_up)

func build(slot : Node2D, building : Building) -> void:
	slot.build(building)
	GameManager.town_model.build_complete(building)
	if building.building_config.id == &"au":
		EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_LEVEL_UP, [0, 1, 0])

func check_level_up(building : Building) -> void:
	var need : Array[int]
	need.append_array(building.building_config.resource_need[building.level])

	if GameManager.town_model.can_level_up(need):
		EventBus.push_event(GameEvents.AUDIO_PLAY, ["building_levelup", "sfx"])
		GameManager.town_model.use_resource(need[0], need[1], need[2])
		building.level += 1
		EventBus.push_event(GameEvents.BUILDING_LEVEL_UP_FINISH, building)
