class_name EXP
extends Node

const MAX_EXP_VALUE = 100000

var level : int
var cur_exp : float:
	set(v):
		cur_exp = v
		var m = max_exp
		if cur_exp >= m:
			print("升级了")
			cur_exp -= m
			level += 1
			level_up.emit(level)
		EventBus.push_event(GameEvents.ADVENTURER_EXP_CHANGED, cur_exp)
		print("exp [%d/%d] %02.2f" % [cur_exp, max_exp, exp_amount])

var exp_multiply : float
@export var exp_multiply_factor : float = 2
@export var curve : Curve

signal level_up(level : int)

var max_exp : int:
	get:
		return int(MAX_EXP_VALUE * curve.sample(float(level) / Adventurer.MAX_LEVEL) * exp_multiply)


var exp_amount : float:
	get:
		return float(cur_exp) / max_exp


func add_exp(value : int) -> void:
	cur_exp += value
