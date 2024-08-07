class_name DungeonModel
extends Node

var dungeons : Array[Dungeon]

func _ready() -> void:
	EventBus.subscribe(GameEvents.DUNGEON_CREATED, add_dungeon)

func find_suitable_dungeon(level : int) -> Dungeon:
	var result : Array[Dungeon] = dungeons.filter(func(dungeon : Dungeon): return dungeon.min_enter_level <= level)
	result.sort_custom(func(a : Dungeon, b : Dungeon): return a.min_exp > b.max_exp)
	return result[0]


func add_dungeon(dungeon : Dungeon) -> void:
	#print("地下城【%s】已经创建， BOSS:[%s] " % [dungeon.display_name, dungeon.boss.display_name])
	dungeons.append(dungeon)
