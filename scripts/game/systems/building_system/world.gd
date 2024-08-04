extends Node2D

@export var sprites : Array[Sprite2D]
@export var day_color : Color
@export var night_color : Color

@export var sun : Sprite2D
@export var moon : Sprite2D

func _ready() -> void:
	#EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, change_color)
	pass

func change_color(data : TimeSystem.TimeData) -> void:
	var fc : Color
	if data.in_night:
		fc = night_color
	else:
		fc = day_color
	#print(data.in_night)
	create_tween().tween_property(self, "modulate", fc, 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).finished.connect(func() :
		sun.visible = not data.in_night
		moon.visible = data.in_night
		)
	for sprite in sprites:
		create_tween().tween_property(sprite, "modulate", fc, 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
