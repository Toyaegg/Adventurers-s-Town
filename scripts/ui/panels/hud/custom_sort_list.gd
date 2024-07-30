class_name CustomSortList
extends Control

var filter
@export var item_prefab : Control
@export var content : BoxContainer

var items : Dictionary

func refresh_data(datas : Array) -> void:
	var i := 0
	print("此次显示%d个数据" % datas.size())
	for data in datas:
		if items.has(data):
			content.move_child(items[data], i)
			items[data].set_data(data)
		else:
			create_and_initialize_item(data)
		i += 1

func create_and_initialize_item(data) -> Control:
	var item = item_prefab.duplicate()
	item.show()
	content.add_child(item)
	item.set_data(data)
	item.name = data.name
	print(data.name)
	items[data] = item
	return item

func _ready() -> void:
	content.remove_child(item_prefab)
