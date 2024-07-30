extends Node2D

var build_control : Control

var id : int = -1
var used : bool = false
var building : Building

func _ready() -> void:
	build_control = get_node("Control")

func build(b : Building) -> bool:
	print("在%s建造了%s" % [str(id), b.building_config.display_name])
	if used:
		return false
	else:
		building = b
		build_control.queue_free()
		used = true
		add_child(building)
		print("建造完成")
		EventBus.push_event(GameEvents.BUILD_BUILDING_COMPLETE, building)
		return true

func show_build_item(active : bool) -> void:
	if not used:
		build_control.visible = active

