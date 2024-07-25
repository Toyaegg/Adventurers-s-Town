extends Control

@onready var adventurer_union : Control = $AdventurerUnion
@onready var resources_display_list : Control = $ResourcesDisplayList
@onready var union_exp: TextureProgressBar = %UnionEXP
@onready var union_exp_value: Label = %UnionEXPValue
@onready var gold_value: Label = %GoldValue
@onready var gem_value: Label = %GemValue
@onready var value: Label = %Value

var va : ValueWithSignal

func _ready() -> void:
	va = ValueWithSignal.new()
	va.value = "77"
	va.value_changed.connect(func (v): print(str(v)))

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_released("ui_cancel"):
		#EventBus.push_event(GameEvents.UI_OPEN, UIPanel.MainMenu)
		#EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.SaveFiles)
		#get_viewport().set_input_as_handled()
	va.value += "2"
	pass
