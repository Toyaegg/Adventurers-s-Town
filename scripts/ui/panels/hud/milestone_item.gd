extends TextureButton

var milestone : Milestone
var pos : float

func _ready() -> void:
	get_tree().create_timer(0.1).timeout.connect(refresh)

	mouse_entered.connect(func():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(position.x - 250, position.y), 0.2)
		)
	mouse_exited.connect(func():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(0, pos), 0.2)
		)

func set_milestone(m : Milestone) -> void:
	milestone = m

func clicked() -> void:
	milestone.content.remove_child(self)
	EventBus.push_event(GameEvents.AUDIO_PLAY, ["sfx", "click"])
	queue_free()
	milestone.refresh()

func refresh() -> void:
	if is_inside_tree():
		await get_tree().create_timer(0.1).timeout
		name = str(position.y)
		pos = position.y
