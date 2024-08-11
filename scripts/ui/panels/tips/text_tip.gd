extends Control


@export var content : Label

#func _ready() -> void:
	#set_text("测试短")
	#set_text("测试长  已经在论坛提交的内容，请勿重复在 QQ 上私信或 @ 开发者，除非你能确定错误和对方有关")
	#pop(515, -300)

func set_text(c : String) -> void:
	content.text = c
	print(content.size.x)
	size.x = content.size.x + 30

func pop(from : float = 515, distance : float = 555) -> void:
	position.y = from
	var tween = get_tree().create_tween()

	tween.tween_property(self, "position", Vector2(position.x, position.y + distance), 0.5)
	tween.chain().tween_property(self, "modulate", Color(1, 1, 1, 0), 2)
	tween.chain().tween_callback(func(): EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.TextTip))
