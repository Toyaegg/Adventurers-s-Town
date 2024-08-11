class_name DungeonSystem
extends Node

var dungeon_rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	initialize()

	EventBus.subscribe(GameEvents.ADVENTURER_CHALLENGE_DUNGEON, challenge_dungeon)
	EventBus.subscribe(GameEvents.BUILDING_FEATURE_FINISH_DUNGEON, finish_dungeon)

	print("DungeonSystem ready")

func initialize() -> void:
	for i in range(1, 10):
		var dungeon := load("res://assets/data/config/dungeon_create_config/dungeon_60%s.tres" % str(i))
		create_dungeons(dungeon)
		#print("下城生[%s]成完毕" % dungeon.dungeon_name)

##将数据复制到Dungeon中
func create_dungeons(config : DungeonCreateConfig) -> void:
	var dungeon : Dungeon = Dungeon.new()
	dungeon.display_name = config.dungeon_name
	dungeon.min_enter_level = config.min_enter_level
	dungeon.max_enter_level = config.max_enter_level
	dungeon.challenge_days = config.challenge_days
	dungeon.success_drop = config.success_drops
	dungeon.drop_item_count = config.success_drop_count
	dungeon.drop_item_probability = config.success_drop_probability
	dungeon.success_probability = config.success_probabiliy
	dungeon.failed_effect = config.failed_effect
	dungeon.failed_effect_probability = config.failed_effect_probabiliy
	dungeon.min_hp_cast = config.hp_cast_range.x
	dungeon.max_hp_cast = config.hp_cast_range.y
	dungeon.min_mp_cast = config.mp_cast_range.x
	dungeon.max_mp_cast = config.mp_cast_range.y
	dungeon.min_exp = config.exp_range.x
	dungeon.max_exp = config.exp_range.y

	EventBus.push_event(GameEvents.DUNGEON_CREATED, dungeon)


func finish_dungeon(user : Adventurer) -> void:
	var dungeon : Dungeon = user.target_dungeon

	var sp_index : int = maxi(0, dungeon_rng.randi_range(0, dungeon.success_probability.size() - 1))
	var sp = dungeon.success_probability[sp_index]
	print("此次挑战成功率为【%2.2f%%】" % (sp * 100))
	var success_value = dungeon_rng.randf()
	var result : bool = success_value < sp

	var cast_hp : int
	var cast_mp : int
	var curse : Buff
	var rewards : Array[Item]
	var rewards_count : Array[int]
	var reward_exp : int

	##消耗与经验
	cast_hp = dungeon_rng.randi_range(dungeon.min_hp_cast, dungeon.max_hp_cast)
	cast_mp = dungeon_rng.randi_range(dungeon.min_mp_cast, dungeon.max_mp_cast)
	reward_exp = dungeon_rng.randi_range(dungeon.min_exp, dungeon.max_exp)

	print("挑战结果 %s " % str(result))

	##成功操作
	if result:
		for i in dungeon.success_drop.size():
			var drop_value = dungeon_rng.randf()
			if drop_value < dungeon.drop_item_probability[i]:
				rewards.append(dungeon.success_drop[i])
				rewards_count.append(dungeon.drop_item_count[i])

		user.add_rewards(rewards, rewards_count)

	##失败操作
	else:
		cast_hp = int(cast_hp * 1.5)
		cast_mp = int(cast_mp * 1.5)
		reward_exp = int(reward_exp * 0.5)

		var effect_rng_value = dungeon_rng.randf()
		if effect_rng_value < dungeon.failed_effect_probability:
			curse = dungeon.failed_effect
			user.add_curse(curse)

	##消耗与经验添加
	user.add_hp(-cast_hp)
	user.add_mp(-cast_mp)
	user.add_exp(reward_exp)
	user.busy = false

	EventBus.push_event(
		GameEvents.RESOURCE_ADD, [dungeon.max_enter_level, int(
			0.8 * dungeon.max_enter_level), int(
				0.5 * dungeon.max_enter_level)])

	EventBus.push_event(GameEvents.DUNGEON_FINISH_MESSAGE, [user.display_name, dungeon.display_name])

	EventBus.push_event(GameEvents.BUILDING_ADVENTURER_UNION_ADD_EXP, [dungeon.max_enter_level])
	EventBus.push_event(GameEvents.RESOURCE_ADD_REPUTATION, dungeon.max_enter_level)


func challenge_dungeon(user : Adventurer) -> void:
	print("地下城挑战中……")
	user.busy = true
