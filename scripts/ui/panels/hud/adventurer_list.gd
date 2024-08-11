extends CustomSortList

func _ready() -> void:
	super()
	visibility_changed.connect(refresh_list)
	refresh_list()
	EventBus.subscribe(GameEvents.ADVENTURER_CREATED, adv_created)

func refresh_list() -> void:
	var adventurers : Array[Adventurer] = GameManager.adventurer_model.get_adventurers()
	refresh_data(adventurers)

func adv_created(_adv) -> void:
	refresh_list()

func filter_list(tag : int) -> void:
	print("只显示", (tag as Adventurer.Tier))
	var adventurers : Array[Adventurer] = GameManager.adventurer_model.get_adventurers().filter(func(adv : Adventurer):
		return adv.tier == (tag as Adventurer.Tier)
		)
	refresh_data(adventurers)
