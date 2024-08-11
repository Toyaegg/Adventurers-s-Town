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

	EventBus.subscribe(GameEvents.ADVENTURER_REST, rest)
	EventBus.subscribe(GameEvents.ADVENTURER_TREAT, treat)
	EventBus.subscribe(GameEvents.ADVENTURER_BLESSING, blessing)
	EventBus.subscribe(GameEvents.ADVENTURER_LIFT, lift)
	EventBus.subscribe(GameEvents.ADVENTURER_TRAINING, train)

	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_REST, rest_finish)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_TREAT, treat_finish)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_BLESSING, blessing_finish)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_LIFT, lift_finish)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_TRAINING, train_finish)

	print("AdventurerSystem ready")

func time_changed(data : TimeSystem.TimeData) -> void:
	## TODO 检查容量是否达到上限
	#print("冒险者创建检查")
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

	adv.exp_comp.level = 1#get_random_level(tier)
	adv.attribute.initialize(cof.base_attack, cof.base_defence, cof.base_hp, cof.potential, get_growth(cof.min_growth, cof.max_growth))
	adv.mp.cur_mp = randi_range(50, 100)
	adv.display_name = str(adv.get_instance_id())
	return adv

func random_tendency() -> Adventurer.PotentialTendency:
	return randi_range(0, 2) as Adventurer.PotentialTendency


func get_growth(min_g : float, max_g : float) -> float:
	return randf_range(min_g, max_g)

func treat(_user :Adventurer) -> void:
	print("治疗中……")

func treat_finish(user :Adventurer) -> void:
	user.attribute.full_hp()

func lift(_user :Adventurer) -> void:
	print("驱散中……")

func lift_finish(user :Adventurer) -> void:
	user.curses.clear_curse()

func blessing(_user :Adventurer) -> void:
	print("祈祷中……")

func blessing_finish(user :Adventurer) -> void:
	var buff : Buff = GameManager.adventurer_model.get_random_buff()
	user.buffs.add_buff(buff)

func rest(user :Adventurer) -> void:
	user.mp.start_restore = true

func rest_finish(user :Adventurer) -> void:
	user.mp.start_restore = false

func train(_user :Adventurer) -> void:
	print("训练中……")

func train_finish(user :Adventurer) -> void:
	user.wallet.gold -= 50
	user.mp.cost_mp(30)
