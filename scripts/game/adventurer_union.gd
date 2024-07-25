class_name AdventurerUnion
extends Building

func _ready() -> void:
	focused = ValueWithSignal.new()
	focused.value_changed.connect(update_focused)

func update_focused(v : bool) -> void:
	print("update_focused " + str(v))
