class_name Milestone
extends Control

@export var item_prefab : Control
@export var content : BoxContainer

func _ready() -> void:
	content.remove_child(item_prefab)
	EventBus.subscribe(GameEvents.DUNGEON_FINISH_MESSAGE, show_message)


func show_message(dname : StringName, uname : StringName) -> void:
	print("【%s】完成了【%s】" % [uname, dname])
	var item = item_prefab.duplicate()
	var lab : Label = item.get_node("Content")
	lab.text = "【%s】完成了【%s】" % [uname, dname]
	content.add_child(item)
