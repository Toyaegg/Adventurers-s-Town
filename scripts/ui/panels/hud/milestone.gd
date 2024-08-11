class_name Milestone
extends Control

@export var item_prefab : Control
@export var content : BoxContainer

func _ready() -> void:
	content.remove_child(item_prefab)
	EventBus.subscribe(GameEvents.DUNGEON_FINISH_MESSAGE, show_message)


func show_message(dname : StringName, uname : StringName) -> void:
	var item = item_prefab.duplicate()
	content.add_child(item)
	print("【%s】完成了【%s】" % [uname, dname])
	var lab : Label = item.get_node("Content")
	lab.text = "【%s】完成了【%s】" % [uname, dname]
	item.set_milestone(self)
	refresh()

func refresh() -> void:
	for item in content.get_children():
		item.refresh()

#func _input(event: InputEvent) -> void:
	#if event.is_action_released(&"ui_cancel"):
		#show_message("ddd", "fddf")
