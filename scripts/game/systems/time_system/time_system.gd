class_name TimeSystem
extends Node

class TimeData:
	var day : int
	var in_night : bool

var start_time : ValueWithSignal
var second_as_hour : int
var second_as_day : int

var day_time : int :
	set(v):
		if v <= 20:
			day_time = v

var is_running : bool = false

var time : TimeData

func _ready() -> void:
	start_time = ValueWithSignal.new()
	time = TimeData.new()

	start_time.value = float(0)
	start_time.value_changed.connect(time_changed)
	second_as_day = second_as_hour * 24

	EventBus.subscribe(GameEvents.GAME_INNER_TIME_START, start)

func _process(delta: float) -> void:
	if is_running :
		start_time.value += delta

func start() -> void:
	is_running = true
	EventBus.push_event(GameEvents.GAME_INNER_TIME_CHANGED, time)

func stop() -> void:
	is_running = false

func time_changed(v : float) -> void:
	var day : int = v / second_as_day;
	var time_passed = int(v) % second_as_day
	var hour_passed = time_passed / second_as_hour
	var is_night = hour_passed > day_time
	if time.day != day or time.in_night != is_night :
		print("time changed ", v, " ", time.in_night, " ", is_night)
		time.day = day
		time.in_night = is_night
		EventBus.push_event(GameEvents.GAME_INNER_TIME_CHANGED, time)




