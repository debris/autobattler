extends Control

signal selected

@export var text: String:
	set(value):
		text = value
		if is_node_ready():
			update_display()

@export var utc_time: String:
	set(value):
		utc_time = value
		if is_node_ready():
			update_display()

@export var avatar: Avatar:
	set(value):
		avatar = value
		if is_node_ready():
			update_display()

@onready var name_label = $NameLabel
@onready var date_label = $DateLabel
@onready var on_hover = $OnHover
@onready var on_select = $OnSelect
@onready var avatar_icon = $AvatarIcon

func _ready():
	update_display()
	
	mouse_entered.connect(func():
		Sounds.play_hover()
		on_hover.visible = true
	)
	
	mouse_exited.connect(func():
		on_hover.visible = false
	)

func update_display():
	name_label.text = text
	# TODO: convert utc time to local time
	# TODO: pretty print
	date_label.text = utc_time

	# Avatar added post 0.6, so some savefiles do not have this property
	avatar_icon.texture = avatar.texture

func _gui_input(event):
	if event.is_action_pressed("LeftClick"):
		if on_hover.visible:
			Sounds.play_button_press()
			mark_selected()
			accept_event()
		
func mark_selected():
	on_select.visible = true
	selected.emit()

func mark_unselected():
	on_select.visible = false