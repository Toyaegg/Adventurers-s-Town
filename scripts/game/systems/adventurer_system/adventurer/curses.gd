class_name Curses
extends Node

var curses : Array[Buff]

var has_curse : bool:
	get:
		return curses.size() != 0;

func clear_curse() -> void:
	curses.clear()
