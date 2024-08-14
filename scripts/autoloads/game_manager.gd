extends Node

enum {
	NewGame,
	LoadGame
}

enum GameState{
	Start,
	Playing,
	Pause,
}

var managers : Node
var ui_manager : UIManager
var audio_manager : AudioManager
#var timer : Timer

var models : Node
var town_model : TownModel
var adventurer_model : AdventurerModel
var dungeon_model : DungeonModel
var shop_model : ShopModel

var systems : Node
var building_system : BuildingSystem
var time_system : TimeSystem
var adventurer_system : AdventurerSystem
var dungeon_system : DungeonSystem
var shop_system : ShopSystem


var player_display_name : String = "test"

var build_mode_progress : ValueWithSignal = ValueWithSignal.new()

var game_config := preload("res://assets/data/config/game_config/game_config.tres")

var scene_path : String = ""

func initialize() -> void:
	initialize_models()

	initialize_systems()

	create_managers()

	subscribe_events()

	build_mode_progress.value = false
	build_mode_progress.value_changed.connect(func(v): EventBus.push_event(GameEvents.BUILD_ENTER_BUILD_MODE, v))
	print("game initialized")

func create_managers() -> void:
	managers = Node.new()
	managers.name = "Managers"
	add_child(managers)

	create_ui_manager()
	create_audio_manager()

func initialize_models() -> void:
	models = Node.new()
	models.name = "Models"
	add_child(models)

	create_town_model()
	create_adventurer_model()
	create_dungeon_model()
	create_shop_model()

func initialize_systems() -> void:
	systems = Node.new()
	systems.name = "Systems"
	add_child(systems)

	create_time_system()
	create_building_system()
	create_adventurer_system()
	create_dungeon_system()
	create_shop_system()

func subscribe_events() -> void:
	EventBus.subscribe(GameEvents.GAME_START, start_game)
	EventBus.subscribe(GameEvents.GAME_LOAD, load_save_files)
	EventBus.subscribe(GameEvents.GAME_EXIT, exit_game)
	EventBus.subscribe(GameEvents.GAME_SAVE, save_game)

func create_ui_manager() -> void:
	ui_manager = UIManager.new()
	ui_manager.name = "UIManager"
	managers.add_child(ui_manager)
	ui_manager.initialize()

func create_audio_manager() -> void:
	audio_manager = AudioManager.new()
	audio_manager.name = "AudioManager"
	managers.add_child(audio_manager)
	audio_manager.initialize()

func create_town_model() -> void:
	town_model = TownModel.new()
	town_model.name = "TownModel"
	town_model.transport_position = 9000
	models.add_child(town_model)

func create_adventurer_model() -> void:
	adventurer_model = AdventurerModel.new()
	adventurer_model.name = "AdventurerModel"
	models.add_child(adventurer_model)

func create_dungeon_model() -> void:
	dungeon_model = DungeonModel.new()
	dungeon_model.name = "DungeonModel"
	models.add_child(dungeon_model)

func create_shop_model() -> void:
	shop_model = ShopModel.new()
	shop_model.name = "ShopModel"
	models.add_child(shop_model)

func create_building_system() -> void:
	building_system = BuildingSystem.new()
	building_system.name = "BuildingSystem"
	systems.add_child(building_system)

func create_adventurer_system() -> void:
	adventurer_system = AdventurerSystem.new()
	adventurer_system.name = "AdventurerSystem"
	systems.add_child(adventurer_system)

func create_dungeon_system() -> void:
	dungeon_system = DungeonSystem.new()
	dungeon_system.name = "DungeonSystem"
	systems.add_child(dungeon_system)

func create_shop_system() -> void:
	shop_system = ShopSystem.new()
	shop_system.name = "ShopSystem"
	systems.add_child(shop_system)

func create_time_system() -> void:
	time_system = TimeSystem.new()
	time_system.name = "TimeSystem"
	time_system.second_as_hour = game_config.second_as_hour
	time_system.day_time = game_config.day_time
	systems.add_child(time_system)

func start_game(method : int) -> void:
	match method:
		0:
			start_new_game()
		1:
			start_loaded_game()

func start_new_game() -> void:
	print("start_new_game")

func start_loaded_game() -> void:
	print("start_loaded_game")

func load_save_files() -> void:
	print("load_save_files")

func exit_game() -> void:
	EventBus.push_event(GameEvents.UI_TIPS_OPEN, [Tip.TipType.Select, "确定要退出游戏吗？",
		func():
			get_tree().quit(),
		func():
			EventBus.push_event(GameEvents.UI_CLOSE, UIPanel.Tips)])

func _input(event: InputEvent) -> void:
	if event.is_action_released("build_mode"):
		build_mode_progress.value = not build_mode_progress.value

func save_game() -> void:
	print("保存中……")
	await get_tree().create_timer(0.5).timeout
	SaveSystem.save()
	await SaveSystem.saved
	print("保存完成")


func load_game() -> void:
	print("加载中……")
	SaveSystem._load()
	await SaveSystem.loaded
	print("加载完成")
	EventBus.push_event(GameEvents.SAVE_FILE_LOADED)


#func _process(delta: float) -> void:
	#if scene_path == "":
		#return
	#
	#var progress : Array
	#ResourceLoader.load_threaded_get_status(scene_path, progress)
	#
	#EventBus.push_event(GameEvents.UI_PROGRESS_CHANGED, progress[0])
	#if progress[0] >= 1:
		#scene_path = ""
