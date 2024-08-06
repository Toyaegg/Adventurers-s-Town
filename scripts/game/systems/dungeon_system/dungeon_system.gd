class_name DungeonSystem
extends Node

var dungeon_config_1_100 := preload("res://assets/data/config/dungeon_create_config/dungeon_test_config.tres")

var dungeon_rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	initialize()
	
	EventBus.subscribe(GameEvents.ADVENTURER_CHALLENGE_DUNGEON, challenge_dungeon)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_DUNGEON, finish_dungeon)

func initialize() -> void:
	#create_dungeons(dungeon_config_1_100)
	print("下城生成完毕")


#func create_dungeons(config : DungeonCreateConfig) -> void:
	#var rng = RandomNumberGenerator.new()
	#for i in config.dungeon_count:
		###随机名称
		#var dungeon : Dungeon = Dungeon.new()
		#var pre_name = config.pre_names[rng.randi_range(0, config.pre_names.size() - 1)]
		#var last_name = config.pre_names[rng.randi_range(0, config.last_names.size() - 1)]
		#dungeon.display_name = pre_name + last_name
		#
		###随机等级限制
		#var min_enter_level = rng.randi_range(config.min_level_range.x, config.min_level_range.y)
		#var max_enter_level = rng.randi_range(config.max_level_range.x, config.max_level_range.y)
		#
		#dungeon.min_enter_level = min_enter_level
		#dungeon.max_enter_level = max_enter_level
		#
		###随机挑战时间
		#var challenge_days = rng.randi_range(config.challenge_days_range.x, config.challenge_days_range.y)
		#dungeon.challenge_days = challenge_days
		#
		###随机成功率
		#var success_probability = rng.randf_range(config.success_probabiliy_range.x, config.success_probabiliy_range.y)
		#dungeon.success_probability = success_probability
		#
		###随机成功掉落
		#var drop_items : Array[Item]
		#var it = config.success_drops.duplicate()
		#it.shuffle()
		#it.slice(0, config.success_drop_item_count_range.y + 2)
		#drop_items.append_array(it)
		#
		#dungeon.success_drop = drop_items
		#for c in config.success_drop_count_range.size():
			#dungeon.min_drop_item_count[c] = config.success_drop_item_count_range[c].x
			#dungeon.max_drop_item_count[c] = config.success_drop_item_count_range[c].y
		#
		###随机失败诅咒概率
		#var failed_effect_probabiliy : float = rng.randf_range(config.failed_effect_probabiliy_range.x, config.failed_effect_probabiliy_range.y)
		#dungeon.failed_effect_probability = failed_effect_probabiliy
		#
		###随机失败诅咒
		#var failed_effect : Buff = config.failed_effects[rng.randi_range(0, config.failed_effects.size() - 1)]
		#dungeon.failed_effect = failed_effect
		#
		###经验值
		#dungeon.min_exp = config.exp_range.x 
		#dungeon.max_exp = config.exp_range.y 
		#
		#EventBus.push_event(GameEvents.DUNGEON_CREATED, dungeon)


func finish_dungeon(user : Adventurer) -> void:
	var success_rng_value = dungeon_rng.randf()
	var result : bool = success_rng_value < user.target_dungeon.success_probability
	
	var cast_hp : int
	var cast_mp : int
	var curse : Buff
	var rewards : Array[Item]
	var rewards_count : Array[int]
	var reward_exp : int
	
	if result:
		cast_hp = dungeon_rng.randi_range(user.target_dungeon.min_hp_cast, user.target_dungeon.max_hp_cast)
		cast_mp = dungeon_rng.randi_range(user.target_dungeon.min_mp_cast, user.target_dungeon.max_mp_cast)
		var dr_copy = user.target_dungeon.success_drop.duplicate()
		dr_copy.shuffle()
		var drop_type_count : int = dungeon_rng.randi_range(user.target_dungeon.min_drop_item_type, user.target_dungeon.max_drop_item_type)
		rewards = dr_copy.slice(0, drop_type_count)
		#for i in rewards.size():
			#rewards_count.append(dungeon_rng.randi_range(user.target_dungeon.min_drop_item_count, user.target_dungeon.max_drop_item_count))
		rewards.append(user.target_dungeon.boss.drop)
		rewards_count.append(dungeon_rng.randi_range(user.target_dungeon.boss.drop_count_range.x, user.target_dungeon.boss.drop_count_range.y))
		reward_exp = dungeon_rng.randi_range(user.target_dungeon.min_exp, user.target_dungeon.max_exp)
	else:
		cast_hp = dungeon_rng.randi_range(user.target_dungeon.min_hp_cast, user.target_dungeon.max_hp_cast) * 1.5
		cast_mp = dungeon_rng.randi_range(user.target_dungeon.min_mp_cast, user.target_dungeon.max_mp_cast) * 1.5
		var dr_copy = user.target_dungeon.success_drop.duplicate()
		dr_copy.shuffle()
		var drop_type_count : int = dungeon_rng.randi_range(user.target_dungeon.min_drop_item_type, user.target_dungeon.max_drop_item_type)
		rewards = dr_copy.slice(0, drop_type_count)
		#for i in rewards.size():
			#rewards_count.append(dungeon_rng.randi_range(user.target_dungeon.min_drop_item_count, user.target_dungeon.max_drop_item_count) * 0.5)
		var effect_rng_value = dungeon_rng.randf()
		if effect_rng_value < user.target_dungeon.failed_effect_probability:
			curse = user.target_dungeon.failed_effect
		reward_exp = dungeon_rng.randi_range(user.target_dungeon.min_exp, user.target_dungeon.max_exp) * 0.5
	
	
	user.add_hp(-cast_hp)
	user.add_mp(-cast_mp)
	user.add_exp(reward_exp)
	user.add_rewards(rewards, rewards_count)
	if curse != null:
		user.add_curse(curse)


func challenge_dungeon(user : Adventurer) -> void:
	print("地下城挑战中……")
