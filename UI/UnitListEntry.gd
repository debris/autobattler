extends Control

signal selected

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()

@export var selectable: bool:
	set(value):
		selectable = value
		if is_node_ready():
			update_selectable()

@onready var on_hover = $OnHover
@onready var name_label = $NameLabel
@onready var schedule_control = $GridContainer/ScheduleControl
@onready var schedule_control2 = $GridContainer/ScheduleControl2
@onready var schedule_control3 = $GridContainer/ScheduleControl3
@onready var select_label = $SelectLabel
@onready var tiers = $Tiers

func _ready():
	update_display()
	update_selectable()
	
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
	tiers.schedules = unit.schedules

func update_selectable():
	select_label.visible = selectable

func _gui_input(event):
	if on_hover.visible == true && (event.is_action_pressed("ui_accept") || event.is_action_pressed("LeftClick")):
		selected.emit()
