extends CustomSortList

func _ready() -> void:
	super()
	visibility_changed.connect(refresh_list)
	refresh_list()

func refresh_list() -> void:
	var adventurers : Array[Adventurer] = GameManager.adventurer_model.get_adventurers()
	refresh_data(adventurers)


func filter_list(tag : int) -> void:
	var adventurers : Array[Adventurer] = GameManager.adventurer_model.get_adventurers().filter(func(adv : Adventurer): 
		return adv.tier == tag
		)
	refresh_data(adventurers)
