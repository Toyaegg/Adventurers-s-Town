extends CustomSortList

func _ready() -> void:
	super()
	visibility_changed.connect(refresh_list)
	refresh_list()
	EventBus.subscribe(GameEvents.BUILD_BUILDING_COMPLETE, build_complete)

func refresh_list() -> void:
	var buildings : Array[Building] = GameManager.town_model.get_buildings()
	refresh_data(buildings)

func build_complete(_b) -> void:
	refresh_list()
