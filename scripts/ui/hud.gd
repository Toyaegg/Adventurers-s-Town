extends Control

@onready var adventurer_union : Control = $AdventurerUnion
@onready var resources_display_list : Control = $ResourcesDisplayList
@onready var union_exp: TextureProgressBar = %UnionEXP
@onready var union_exp_value: Label = %UnionEXPValue
@onready var gold_value: Label = %GoldValue
@onready var gem_value: Label = %GemValue
@onready var value: Label = %Value

@export var building_info : Control

func _ready() -> void:
	#EventBus.subscribe(GameEvents.UI_VISIBLE_BUILDING_INFO, visible_building_info)
	building_info.hide()

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_released("ui_cancel"):
		#EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)
		#EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.SaveFiles)
		#get_viewport().set_input_as_handled()
	#va.value += "2"
	pass

func visible_building_info(building : Building, can_visible : bool) -> void:
	print("visible_building_info %s %s" % [building.display_name, building.get_info_position()])
	if can_visible:
		building_info.show()
		building_info.position = building.get_info_position()
		building_info.get_node("Info/Content/Name/NameValue").text = building.building_config.display_name
		building_info.get_node("Info/Content/Description/DescriptionValue").text = building.building_config.description
	else:
		building_info.hide()


