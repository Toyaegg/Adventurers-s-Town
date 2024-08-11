class_name Inventory
extends Node

var items : Array[ItemSlot]



func add_item(item : Item, count : int) -> void:
	store_items()

	var t = items.filter(func(i): return i.item == item)

	if t.size() > 0:
		t[0].count += count
	else:
		var s : ItemSlot = ItemSlot.new()
		s.item = item
		s.count += count
		items.append(s)

func get_items() -> Array[ItemSlot]:
	return items.filter(func(item): return item.count > 0)


func store_items() -> void:
	for slot in items:
		if slot.count == 0:
			items.erase(slot)
