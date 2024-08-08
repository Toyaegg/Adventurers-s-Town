class_name Buffs
extends Node

var buffs : Array[Buff]
var cur_day : int

func _ready() -> void:
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, time_changed)

func add_buff(buff : Buff) -> void:
	print("添加BUFF【%s】,持续%d天" % [buff.display_name, buff.duration])
	buffs.append(buff.duplicate())


func time_changed(time : TimeSystem.TimeData) -> void:
	if cur_day != time.day:
		cur_day = time.day
		for buff in buffs:
			buff.duration -= 1
			if buff.duration == 0:
				print("BUFF【%s】到期移除" % buff.display_name)
				buffs.erase(buff)
