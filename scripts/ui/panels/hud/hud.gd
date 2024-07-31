extends Control

@onready var adventurer_union : Control = $AdventurerUnion
@onready var resources_display_list : Control = $ResourcesDisplayList
@onready var union_exp: TextureProgressBar = %UnionEXP
@onready var union_exp_value: Label = %UnionEXPValue
@onready var biomass_value: Label = %BiomassValue
@onready var mineral_value: Label = %MineralValue
@onready var energy_core_value: Label = %EnergyCoreValue
@onready var time: Label = %Time

@export var building_info : Control

func _ready() -> void:
	#EventBus.subscribe(GameEvents.UI_VISIBLE_BUILDING_INFO, visible_building_info)
	building_info.hide()
	EventBus.subscribe(GameEvents.BUILD_ENTER_BUILD_MODE, enter_build_mode)
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, update_time)

	EventBus.push_event(GameEvents.TIME_SYSTEM_START)

func update_time(data : TimeSystem.TimeData) -> void:
	var str : String = "第%d天 " % data.day
	if data.in_night:
		str += "夜晚"
	else:
		str += "白天"

	time.text = str

func enter_build_mode(v: bool) -> void:
		visible = not v
