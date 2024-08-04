class_name DungeonSystem
extends Node

var dungeon_config_1_100 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_1_100_config.tres")
var dungeon_config_101_200 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_101_200_config.tres")
var dungeon_config_201_300 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_201_300_config.tres")
var dungeon_config_301_400 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_301_400_config.tres")
var dungeon_config_401_500 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_401_500_config.tres")
var dungeon_config_501_600 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_501_600_config.tres")
var dungeon_config_601_1000 := preload("res://assets/data/config/dungeon_create_config/dungeon_level_601_1000_config.tres")

func _ready() -> void:
	initialize()

func initialize() -> void:
	create_dungeons(dungeon_config_1_100)
	create_dungeons(dungeon_config_101_200)
	create_dungeons(dungeon_config_201_300)
	create_dungeons(dungeon_config_301_400)
	create_dungeons(dungeon_config_401_500)
	create_dungeons(dungeon_config_501_600)
	create_dungeons(dungeon_config_601_1000)
	print("下城生成完毕")


func create_dungeons(config : DungeonCreateConfig) -> void:
	var rng = RandomNumberGenerator.new()
	for i in config.dungeon_count:
		##随机名称
		var dungeon : Dungeon = Dungeon.new()
		var pre_name = config.pre_names[rng.randi_range(0, config.pre_names.size() - 1)]
		var last_name = config.pre_names[rng.randi_range(0, config.last_names.size() - 1)]
		dungeon.display_name = pre_name + last_name
		
		##随机等级限制
		var min_enter_level = rng.randi_range(config.min_level_range.x, config.min_level_range.y)
		var max_enter_level = rng.randi_range(config.max_level_range.x, config.max_level_range.y)
		
		dungeon.min_enter_level = min_enter_level
		dungeon.max_enter_level = max_enter_level
		
		##随机挑战时间
		var challenge_days = rng.randi_range(config.challenge_days_range.x, config.challenge_days_range.y)
		dungeon.challenge_days = challenge_days
		
		##随机BOSS
		var boss = config.bosses[rng.randi_range(0, config.bosses.size() - 1)]
		dungeon.boss = boss
		
		##随机成功率
		var success_probability = rng.randf_range(config.success_probabiliy_range.x, config.success_probabiliy_range.y)
		dungeon.success_probability = success_probability
		
		##随机成功掉落
		var drop_items : Array[Item]
		var it = config.success_drops.duplicate()
		it.shuffle()
		it.slice(0, config.success_drop_item_count_range.y + 2)
		drop_items.append_array(it)
		
		dungeon.success_drop = drop_items
		dungeon.min_drop_item_type = config.success_drop_count_range.x
		dungeon.max_drop_item_type = config.success_drop_count_range.y
		dungeon.min_drop_item_count = config.success_drop_item_count_range.x
		dungeon.max_drop_item_count = config.success_drop_item_count_range.y
		
		##随机失败诅咒概率
		var failed_effect_probabiliy : float = rng.randf_range(config.failed_effect_probabiliy_range.x, config.failed_effect_probabiliy_range.y)
		dungeon.failed_effect_probability = failed_effect_probabiliy
		
		##随机失败诅咒
		var failed_effect : Buff = config.failed_effects[rng.randi_range(0, config.failed_effects.size() - 1)]
		dungeon.failed_effect = failed_effect
		
		##经验值
		dungeon.min_exp = config.exp_range.x 
		dungeon.max_exp = config.exp_range.y 
		
		EventBus.push_event(GameEvents.DUNGEON_CREATED, dungeon)
