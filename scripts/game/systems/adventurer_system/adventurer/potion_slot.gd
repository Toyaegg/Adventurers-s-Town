class_name PotionSlot
extends Node

var potions : Array[PotionData]



func add_potion(potion : PotionData) -> void:
	potions.append(potion)
	
func remove_potion(potion : PotionData) -> void:
	potions.erase(potion)
