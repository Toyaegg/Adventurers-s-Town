class_name AdventurerModel
extends Node

var adventurer_count : int:
	get:
		return adventurers.size()

var adventurers : Array[Adventurer]

func _ready() -> void:
	EventBus.subscribe(GameEvents.ADVENTURER_CREATED, add_adventurer)


func add_adventurer(adventurer : Adventurer) -> void:
	print("添加冒险者[%s]" % adventurer.display_name)
	if not adventurers.has(adventurer):
		adventurers.append(adventurer)
		adventurer.id = adventurer_count
