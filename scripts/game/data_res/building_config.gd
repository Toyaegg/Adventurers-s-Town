class_name BuildingConfig
extends Resource

@export var id : StringName
@export var display_name : String
@export_multiline var description : String
@export var feature : Array[BuildingFeature]
@export var icon : Texture
@export var exp_per_level : Array[int]
@export var max_member_per_level : Array[int]
@export var max_level : int
@export var resource_need : Array[Array]
@export var only_one : bool = true
