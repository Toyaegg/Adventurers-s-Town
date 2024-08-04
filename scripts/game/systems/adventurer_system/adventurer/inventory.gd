class_name Inventory
extends Node

var items : Array[Item]

func get_sundries() -> Array[Item]:
	var sundries : Array[Item] = items.filter(func(item : Item): return item.type == Item.ItemType.Sundries)
	return sundries
