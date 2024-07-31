class_name Building
extends Node2D

enum Feature{
	AcceptTask,
	CompleteTask,
	Shopping,
	Selling,
	Treat,#治疗
	Lift,#驱散
	Blessing,
	Rest,
	Training,
	Trainingff,
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

var belong_to : StringName

@onready var visitors : Visitors
var feature_componnents : Array
var build_completed : bool = false

func set_ready() -> void:
	print("building ready")
	visitors = get_node("Visitors")
	print("building ready")
	position.y = 200
	get_tree().create_timer(3).timeout.connect(func(): build_completed = true)
	get_tree().create_tween().tween_property(self, "position", Vector2.ZERO, 3)

func has_feature(f : Feature) -> bool:
	return building_config.feature.has(f)

func enter(user : Adventurer) -> void:
	visitors.enter(user)
	print(user.display_name, "进入", building_config.display_name)

func exit(user : Adventurer) -> void:
	visitors.exit(user)
	print(user.display_name, "退出", building_config.display_name)

func on_pointer_enter() -> void:
	print("on_pointer_enter")
	pointer_entered = true
	get_tree().create_timer(0.3).timeout.connect(
		func ():
			if pointer_entered:
				focused.value = true)

	name_label.text = building_config.display_name
	name_label.show()

func on_pointer_exit() -> void:
	print("on_pointer_exit")
	pointer_entered = false
	focused.value = false
	name_label.hide()

func on_pointer_press() -> void:
	print("on_pointer_press")

func on_pointer_release() -> void:
	print("on_pointer_release")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and focused.value:
		on_pointer_press()
		get_viewport().set_input_as_handled()
	if event.is_action_released("click") and focused.value:
		on_pointer_release()
		get_viewport().set_input_as_handled()
