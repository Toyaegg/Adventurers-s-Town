class_name Building
extends Node2D

enum Feature{
	ChallengeDungeon,
	Shopping,
	Selling,
	Treat,#治疗
	Lift,#驱散
	Blessing,
	Rest,
	Training,
}

@export_category("conponents")
@export var door : Node2D
@export var name_label : Label
@export_category("config")
@export var building_config : BuildingConfig

var id : String
var display_name : String
var pointer_entered : bool = false
var focused : ValueWithSignal
var level : int

var belong_to : StringName

@onready var visitors : Visitors
var feature_components : Array
var build_completed : bool = false

signal feature_complete

func _ready() -> void:
	focused = ValueWithSignal.new()
	focused.value_changed.connect(update_focused)
	set_ready()

func set_ready() -> void:
	print("building ready")
	visitors = get_node("Visitors")

	position.y = 200

	get_tree().create_timer(3).timeout.connect(func(): build_completed = true)
	get_tree().create_tween().tween_property(self, "position", Vector2.ZERO, 3)


func use(user : Adventurer, f : Feature) -> void:
	if visitors.has_user(user):
		var feature : BuildingFeature
		for ft in building_config.feature:
			if f == ft.feature:
				feature = ft
				feature.use(user)

func update_focused(v : bool) -> void:
	print("update_focused " + str(v))
	EventBus.push_event(GameEvents.UI_VISIBLE_BUILDING_INFO, [self, v])

func has_feature(f : Feature) -> bool:
	var result : bool = false

	for feature in building_config.feature:
		if f == feature.feature:
			result = true

	return result

func enter(user : Adventurer) -> void:
	user.hide()
	visitors.enter(user)
	print(user.display_name, "进入", building_config.display_name)

func exit(user : Adventurer) -> void:
	user.show()
	visitors.exit(user)
	print(user.display_name, "退出", building_config.display_name)

func on_pointer_enter() -> void:
	#print("on_pointer_enter")
	pointer_entered = true
	get_tree().create_timer(0.3).timeout.connect(
		func ():
			if pointer_entered:
				focused.value = true)

	name_label.text = building_config.display_name
	name_label.show()

func on_pointer_exit() -> void:
	#print("on_pointer_exit")
	pointer_entered = false
	focused.value = false
	name_label.hide()

func on_pointer_press() -> void:
	#print("on_pointer_press")
	get_viewport().set_input_as_handled()

func on_pointer_release() -> void:
	#print("on_pointer_release")
	get_viewport().set_input_as_handled()

func level_up() -> void:
	if GameManager.town_model.can_level_up(building_config.resource_need[level - 1]):
		level += 1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and focused.value:
		on_pointer_press()
	if event.is_action_released("click") and focused.value:
		on_pointer_release()
