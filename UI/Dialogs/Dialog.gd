extends Resource
class_name Dialog

@export var avatar: Texture2D
@export var chapters: Array[String]

func _init():
	avatar = null
	chapters = []
