class_name BuildingFeature
extends Resource

signal feature_complete

@export var feature : Building.Feature
@export var feature_day : int

var start_day : int = 0
var used_days : int = 0
var running : bool = false
var user : Adventurer

func use(adventure : Adventurer) -> void:
	user = adventure
	start_day = TimeSystem.get_day()
	running = true
	user.busy = true
	if not feature_complete.is_connected(user.feature_complete):
		feature_complete.connect(user.feature_complete)
	EventBus.subscribe(GameEvents.TIME_VALUE_CHANGED, _feature_process)

func _feature_process(_value) -> void:
	if not running:
		return

	match feature:
			Building.Feature.ChallengeDungeon:
				print("【%s】挑战地下城" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_CHALLENGE_DUNGEON, user)
			Building.Feature.Shopping:
				print("【%s】购买" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_SHOPPING, user)
			Building.Feature.Selling:
				print("【%s】出售" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_SELLING, user)
			Building.Feature.Treat:
				print("【%s】治疗" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_TREAT, user)
			Building.Feature.Lift:
				print("【%s】驱散" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_LIFT, user)
			Building.Feature.Blessing:
				print("【%s】祈福" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_BLESSING, user)
			Building.Feature.Rest:
				print("【%s】休息" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_REST, user)
			Building.Feature.Training:
				print("【%s】训练" % user.display_name)
				EventBus.push_event(GameEvents.ADVENTURER_TRAINING, user)

	used_days = TimeSystem.get_day() - start_day
	if used_days == feature_day:
		completed()

func completed() -> void:
	feature_complete.emit()
	used_days = 0
	running = false
	user.busy = false
	if feature_complete.is_connected(user.feature_complete):
		feature_complete.disconnect(user.feature_complete)
	user = null
