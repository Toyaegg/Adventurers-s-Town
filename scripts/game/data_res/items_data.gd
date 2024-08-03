class_name Item
extends Resource

enum ItemType{
	Sundries,
	Impoert,
}

var id : int
var display_name : String
var type : ItemType
var icon : Texture
