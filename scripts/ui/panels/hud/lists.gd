extends Control

@export var building_list : Control
@export var adventurer_list : Control

@export var a_btn : ToggleButton
@export var b_btn : ToggleButton

func _ready() -> void:
	#adventurer_list.hide()
	#adventurer_list.hide()
	b_btn.button_clicked(b_btn)

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
