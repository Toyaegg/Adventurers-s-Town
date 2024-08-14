extends Control

@onready var load_progress: TextureProgressBar = %LoadProgress
@onready var progress_value: Label = %ProgressValue

var callback : Callable
var timer : SceneTreeTimer

func _ready() -> void:
	#EventBus.subscribe(GameEvents.UI_PROGRESS_CHANGED, update_progress)
	load_progress.value_changed.connect(change_value)
	timer = get_tree().create_timer(1)
	
	timer.timeout.connect(func():
		await get_tree().create_timer(0.5).timeout
		EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.Loading)
		callback.call()
		)

func _process(delta: float) -> void:
	update_progress(1 - timer.time_left)

func update_progress(value : float) -> void:
	load_progress.value = value

func change_value(value : float) -> void:
	progress_value.text = "%2.2f%%" % value
