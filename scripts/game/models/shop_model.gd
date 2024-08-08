class_name ShopModel
extends Node

var equipments : Dictionary
var potions : Dictionary

func _ready() -> void:
	for i in range(1, 42):
		equipments[500 + i] = load("res://assets/data/config/equipment/equipment_5%02d.tres" % i)
	for i in range(1, 15):
		potions[200 + i] = load("res://assets/data/config/potion/potion_2%02d.tres" % i)
		
	print("ShopModel ready")

func buy_equipment(id : int, user : Adventurer):
	user.equip_equipment(equipments[id])


func buy_potion(id : int, user : Adventurer):
	user.potion_slot.add_potion(potions[id])
