class_name DungeonCreateConfig
extends Resource

@export var dungeon_name : StringName
@export var min_enter_level : int
@export var max_enter_level : int
@export var challenge_days : int
@export var success_drops : Array[Item]
@export var success_drop_count : Array[int]
@export var success_drop_probability : Array[float]
@export var failed_effect : Buff
@export var success_probabiliy : Array[float]
@export var failed_effect_probabiliy : float
@export var hp_cast_range : Vector2i
@export var mp_cast_range : Vector2i
@export var exp_range : Vector2i
