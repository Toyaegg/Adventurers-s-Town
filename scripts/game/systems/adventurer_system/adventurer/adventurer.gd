class_name Adventurer
extends CharacterBody2D

#region 枚举和常量
enum Tier{
	Normal,
	Elite,
	Ultimate,
}

enum PotentialTendency{
	Attack,
	Defence,
	HP,
}

const MAX_LEVEL = 1000
const GRAVITY = 200.0

#endregion

@export var display_name : String
@export var tier : Tier

@export var move_speed : float = 200
@export var animation : AnimatedSprite2D
@export var state_chart : StateChart

@export var attribute : Attribute
@export var curses : Curses
@export var buffs : Buffs
@export var mp : MP
@export var exp : EXP
@export var inventory : Inventory
@export var wallet : Wallet
@export var equip_slot : EquipSlot
@export var potion_slot : PotionSlot

var id : int

var busy : bool = false
var target_building : Building
var target_building_id : StringName
var target_dungeon : Dungeon
var target_equipment : EquipmentData
var target_potion : PotionData

var move_direction : int

var sundries_count : int:
	get:
		return inventory.items.size()

signal my_feature_complete

func _ready() -> void:
	get_tree().create_timer(1).timeout.connect(func():state_chart.send_event("init"))
	
	exp.level_up.connect(func(_v): attribute.compute_attribute())
	
	print("adventurer created")

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_down"):
		print("cur_hp = 0")
		attribute.cur_hp = 0
	if Input.is_action_just_released("ui_up"):
		print("curses.append(0)")
		curses.append(0)

func _physics_process(delta) -> void:
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	move_and_collide(motion)

func move_dir(dir : int, tick : float) -> void:
	var distance : float = target_building.global_position.x - global_position.x
	if abs(distance) < 10:
		state_chart.send_event("%s_arrived" % target_building.building_config.id)
		velocity.x = 0
		animation.play(&"idle")
		return
	
	
	if dir > 0:
		velocity.x = Vector2.RIGHT.x * move_speed * tick
		animation.flip_h = false
	elif dir < 0:
		velocity.x = Vector2.LEFT.x * move_speed * tick
		animation.flip_h = true
	else:
		velocity.x = 0

	if abs(velocity.x) > 0.1:
		animation.play(&"walk")

	move_and_slide()

func feature_complete() -> void:
	busy = false
	my_feature_complete.emit()

func add_hp(value : float) -> void:
	print("血量 ", value)
	attribute.cur_hp += value

func add_mp(value : float) -> void:
	print("精力 ", value)
	mp.cur_mp += value

func add_exp(value : float) -> void:
	print("EXP ", value)
	exp.cur_exp += value

func add_gold(value : int) -> void:
	print("金币 ", value)
	wallet.gold += value

func add_rewards(rewards : Array[Item], rewards_count : Array[int]) -> void:
	print("添加奖励")
	for i in rewards.size():
		print("[%s] [%d]" % [rewards[i].display_name, rewards_count[i]])
		inventory.add_item(rewards[i], rewards_count[i])

func lift_curse() -> void:
	print("诅咒驱散")
	curses.clear()

func add_curse(curse : Buff) -> void:
	print("添加诅咒 ", curse.display_name)
	curses.add_curse(curse)

func blessing() -> void:
	print("祈福BUFF")

func equip_equipment(equipment : EquipmentData) -> void:
	print("穿装备 %s" % equipment.display_name)
	equip_slot.add_equip(equipment)

func unequip_equipment(equipment : EquipmentData) -> void:
	print("脱装备 %s" % equipment.display_name)
	equip_slot.remove_equip(equipment)

func sell_items() -> Array[ItemSlot]:
	print("卖掉物品")
	return inventory.items

func use_item() -> void:
	print("使用物品")

func has_enough_mp() -> bool:
	return mp.cur_mp > 50

func has_enough_hp() -> bool:
	return attribute.hp_amount > 0.8

func has_enough_money() -> bool:
	if wallet.gold < 20:
		print("只有%d金币了，不足20，没钱了" % wallet.gold)
	return wallet.gold > 20

func has_buff() -> bool:
	return buffs.buffs.size() > 0

func has_curse() -> bool:
	return curses.curses.size() > 0

func buy_equipment(equipment : EquipmentData) -> void:
	equip_slot.add_equipment(equipment)

func buy_potion(potion : PotionData) -> void:
	potion_slot.add_potion(potion)

func _on_make_money_entered() -> void:
	print("开始赚钱")
	
	if has_enough_mp():
		print("去地下城")
		state_chart.send_event("to_dungeon")
	
	if not has_enough_mp():
		print("只能去休息")
		state_chart.send_event("have_to_reat")
	
	if not has_enough_mp() and not has_enough_money():
		print("变卖贵重物品")
		state_chart.send_event("the_final_way")


func _on_move_to_building(delta: float) -> void:
	if target_building == null:
		_on_find_building(target_building_id)
		return
	
	if not target_building.build_completed:
		return
		
	var dir : int = target_building.global_position.x - global_position.x
	if dir < 10:
		move_direction = -1
	if dir > 10:
		move_direction = 1
		
	move_dir(move_direction, delta)

func _on_find_building(extra_arg_0: StringName) -> void:
	print("寻找id[%s]" % extra_arg_0)
	target_building_id = extra_arg_0
	
	var buildings : Array[Building] = GameManager.town_model.find_buildings(extra_arg_0)
	
	if buildings.size() == 0:
		print("没找到")
	elif buildings.size() == 1:
		target_building = buildings[0]
	elif buildings.size() > 1:
		for building in buildings:
			if building.belong_to == display_name:
				target_building = building
			else:
				print("没找到")


func _on_find_dungeon() -> void:
	print("寻找适的地牢")
	target_dungeon = GameManager.dungeon_model.find_suitable_dungeon(exp.level)
	print("找到的地牢名字 [%s]" % target_dungeon.display_name)
	state_chart.send_event("find_dungeon")


func _on_challenge_dungeon() -> void:
	use_building(Building.Feature.ChallengeDungeon)

func _on_sell_item() -> void:
	use_building(Building.Feature.Selling)

func _on_shopping() -> void:
	use_building(Building.Feature.Shopping)

func _on_train() -> void:
	use_building(Building.Feature.Training)


func use_building(feature : Building.Feature) -> void:
	target_building.enter(self)
	target_building.use(self, feature)
	await my_feature_complete
	target_building.exit(self)
	
	match feature:
		Building.Feature.ChallengeDungeon:
			EventBus.push_event(GameEvents.BUILDING_FEATURE_FINISH_DUNGEON, self)
			state_chart.send_event("dungeon_finish")
			
			target_dungeon = null
			target_building = null
		Building.Feature.Selling:
			EventBus.push_event(GameEvents.BUILDING_FEATURE_FINISH_SELLING, self)
			
			if has_enough_hp() and has_enough_mp():
				state_chart.send_event("have_nothing_to_do")
			
			if not has_enough_hp() or has_curse():
				state_chart.send_event("restore")
				
		Building.Feature.Shopping:
			EventBus.push_event(GameEvents.BUILDING_FEATURE_FINISH_SHOPPING, self)
			state_chart.send_event("shopping_finish")
		Building.Feature.Training:
			EventBus.push_event(GameEvents.BUILDING_FEATURE_FINISH_TRAINING, self)
			state_chart.send_event("train_finish")


func _on_dungeon_finish() -> void:
	state_chart.send_event("sell_items")
		



func _on_check_for_upgrade() -> void:
	target_equipment = GameManager.shop_system.get_random_equipment()
	target_potion = GameManager.shop_system.get_random_potion()
	
	if not has_enough_money():
		state_chart.send_event("no_money")
		return
		
	if has_enough_money() and (target_equipment != null or target_potion != null):
		state_chart.send_event("money_enough")
		return
		
	if not has_enough_money() and has_enough_mp() and has_enough_hp():
		state_chart.send_event("want_to_dungeon")
		return
		
	if not has_buff() and wallet.gold >= 100:
		state_chart.send_event("blessing")
		return
		
	state_chart.send_event("upgrade_skill")
