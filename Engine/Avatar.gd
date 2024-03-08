extends Resource
class_name Avatar

var name: String
var texture: Texture2D
var bio: String
var ability: String
var starting_units: Array[OwnedUnit]

func _init():
	name = ""
	texture = null
	bio = ""
	ability = ""
	starting_units = []