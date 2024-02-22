extends Control

signal selected

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()

@onready var on_hover = $OnHover
@onready var name_label = $NameLabel
@onready var schedule_control = $GridContainer/ScheduleControl
@onready var schedule_control2 = $GridContainer/ScheduleControl2
@onready var schedule_control3 = $GridContainer/ScheduleControl3

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
	name_label.text = unit.name
	schedule_control.schedule = unit.schedules[0]
	schedule_control2.schedule = unit.schedules[1]
	schedule_control3.schedule = unit.schedules[2]

func _on_select_pressed():
	selected.emit()
