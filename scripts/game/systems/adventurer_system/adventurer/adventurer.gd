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

var id : int

var busy : bool = false
var target_building : Building
var target_building_id : StringName
var target_dungeon : Dungeon
var target_Weapon : Node

var move_direction : int

var sundries_count : int:
	get:
		return inventory.items.size()

signal my_feature_complete

func _ready() -> void:
	get_tree().create_timer(1).timeout.connect(func():state_chart.send_event("init"))
	
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

func add_rewards(rewards : Array[Item], rewards_count : Array[int]) -> void:
	print("添加奖励")
	for i in rewards.size():
		print("[%s] [%d]" % [rewards[i].display_name, rewards_count[i]])
		inventory.add_item(rewards[i], rewards_count[i])

func lift_curse() -> void:
	print("诅咒驱散")
	curses.clear()


func blessing() -> void:
	print("祈福BUFF")

func equip_equipment() -> void:
	print("穿装备")

func unequip_equipment() -> void:
	print("脱装备")

func add_item() -> void:
	print("添加物品")

func use_item() -> void:
	print("使用物品")

func has_enough_mp() -> bool:
	return mp.cur_mp > 50

func has_enough_money() -> bool:
	return wallet.gold < 20

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


func _on_find_dungeon() -> void:
	print("寻找适的地牢")
	var dungeons = GameManager.dungeon_model.find_suitable_dungeons(exp.level)
	
	for dungeon in dungeons:
		#print("地牢的成功率 [%2.2f]%%" % (dungeon.success_probability * 100))
		
		target_dungeon = dungeon
	
	if target_dungeon != null:
		print("找到的地牢名字 [%s]" % target_dungeon.display_name)
		state_chart.send_event("find_dungeon")
	
	


func _on_challenge_dungeon() -> void:
	use_building(Building.Feature.ChallengeDungeon)


func use_building(feature : Building.Feature) -> void:
	target_building.enter(self)
	target_building.use(self, feature)
	await my_feature_complete
	EventBus.push_event(GameEvents.BUILDING_FEATURE_FINISH_DUNGEON, self)
	state_chart.send_event("dungeon_finish")
	target_building.exit(self)
