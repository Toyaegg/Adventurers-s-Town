class_name MP
extends Node

const MAX_MP = 100

#var mp : float
var cur_mp : float:
	set(v):
		cur_mp = v
		if cur_mp < 0:
			cur_mp = 0
		if cur_mp > MAX_MP:
			cur_mp = MAX_MP

@export var mp_restore : float = 20.0

var start_restore : bool = false

var mp_amount : float:
	get:
		return cur_mp / MAX_MP;

var cur_day : int

func _ready() -> void:
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, time_changed)

func cost_mp(cost : int) -> void:
	cur_mp -= cost


func time_changed(time : TimeSystem.TimeData) -> void:
	if not start_restore:
		return

	if cur_day != time.day:
		print("mp 恢复 20 点")
		cur_day = time.day
		cur_mp += mp_restore
