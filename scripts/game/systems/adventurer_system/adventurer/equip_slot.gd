class_name EquipSlot
extends Node

var equipments : Array[EquipmentData]


func add_equipment(equipment : EquipmentData) -> void:
	equipments.append(equipment)

func remove_equip(equipment : EquipmentData) -> void:
	equipments.erase(equipment)
