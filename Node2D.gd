extends Node2D

var dd : Array

func _ready() -> void:
	var afv = Adventurer.new()

	dd.append(afv)

	print(dd.has(afv))
