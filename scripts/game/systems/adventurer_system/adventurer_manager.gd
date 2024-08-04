extends Node2D

@onready var state_chart_debugger: MarginContainer = %StateChartDebugger

func _ready() -> void:
	EventBus.subscribe(GameEvents.ADVENTURER_CREATED, add_adventurer)


func add_adventurer(adventurer : Adventurer) -> void:
	print("添加冒险者[%s]" % adventurer.display_name)
	state_chart_debugger.debug_node(adventurer)
	add_child(adventurer)

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		GameManager.adventurer_system.create_test_adventure()
