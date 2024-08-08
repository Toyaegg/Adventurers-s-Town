class_name Attribute
extends Node

const MAX_GROWTH = 1
const MAX_MAIN_TENDENCY = 0.5

@export var tendency : Adventurer.PotentialTendency

var attack : float
var defence : float
var hp : float

var cur_attack : float
var cur_defence : float
var cur_hp : float
var max_hp : float

var potential : float
var growth : float

var attack_growth : float
var defence_growth : float
var hp_growth : float

@export var adventurer : Adventurer

var hp_amount : float:
	get:
		return cur_hp / max_hp;

func initialize(pattack : float, pdefence : float, php : float, ppotential : float, pgrowth : float) -> void:
	potential = ppotential
	growth = pgrowth
	attack = pattack
	defence = pdefence
	hp = php

	adventurer.exp_comp.exp_multiply = (MAX_GROWTH - growth) * adventurer.exp_comp.exp_multiply_factor

	compute_growth()
	compute_attribute()

func compute_growth() -> void:
	match tendency:
		Adventurer.PotentialTendency.Attack:
			attack_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			defence_growth = left_potential * randf_range(0.2, 0.8)
			hp_growth = left_potential - defence_growth
		Adventurer.PotentialTendency.Defence:
			defence_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			attack_growth = left_potential * randf_range(0.2, 0.8)
			hp_growth = left_potential - attack_growth
		Adventurer.PotentialTendency.HP:
			hp_growth = potential * MAX_MAIN_TENDENCY
			var left_potential = potential * (1 - MAX_MAIN_TENDENCY)
			defence_growth = left_potential * randf_range(0.2, 0.8)
			attack_growth = left_potential - defence_growth

func compute_attribute() -> void:
	for i in adventurer.exp_comp.level:
		cur_attack += attack_growth
		cur_defence += defence_growth
		cur_hp += hp_growth
		max_hp = cur_hp

func full_hp() -> void:
	cur_hp = max_hp
