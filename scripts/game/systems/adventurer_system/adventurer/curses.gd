class_name Curses
extends Node

var curses : Array[int]

var has_curse : bool:
	get:
		return curses.size() != 0;



