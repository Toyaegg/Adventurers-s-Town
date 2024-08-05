class_name EXP
extends Node

const MAX_EXP_VALUE = 100000

var level : int
var cur_exp : float
var exp_multiply : float
@export var exp_multiply_factor : float = 2
@export var curve : Curve

signal level_up(level : int)

var max_exp : int:
	get:
		return MAX_EXP_VALUE * curve.sample(level / Adventurer.MAX_LEVEL)


var exp_amount : float:
	get:
		return float(cur_exp) / max_exp
		

func add_exp(value : int) -> void:
	cur_exp += value
	var max = max_exp
	if cur_exp >= max:
		cur_exp -= max
		level += 1
		level_up.emit(level)
