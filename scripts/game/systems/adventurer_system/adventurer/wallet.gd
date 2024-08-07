class_name Wallet
extends Node

var gold : int:
	set(v):
		gold = v
		EventBus.push_event(GameEvents.ADVENTURER_GOLD_CHANGED, gold)
