class_name AdventurerSystem
extends Node

var cur_day : int
var config_1 : AdventurerCreateConfig = preload("res://assets/data/config/adventurer_create_config/adventurer_tier_1.tres")
var config_2 : AdventurerCreateConfig = preload("res://assets/data/config/adventurer_create_config/adventurer_tier_2.tres")
var config_3 : AdventurerCreateConfig = preload("res://assets/data/config/adventurer_create_config/adventurer_tier_3.tres")
var adventurer_prefab : PackedScene = preload("res://scenes/game/adventurer.tscn")
var creats : Array[Adventurer.Tier]


func _ready() -> void:
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, time_changed)

func time_changed(data : TimeSystem.TimeData) -> void:
	## TODO 检查容量是否达到上限
	print("冒险者创建检查")
	if cur_day != data.day:
		cur_day = data.day
		if can_create_adventurer():
			for tier in creats:
				var adventurer : Adventurer = create_random_adventurer(tier)
				EventBus.push_event(GameEvents.ADVENTURER_CREATED, adventurer)
				creats.clear()

func can_create_adventurer() -> bool:
	var result : bool = false

	var probability : float = get_tier_probability(Adventurer.Tier.Normal)
	if randf_range(0.0, 1.0) < probability:
		creats.append(Adventurer.Tier.Normal)
		result = true

	probability = get_tier_probability(Adventurer.Tier.Elite)
	if randf_range(0.0, 1.0) < probability:
		creats.append(Adventurer.Tier.Elite)
		result = true

	probability = get_tier_probability(Adventurer.Tier.Ultimate)
	if randf_range(0.0, 1.0) < probability:
		creats.append(Adventurer.Tier.Ultimate)
		result = true

	return result

func get_tier_probability(tier : Adventurer.Tier) -> float:
	# TODO 完成获取冒险者公会等级，并且不同等级有不同的概率
	#var adventurer_union_level = GameManager.town_model.get_adventurer_union_level()
	#return randf_range(0.3, 0.42)
	return 0

func get_random_level(tier : Adventurer.Tier) -> int:
	# TODO 完成获取冒险者公会等级，并且不同等级有不同的等级范围
	#var adventurer_union_level = GameManager.town_model.get_adventurer_union_level()
	return randi() % Adventurer.MAX_LEVEL


func create_test_adventure(tier : Adventurer.Tier = Adventurer.Tier.Normal) -> void:
	var adventurer : Adventurer = create_random_adventurer(tier)
	EventBus.push_event(GameEvents.ADVENTURER_CREATED, adventurer)


func create_random_adventurer(tier : Adventurer.Tier = Adventurer.Tier.Normal) -> Adventurer:
	var adv : Adventurer = adventurer_prefab.instantiate() as Adventurer
	adv.tier = tier
	adv.attribute.tendency = random_tendency()
	var cof
	match tier:
		Adventurer.Tier.Normal:
			cof = config_1
		Adventurer.Tier.Elite:
			cof = config_2
		Adventurer.Tier.Ultimate:
			cof = config_3

	adv.exp.level = get_random_level(tier)
	adv.attribute.initialize(cof.base_attack, cof.base_defence, cof.base_hp, cof.potential, get_growth(cof.min_growth, cof.max_growth))
	adv.mp.mp = 100
	adv.mp.cur_mp = randi_range(50, 100)
	adv.display_name = str(adv.get_instance_id())
	return adv

func random_tendency() -> Adventurer.PotentialTendency:
	return randi_range(0, 2)


func get_growth(min : float, max : float) -> float:
	return randf_range(min, max)
