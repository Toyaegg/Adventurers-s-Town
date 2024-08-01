extends CustomSortList

func _ready() -> void:
	super()
	visibility_changed.connect(refresh_list)
	refresh_list()

func refresh_list() -> void:
	var buildings : Array[Building] = GameManager.town_model.get_buildings()
	refresh_data(buildings)
