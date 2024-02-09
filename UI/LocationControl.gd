extends Control

@export var location: Location
@export var map_position: Vector2i

@onready var content = $Content
@onready var name_label = $Content/NameLabel
@onready var icon = $Content/Icon
@onready var possible_control = $Content/PossibleControl

func _ready():
	content.visible = !location is LocationEmpty
	icon.texture = location.icon
	name_label.text = location.name
	
	content.mouse_filter = MOUSE_FILTER_IGNORE
	for child in content.get_children():
		if "mouse_filter" in child:
			child.mouse_filter = MOUSE_FILTER_IGNORE
	
	if !location is LocationEmpty:
		mouse_entered.connect(func():
			possible_control.visible = true
			Sounds.play_hover()
		)
		mouse_exited.connect(func():
			possible_control.visible = false
		)
