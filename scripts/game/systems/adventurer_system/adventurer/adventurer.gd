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

enum State{
	Idel,
	Rest,
	Shopping,
	Selling,
	ToDungeons,
	Back,
	Continue,
	Treat,
	Dispel,
	Cursed,
	Wounded,
	TakeMoney,
	SubmitTask,
	AcceptTask,
	ChallengeDungeon,
	EnhanceStrength,
}

const MAX_LEVEL = 1000

const GRAVITY = 200.0

#endregion

@export var display_name : String
@export var tier : Tier
@export var state : State

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
#var

var sundries_count : int:
	get:
		return inventory.get_sundries().size()

signal my_feature_complete

func _ready() -> void:
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
	else:
		animation.play(&"idle")

	move_and_slide()

func feature_complete() -> void:
	busy = false
	my_feature_complete.emit()

func add_hp(value : float) -> void:
	print("血量+", value)
	attribute.cur_hp += value

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






func _on_idle_state_processing(delta: float) -> void:
	#检查冒险者状态
	if attribute.hp_amount < 0.2:
		state_chart.send_event("hp_low")
	elif wallet.gold < 100:
		state_chart.send_event("gold_low")
	elif mp.cur_mp < 15:
		state_chart.send_event("mp_low")
	elif busy:
		state_chart.send_event("skill_low")
	elif mp.cur_mp < 15:
		state_chart.send_event("skill_low")
