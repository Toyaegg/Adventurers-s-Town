class_name AdventurerModel
extends Node

var buff_data : Dictionary

var adventurer_count : int:
	get:
		return adventurers.size()

var adventurers : Array[Adventurer]

func _ready() -> void:
	EventBus.subscribe(GameEvents.ADVENTURER_CREATED, add_adventurer)
	EventBus.subscribe(GameEvents.SAVE_FILE_LOADED, load_data)
	EventBus.subscribe(GameEvents.GAME_RESET, reset_model)

	for i in range(1, 8):
		buff_data[400 + i] = load("res://assets/data/config/buff_data/buff_4%02d.tres" % i)

	print("AdventurerModel ready")


func add_adventurer(adventurer : Adventurer) -> void:
	print("添加冒险者[%s]" % adventurer.display_name)
	if not adventurers.has(adventurer):
		adventurers.append(adventurer)
		adventurer.id = adventurer_count
		
	SaveSystem.set_var("advs", adventurers)


func get_random_buff() -> Buff:
	var imax = buff_data.size()
	var index = 400 + randi_range(1, imax)
	return buff_data[index]

func get_adventurers() -> Array[Adventurer]:
	return adventurers

func load_data() -> void:
	adventurers = SaveSystem.get_var("advs")


func reset_model() -> void:
	print("reset_model adventurer")
	adventurers.clear()
