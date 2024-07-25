class_name  ValueWithSignal
extends Object

var value :
	set(v):
		value = v
		value_changed.emit(value)
	get:
		return value

signal value_changed(v)
