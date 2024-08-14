extends Node


@export var adventurer_name: Label

var bind_data : Adventurer

func _ready() -> void:
	print("冒险者信息")

func set_data(data : Adventurer) -> void:
	bind_data = data
	adventurer_name.text = "冒险者  %d" % data.id

	match bind_data.tier:
		Adventurer.Tier.Normal:
			adventurer_name.self_modulate = Color.GRAY
		Adventurer.Tier.Elite:
			adventurer_name.self_modulate = Color.SKY_BLUE
		Adventurer.Tier.Ultimate:
			adventurer_name.self_modulate = Color.ORANGE

func click() -> void:
	print("%s被点击" % bind_data.display_name)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["click", "sfx"])
