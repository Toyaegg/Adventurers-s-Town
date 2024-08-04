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

static var time : TimeData

func _ready() -> void:
	start_time = ValueWithSignal.new()
	time = TimeData.new()

	start_time.value = float(0)
	start_time.value_changed.connect(time_changed)
	second_as_day = second_as_hour * 24

	EventBus.subscribe(GameEvents.TIME_SYSTEM_START, start)
	EventBus.subscribe(GameEvents.TIME_SYSTEM_STOP, stop)

	print("TimeSystem ready")

func _process(delta: float) -> void:
	if is_running :
		start_time.value += delta

func start() -> void:
	is_running = true
	EventBus.push_event(GameEvents.TIME_VALUE_CHANGED, time)
	EventBus.push_event(GameEvents.TIME_SYSTEM_STARTED)

func stop() -> void:
	is_running = false
	EventBus.push_event(GameEvents.TIME_SYSTEM_STOPED)

func time_changed(v : float) -> void:
	var day : int = v / second_as_day;
	var time_passed = int(v) % second_as_day
	var hour_passed = time_passed / second_as_hour
	var is_night = hour_passed > day_time
	if time.day != day or time.in_night != is_night :
		#print("time changed ", v, " ", time.in_night, " ", is_night)
		time.day = day
		time.in_night = is_night
		EventBus.push_event(GameEvents.TIME_VALUE_CHANGED, time)

static func get_day() -> int:
	return time.day

static func get_is_night() -> bool:
	return time.in_night
