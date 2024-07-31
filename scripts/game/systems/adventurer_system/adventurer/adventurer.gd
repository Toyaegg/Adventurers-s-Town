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
const MAX_GROWTH = 1
const MAX_MAIN_TENDENCY = 0.5
#const MAX_MAIN_TENDENCY = 0.5

#endregion

@export var display_name : String
@export var tier : Tier
@export var tendency : PotentialTendency
@export var state : State
@export var exp_multiply_factor : float = 2

@export var move_speed : float = 200
@export var animation : AnimatedSprite2D

var id : int

var attack : float
var defence : float
var hp : float
var mp : float

var cur_attack : float
var cur_defence : float
var cur_hp : float
var cur_mp : float

var potential : float
var growth : float
var exp_multiply : float

var attack_growth : float
var defence_growth : float
var hp_growth : float

const GRAVITY = 200.0
var curses : Array[int]

var hp_amount : float:
	get:
		return cur_hp / hp;

var mp_amount : float:
	get:
		return cur_mp / mp;

var has_curse : bool:
	get:
		return curses.size() != 0;

func initialize(pattack : float, pdefence : float, php : float, ppotential : float, pgrowth : float) -> void:
	potential = ppotential
	growth = pgrowth
	attack = pattack
	defence = pdefence
	hp = php

	exp_multiply = (MAX_GROWTH - growth) * exp_multiply_factor

	compute_growth()

	print()

func compute_growth() -> void:
	match tendency:
		PotentialTendency.Attack:
			attack_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			defence_growth = left_potential * randf_range(0.2, 0.8)
			hp_growth = left_potential - defence_growth
		PotentialTendency.Defence:
			defence_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			attack_growth = left_potential * randf_range(0.2, 0.8)
			hp_growth = left_potential - attack_growth
		PotentialTendency.HP:
			hp_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			defence_growth = left_potential * randf_range(0.2, 0.8)
			attack_growth = left_potential - defence_growth

func _ready() -> void:
	tier = Tier.Ultimate
	tendency = PotentialTendency.HP
	initialize(20, 30, 50, 200, 0.8)

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_down"):
		print("cur_hp = 0")
		cur_hp = 0
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

func add_hp(value : float) -> void:
	print("血量+", value)
	cur_hp += value

func lift_curse() -> void:
	print("诅咒驱散")
	curses.clear()



