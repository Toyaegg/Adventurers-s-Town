class_name TownModel
extends Node

var buildings : Array[Building]
var house_count : int = 0
var transport_position : float
var resource_1 : int = 10
var resource_2 : int = 10
var resource_3 : int = 10
var gold : int = 100
var reputation : int = 0

var exp_per_level : Array[int]
var union_exp : int = 0
var union_level : int = 0

func _ready() -> void:
	EventBus.subscribe(GameEvents.GOLD_CAST, add_gold)
	EventBus.subscribe(GameEvents.RESOURCE_ADD, add_resource)
	EventBus.subscribe(GameEvents.RESOURCE_USE, use_resource)
	EventBus.subscribe(GameEvents.BUILDING_ADVENTURER_UNION_ADD_EXP, add_adventurer_union_exp)
	
	EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_LEVEL_UP, [union_exp, union_level])
	
	exp_per_level.append(300)
	exp_per_level.append(1000)
	exp_per_level.append(3000)
	
	print("TownModel ready")

func build_complete(b : Building) -> void:
	var key : String = b.id
	buildings.append(b)
	EventBus.push_event(GameEvents.BUILD_BUILDING_COMPLETE, b)

func get_buildings() -> Array[Building]:
	return buildings

func find_buildings(id : String) -> Array[Building]:
	var fbuildings : Array[Building]
	for b in buildings:
		if b.building_config.id == id:
			fbuildings.append(b)

	return fbuildings

func get_transport_position() -> float:
	return transport_position

func has_building_only_one(id : StringName) -> bool:
	var result : bool = false

	for building in buildings:
		print("%s %s %s" % [building.building_config.id, id, str(building.id == id)])
		if building.building_config.id == id:
			print(building.display_name)
			result = building.building_config.only_one

	return result

func can_level_up(need : Array[int]) -> bool:
	var result := true
	if need[0] > resource_1:
		result = false
	if need[1] > resource_2:
		result = false
	if need[2] > resource_3:
		result = false
	return result

func add_gold(g : int) -> void:
	print("税收+%d金币" % g)
	gold += g
	EventBus.push_event(GameEvents.RESOURVE_CHANGED, [gold, reputation, resource_1, resource_2, resource_3])

func use_gold(g : int) -> void:
	if g > gold:
		return 
	print("使用%d金币" % g)
	gold -= g
	EventBus.push_event(GameEvents.RESOURVE_CHANGED, [gold, reputation, resource_1, resource_2, resource_3])


func add_resource(r1 : int, r2 :int, r3 : int) -> void:
	print("获得资源【%d】【%d】【%d】" % [r1, r2, r3])
	resource_1 += r1
	resource_2 += r2
	resource_3 += r3
	EventBus.push_event(GameEvents.RESOURVE_CHANGED, [gold, reputation, resource_1, resource_2, resource_3])


func use_resource(r1 : int, r2 :int, r3 : int) -> void:
	if r1 > resource_1 or r2 > resource_2 or r3 > resource_3:
		return
	print("使用资源【%d】【%d】【%d】" % [r1, r2, r3])
	resource_1 -= r1
	resource_2 -= r2
	resource_3 -= r3
	EventBus.push_event(GameEvents.RESOURVE_CHANGED, [gold, reputation, resource_1, resource_2, resource_3])


func add_adventurer_union_exp(exp_v : int) -> void:
	union_exp += exp_v
	
	if union_exp > exp_per_level[union_level]:
		union_level += 1	
	
	EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_LEVEL_UP, [union_exp, exp_per_level[union_level], union_level])
