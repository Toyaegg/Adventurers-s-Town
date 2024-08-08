class_name Visitors
extends Node


var users : Array[Adventurer]
@export var max_user_count : int

func enter(user : Adventurer) -> void:
	if not users.has(user):
		users.insert(0, user)
		print(users[users.size() - 1].display_name)

func exit(user : Adventurer) -> void:
	if users.has(user):
		print(users[users.size() - 1].display_name)
		users.erase(user)

func has_user(user : Adventurer) -> bool:
	var result : bool = users.has(user)
	#print("visitor ",result)
	return result

#func use(user : Adventurer, f : Feature) -> bool:
	#return false

func has_empty() -> bool:
	return users.size() < max_user_count
