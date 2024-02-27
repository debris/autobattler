extends Control

signal selected_location

@export var location: Location
@export var map_position: Vector2i
@export var map: Map
@export var display_icon: bool = true

@onready var content = $Content
@onready var icon = $Content/Icon
@onready var name_label = $Content/NameLabel
@onready var possible_control = $Content/PossibleControl
@onready var current_control = $Content/CurrentControl
@onready var inactive_control = $Content/InactiveControl

var hovered = false

func _ready():
	content.visible = !location is LocationEmpty
	if location.icon != null:
		icon.texture = location.icon
	else:
		icon.visible = false
	name_label.text = location.name
	current_control.visible = map.map_position == map_position
	
	content.mouse_filter = MOUSE_FILTER_IGNORE
	for child in content.get_children():
		if "mouse_filter" in child:
			child.mouse_filter = MOUSE_FILTER_IGNORE

	if map.is_valid_destination(map_position):
		mouse_entered.connect(func():
			z_index = 1
			content.scale = Vector2(1.2, 1.2)
			possible_control.visible = true
			hovered = true
			Sounds.play_hover()
		)
		mouse_exited.connect(func():
			z_index = 0
			content.scale = Vector2(1.0, 1.0)
			possible_control.visible = false
			hovered = false
		)
	else:
		# make inactive contol visible for everyone not on the path except current location
		inactive_control.visible = !map.map_position == map_position

func _gui_input(event):
	if hovered && event.is_action_pressed("LeftClick"):
		accept_event()
		map.map_position = map_position
		selected_location.emit()
