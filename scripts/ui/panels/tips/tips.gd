class_name Tip
extends Control

enum TipType{
	Message,
	Select,
	UserInput
}

@onready var tips_title : Label = %Title
@onready var tips_content : Label = %Content
@onready var buttons = %Buttons
@onready var confirm : Button = %Confirm
@onready var cancel : Button = %Cancel
@onready var input : TextEdit = %Input

var type : TipType

func set_type(tip_type : TipType = TipType.Message) -> void:
	type = tip_type
	match type:
		TipType.Message:
			tips_content.visible = true
			buttons.visible = true
			confirm.visible = true
			cancel.visible = false
			input.visible = false
		TipType.Select:
			tips_content.visible = true
			buttons.visible = true
			confirm.visible = true
			cancel.visible = true
			input.visible = false
		TipType.UserInput:
			tips_content.visible = false
			buttons.visible = true
			confirm.visible = true
			cancel.visible = true
			input.visible = true

func set_tip(content : String, conf : Callable = Callable(), canc : Callable = Callable(), title : String = "提示") -> void:
	confirm.pressed.connect(conf)
	cancel.pressed.connect(canc)
	if type == TipType.UserInput:
		printerr("UserInput类型不必置content")
		return
	tips_content.text = content
	tips_title.text = title


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.Tips)
		get_viewport().set_input_as_handled()
