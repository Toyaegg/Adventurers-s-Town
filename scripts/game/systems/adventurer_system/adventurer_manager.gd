extends Node2D

func _ready() -> void:
	EventBus.subscribe(GameEvents.ADVENTURER_CREATED, add_adventurer)


func add_adventurer(adventurer : Adventurer) -> void:
	print("添加冒险者", adventurer.attack_growth)
	add_child(adventurer)



