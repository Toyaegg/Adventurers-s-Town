extends Control

@export var building_icon: TextureRect
@export var building_name: Label

@export var resource_need_prefab: Control
@export var content: VBoxContainer

var bind_data : BuildingConfig

func _ready() -> void:
	pass

func set_data(data : BuildingConfig) -> void:## : Building) -> void:
	bind_data = data
	building_name.text = str(bind_data.display_name)

func _input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		print("%s被点击" % bind_data.display_name)
