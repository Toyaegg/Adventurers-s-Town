extends Node2D

@export var slot : Node2D
@export var slots : Node2D
@export var slot_size : float

@export var build_menu : Control

var adventurer_union : PackedScene = preload("res://scenes/game/building/adventurer_union.tscn")
var flash_gold : PackedScene = preload("res://scenes/game/building/flash_gold.tscn")
var church : PackedScene = preload("res://scenes/game/building/church.tscn")
var house : PackedScene = preload("res://scenes/game/building/house.tscn")
var inn : PackedScene = preload("res://scenes/game/building/inn.tscn")
var training_ground : PackedScene = preload("res://scenes/game/building/training_ground.tscn")

var slots_dic : Dictionary

func _ready() -> void:
	slots.remove_child(slot)

	create_slots()

	for slot_id in slots_dic:
		slots_dic[slot_id].show_build_item(GameManager.build_mode_progress.value)

	EventBus.subscribe(GameEvents.BUILD_BUILDING, build)
	EventBus.subscribe(GameEvents.BUILD_CLICK_BUILD_MENU, open_build_menu)
	EventBus.subscribe(GameEvents.BUILD_ENTER_BUILD_MODE, enter_build_mode)

func create_slots() -> void:
	create_slot(0)

	for i in range(1, 30):
		create_slot(i)
		create_slot(-i)

func create_slot(id : int) -> void:
	var tslot : Node2D = slot.duplicate()
	slots.add_child(tslot)
	tslot.position.x = id * slot_size
	tslot.id = id
	tslot.name = str(id)
	slots_dic[id] = tslot

func build(slot_id : int, id : StringName) -> void:
	if GameManager.town_model.has_building_only_one(id):
		EventBus.push_event(GameEvents.UI_POP_TEXT_TIP, ["唯一建筑，不可以多次建造", 515, -300])
		print("唯一建筑，不可以多次建造")
		return
	if not GameManager.town_model.can_build():
		EventBus.push_event(GameEvents.UI_POP_TEXT_TIP, ["资源不足，不能建造", 515, -300])
		print("资源不足，不能建造")
		return

	print("在[%s]处建造[%s]" % [str(slot_id), id])
	build_menu.hide()
	var b : Building
	match id:
		&"au":
			b = adventurer_union.instantiate()
		&"c":
			b = church.instantiate()
		&"fg":
			b = flash_gold.instantiate()
		&"h":
			b = house.instantiate()
		&"tg":
			b = training_ground.instantiate()
		&"i":
			b= inn.instantiate()

	GameManager.building_system.build(slots_dic[slot_id], b)

func open_build_menu(slot_id : int, open_pos : Vector2) -> void:
	build_menu.show()
	build_menu.selected_slot_id = slot_id
	build_menu.global_position = open_pos

func enter_build_mode(v: bool) -> void:
		for slot_id in slots_dic:
			slots_dic[slot_id].show_build_item(v)
