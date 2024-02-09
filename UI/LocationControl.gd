extends Control

@export var location: Location
@export var map_position: Vector2i

@onready var content = $Content
@onready var name_label = $Content/NameLabel
@onready var icon = $Content/Icon

func _ready():
	content.visible = !location is LocationEmpty
	icon.texture = location.icon
	name_label.text = location.name
	
