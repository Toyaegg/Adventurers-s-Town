extends CustomSortList

func _ready() -> void:
	super()
	visibility_changed.connect(refresh_list)
	refresh_list()

func refresh_list() -> void:
	var buildings : Array[Building] = GameManager.town_model.get_buildings()
	#var buildings : Array[Building]
	#for building in b:
		#buildings.append(building)
	refresh_data(buildings)
