extends Control

@export var item_prefab : Control
@export var content : BoxContainer

func _ready() -> void:
	content.remove_child(item_prefab)
