extends Control

@export var res_icons : Array[Texture]

@export var res_icon : TextureRect
@export var res_need : Label

func set_data(res : int, need : int) -> void:
	res_icon.texture = res_icons[res]
	res_need.text = str(need)
