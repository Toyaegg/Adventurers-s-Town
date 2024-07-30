extends Control

var building_icon: TextureRect
var building_name: Label

var resource_need_prefab: Control
var content: VBoxContainer

var bind_data : BuildingConfig

func _ready() -> void:
	building_icon = get_node("BuildingIcon")
	building_name = get_node("BuildingName")
	resource_need_prefab = get_node("Control/VBoxContainer/ResourceNeed")
	content = get_node("Control/VBoxContainer")

func set_data(data : Building) -> void:## : Building) -> void:
	bind_data = data.building_config
	building_name.text = str(bind_data.display_name)
	print(bind_data.display_name, " ", building_name.get_path() )

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		print("%s被点击" % bind_data.display_name)
