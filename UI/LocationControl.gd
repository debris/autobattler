extends Control

signal selected_location

@export var location: Location
@export var map_position: Vector2i
@export var map: Map

@onready var content = $Content
@onready var name_label = $Content/NameLabel
@onready var icon = $Content/Icon
@onready var possible_control = $Content/PossibleControl
@onready var current_control = $Content/CurrentControl

var hovered = false

func _ready():
	content.visible = !location is LocationEmpty
	icon.texture = location.icon
	name_label.text = location.name
	current_control.visible = map.map_position == map_position
	
	content.mouse_filter = MOUSE_FILTER_IGNORE
	for child in content.get_children():
		if "mouse_filter" in child:
			child.mouse_filter = MOUSE_FILTER_IGNORE
	
	if !location is LocationEmpty:
		mouse_entered.connect(func():
			if map.is_valid_destination(map_position):
				possible_control.visible = true
				hovered = true
				Sounds.play_hover()
		)
		mouse_exited.connect(func():
			possible_control.visible = false
		)

func _gui_input(event):
	if hovered && event.is_action_pressed("LeftClick"):
		map.map_position = map_position
		selected_location.emit()
