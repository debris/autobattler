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

@onready var name_label = $NameLabel
@onready var date_label = $DateLabel
@onready var on_hover = $OnHover

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

func _gui_input(event):
	if event.is_action_pressed("LeftClick"):
		if on_hover.visible:
			selected.emit()
			accept_event()
		
