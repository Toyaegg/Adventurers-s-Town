extends Node2D

@export var camera_move_speed : float

func _process(delta : float) -> void:
	if Input.is_action_pressed("camera_move_left"):
		#print("left")
		position.x -= (camera_move_speed * delta)
	if Input.is_action_pressed("camera_move_right"):
		#print("right")
		position.x += (camera_move_speed * delta)
