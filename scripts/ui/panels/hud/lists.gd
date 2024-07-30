extends Control

@export var building_list : Control
@export var adventurer_list : Control

func _ready() -> void:
	adventurer_list.hide()

func _on_check_button_selected(bind_data: int) -> void:
	match  bind_data:
		0:
			building_list.show()
		1:
			adventurer_list.show()



func _on_check_button_unselected(bind_data: int) -> void:
	match  bind_data:
		0:
			building_list.hide()
		1:
			adventurer_list.hide()
