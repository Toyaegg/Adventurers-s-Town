extends Control

@export var res_icons : Array[Texture]

@onready var res_icon : TextureRect = $"ResourceIcon"
@onready var res_need : Label = $"ResourceNeedValue"
	
func set_data(res : int, need : int) -> void:
	res_icon.texture = res_icons[res]
	res_need.text = str(need)
