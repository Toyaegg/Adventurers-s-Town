extends TextureButton

@export var icons : Dictionary

@onready var building_icon: TextureRect = $"BuildingIcon"
@onready var building_name: Label = $"BuildingName"

@export var resource_need_prefab: Control
@onready var content: VBoxContainer = $"Control/VBoxContainer"
@onready var levelup: Button = $"Levelup"

var bind_data : Building

func _ready() -> void:
	content.remove_child(resource_need_prefab)
	levelup.pressed.connect(level_up)
	levelup.hide()
	EventBus.subscribe(GameEvents.RESOURCE_CHANGED, check_can_levelup)
	EventBus.subscribe(GameEvents.BUILDING_LEVEL_UP_FINISH, set_data)
	check_can_levelup()
	print("建筑信息")

func set_data(data : Building) -> void:
	bind_data = data
	building_name.text = str(bind_data.building_config.display_name)
	building_icon.texture = icons[data.building_config.id]
	#print(bind_data.building_config.display_name, " ", building_name.get_path() )

	for child in content.get_children():
		if child != resource_need_prefab:
			print("移除建筑信息子节点")
			child.queue_free()

	if data.building_config.resource_need.size() == 0:
		return

	if data.level >= data.building_config.max_level:
		levelup.hide()
		return

	var needs = data.building_config.resource_need[data.level]

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
	EventBus.push_event(GameEvents.BUILDING_LEVEL_UP, bind_data)


func check_can_levelup(_g = 0, _r = 0, _r1 = 0, _r2 = 0, _r3 = 0) -> void:
	if bind_data == null:
		return
	if bind_data.level >= bind_data.building_config.max_level:
		return
	var need : Array[int]
	need.append_array(bind_data.building_config.resource_need[bind_data.level])

	if GameManager.town_model.can_level_up(need):
		levelup.show()
