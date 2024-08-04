class_name Dungeon
extends RefCounted

var display_name : StringName

var min_enter_level : int
var max_enter_level : int
var challenge_days : int
var boss : Boss

var success_drop : Array[Item]
var success_probability : float
var min_drop_item_type : int
var max_drop_item_type : int
var min_drop_item_count : int
var max_drop_item_count : int

var failed_effect : Buff
var failed_effect_probability : float

var min_exp : int
var max_exp : int


func can_enter(level : int) -> bool:
	if level >= min_enter_level and level <= max_enter_level:
		return true
	else:
		return false


func dungeon_challenge_success() -> bool:
	var result = randf()
	return result < success_probability

func get_result(user : Adventurer) -> void:
	#TODO 获取战利品
	print("获取战利品")
