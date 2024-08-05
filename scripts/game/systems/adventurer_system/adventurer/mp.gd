class_name MP
extends Node

const MAX_MP = 100

#var mp : float
var cur_mp : float

@export var mp_restore : float = 20.0

var mp_amount : float:
	get:
		return cur_mp / MAX_MP;

var cur_day : int

func _ready() -> void:
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, time_changed)


func time_changed(time : TimeSystem.TimeData) -> void:
	if cur_day != time.day:
		print("mp 恢复 20 点")
		cur_day = time.day
		cur_mp += mp_restore
		if cur_mp > MAX_MP:
			cur_mp = MAX_MP
