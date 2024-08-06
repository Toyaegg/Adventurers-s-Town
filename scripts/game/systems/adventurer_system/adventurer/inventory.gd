class_name Inventory
extends Node

class ItemSlot:
	var item : Item
	var count : int

var items : Array[ItemSlot]



func add_item(item : Item, count : int) -> void:
	var t = items.filter(func(item): return item.item == item)
	
	if t.size() > 0:
		t.count += count
	else:
		var s : ItemSlot = ItemSlot.new()
		s.item = item
		s.count += count
		items.append(s)
