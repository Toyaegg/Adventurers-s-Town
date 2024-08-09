extends TextureButton

@export var icons : Dictionary

@onready var building_icon: TextureRect = $"BuildingIcon"
@onready var building_name: Label = $"BuildingName"

@export var resource_need_prefab: Control
@onready var content: VBoxContainer = $"Control/VBoxContainer"
@onready var levelup: Button = $"Levelup"

var bind_data : Building

func _ready() -> void:
	#building_name = get_node("BuildingName")
	#resource_need_prefab = get_node("Control/VBoxContainer/ResourceNeed")
	#content = get_node("Control/VBoxContainer")
	content.remove_child(resource_need_prefab)
	levelup.pressed.connect(level_up)
	levelup.hide()
	print("建筑信息")

func set_data(data : Building) -> void:## : Building) -> void:
	bind_data = data
	building_name.text = str(bind_data.building_config.display_name)
	building_icon.texture = icons[data.building_config.id]
	#print(bind_data.building_config.display_name, " ", building_name.get_path() )
	var needs = data.building_config.resource_need[data.level + 1]
	
	for child in content.get_children():
		if child != resource_need_prefab:
			print("移除建筑信息子节点")
			child.queue_free()
	
	if needs == null:
		return
	
	var ri = 0
	for count in needs:
		var need = resource_need_prefab.duplicate()
		content.add_child(need)
		need.set_data(ri, count)
		ri += 1
	

func click() -> void:
	print("%s被点击" % bind_data.building_config.display_name)
	

func level_up() -> void:
	EventBus.push_event(GameEvents.BUILDING_LEVEL_UP, [bind_data.building_config.resource_need[bind_data.level + 1], bind_data])
