class_name ShopSystem
extends Node




func _ready() -> void:
	EventBus.subscribe(GameEvents.ADVENTURER_SELLING, sell_items)
	EventBus.subscribe(GameEvents.ADVENTURER_SHOPPING, shopping)

	print("ShopSystem ready")



func sell_items(user :Adventurer) -> void:
	var slots = user.sell_items()
	if slots.size() > 0:
		for slot : ItemSlot in slots:
			var gold = slot.item.price * slot.count
			print("[%s]卖掉[%d]个[%s]，获得[%d]金币" % [user.display_name, slot.count, slot.item.display_name, gold])
			slot.item = null
			slot.count = 0
			user.add_gold(gold)
		user.inventory.store_items()


func shopping(user : Adventurer) -> void:
	if user.wallet.gold >= user.target_equipment.price:
		user.buy_equipment(user.target_equipment)
		print("[%s]购买1个[%s]，花费[%d]金币" % [user.display_name, user.target_equipment.display_name, user.target_equipment.price])
		user.add_gold(-user.target_equipment.price)
	if user.wallet.gold >= user.target_potion.price:
		user.buy_potion(user.target_potion)
		print("[%s]购买1个[%s]，花费[%d]金币" % [user.display_name, user.target_potion.display_name, user.target_potion.price])
		user.add_gold(-user.target_potion.price)


func get_random_equipment() -> EquipmentData:
	var imax = GameManager.shop_model.equipments.size()
	var index = 500 + randi_range(1, imax)
	return GameManager.shop_model.equipments[index]
	
func get_random_potion() -> PotionData:
	var imax = GameManager.shop_model.potions.size()
	var index = 200 + randi_range(1, imax)
	return GameManager.shop_model.potions[index]
