class_name UIManager
extends CanvasLayer

var loaded_ui : Dictionary
var opened_ui : Dictionary

func initialize() -> void:
	loaded_ui.clear()

	EventBus.subscribe(GameEvents.UI_OPEN, open_ui)
	EventBus.subscribe(GameEvents.UI_CLOSE, close_ui)
	EventBus.subscribe(GameEvents.UI_TIPS_OPEN, open_tips)
	EventBus.subscribe(GameEvents.UI_POP_TEXT_TIP, pop_text_tip)
	EventBus.subscribe(GameEvents.UI_TIPS_OPEN, open_tips)
	EventBus.subscribe(GameEvents.UI_LOADING, open_loading)
	
	print("ui manager initialized")

func open_ui(ui_name : String) -> void:
	if not loaded_ui.has(ui_name):
		print("要打开的UI未加载[%s]， 正在进行加载" % ui_name)
		var ui = load("res://scenes/ui/%s/%s.tscn" % [ui_name, ui_name])
		if ui == null:
			printerr("要打开的UI[%s]， 加载失败" % ui_name)
		loaded_ui[ui_name] = ui

	var using_ui = (loaded_ui[ui_name] as PackedScene).instantiate()
	opened_ui[ui_name] = using_ui
	add_child(using_ui)
	print("UI[%s]已经打开" % ui_name)

func close_ui(ui_name : String) -> void:
	if not opened_ui.has(ui_name):
		print("要关闭的UI不存在[%s]" % ui_name)
	else:
		print("关闭的UI[%s]" % ui_name)
		var ui = opened_ui[ui_name] as Control
		opened_ui.erase(ui_name)
		ui.queue_free()

func open_tips(tip_type : Tip.TipType, content : String, conf : Callable = Callable(), canc : Callable = Callable(), title : String = "提示") -> void:
	open_ui(UIPanel.Tips)
	opened_ui[UIPanel.Tips].set_type(tip_type)
	opened_ui[UIPanel.Tips].set_tip(content, conf, canc, title)

func pop_text_tip(c : String, from : float, to : float) -> void:
	if opened_ui.has(UIPanel.TextTip):
		return
	open_ui(UIPanel.TextTip)
	opened_ui[UIPanel.TextTip].set_text(c)
	opened_ui[UIPanel.TextTip].pop(from, to)

func open_loading(callback : Callable) -> void:
	if opened_ui.has(UIPanel.Loading):
		return
	open_ui(UIPanel.Loading)
	opened_ui[UIPanel.Loading].callback = callback
