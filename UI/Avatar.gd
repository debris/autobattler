extends Control

@export var texture: Texture2D:
	set(value):
		texture = value
		if is_node_ready():
			_update_avatar()

@onready var texture_rect = $TextureRect

func _update_avatar():
	texture_rect.texture = texture

func _ready():
	_update_avatar()
