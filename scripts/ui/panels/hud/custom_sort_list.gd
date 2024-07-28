class_name CustomSortList
extends Control

var filter
@export var item_prefab : Control
@export var content : BoxContainer

var items : Dictionary

func refresh_data(datas : Array) -> void:
	var i := 0
	for data in datas:
		if items.has(data):
			content.move_child(items[data], i)
		else:
			create_and_initialize_item(data)
		i += 1

func create_and_initialize_item(data) -> Control:
	var item = item_prefab.duplicate()
	item.show()
	content.add_child(item)
	item.set_data(data)
	items[data] = item
	return item

func _ready() -> void:
	content.remove_child(item_prefab)
