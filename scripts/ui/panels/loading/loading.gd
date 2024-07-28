extends Control

@onready var load_progress: TextureProgressBar = %LoadProgress
@onready var progress_value: Label = %ProgressValue

func _ready() -> void:
	EventBus.subscribe(GameEvents.UI_PROGRESS_CHANGED, update_progress)
	load_progress.value_changed.connect(change_value)

func update_progress(value : float) -> void:
	load_progress.value = value

func change_value(value : float) -> void:
	progress_value.text = "%1.1f%%" % value
