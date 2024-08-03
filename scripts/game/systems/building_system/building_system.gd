class_name BuildingSystem
extends Node


func build(slot : Node2D, building : Building) -> void:
	slot.build(building)
	GameManager.town_model.build_complete(building)
