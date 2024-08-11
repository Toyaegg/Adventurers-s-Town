extends Control

@onready var adventurer_union : Control = $AdventurerUnion
@onready var resources_display_list : Control = $ResourcesDisplayList
@onready var union_exp: TextureProgressBar = %UnionEXP
@onready var union_exp_value: Label = %UnionEXPValue
@onready var biomass_value: Label = %BiomassValue
@onready var mineral_value: Label = %MineralValue
@onready var energy_core_value: Label = %EnergyCoreValue
@onready var time: Label = %Time
@onready var reputation_value: Label = %ReputationValue
@onready var gold_value: Label = %GoldValue
@onready var uname: Label = %Name
@onready var ulevel: Label = %Level

@export var building_info : Control

func _ready() -> void:
	#EventBus.subscribe(GameEvents.UI_VISIBLE_BUILDING_INFO, visible_building_info)
	building_info.hide()
	EventBus.subscribe(GameEvents.BUILD_ENTER_BUILD_MODE, enter_build_mode)
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, update_time)
	EventBus.subscribe(GameEvents.RESOURCE_CHANGED, update_resource_data)
	EventBus.subscribe(GameEvents.BUILDING_ADVENTURER_UNION_LEVEL_UP, update_union_exp)
	EventBus.subscribe(GameEvents.RESOURCE_REPUTATION_CHANGED, update_reptutation)

	EventBus.push_event(GameEvents.TIME_SYSTEM_START)
	EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_ADD_EXP, 0)
	EventBus.push_event(GameEvents.RESOURCE_ADD, [0, 0, 0])

func update_time(data : TimeSystem.TimeData) -> void:
	var dstr : String = "第%d天 " % data.day
	if data.in_night:
		dstr += "夜晚"
	else:
		dstr += "白天"

	time.text = dstr

func enter_build_mode(v: bool) -> void:
		visible = not v

func update_resource_data(gold : int, rep : int, r1 : int, r2 : int, r3 : int) -> void:
	print("更新资源数据")
	gold_value.text = str(gold)
	reputation_value.text = str(rep)
	biomass_value.text = str(r1)
	mineral_value.text = str(r2)
	energy_core_value.text = str(r3)

func update_union_exp(exp_v : int, max_exp : int, level : int) -> void:
	print("更新公会经验")
	union_exp.max_value = max_exp
	union_exp.value = exp_v

	ulevel.text = "公会等级   %d级" % level
	union_exp_value.text = "%d  (%2.2f%% %d级 )" % [exp_v, float(exp_v) / max_exp, level]

func update_reptutation(rep : int) -> void:
	reputation_value.text = str(rep)
