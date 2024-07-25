class_name AudioManager
extends Node

var loaded_sfx : Dictionary
var loaded_bgm : Dictionary
#var loaded_ : Dictionary

func initialize() -> void:
	loaded_sfx.clear()
	loaded_bgm.clear()
	print("audio manager initialized")
