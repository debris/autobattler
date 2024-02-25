# Control capable of displaying all unit types: `Unit`, `OwnedUnit` and `BattleUnit`
extends Control

signal pressed(unit)

@export var unit: Resource:
	set(value):
		unit = value
		if is_node_ready():
			display_unit()

@onready var on_hover = $OnHover
@onready var content = $Content
@onready var name_label = $Content/Name
@onready var avatar = $Content/Avatar
@onready var dmg_label = $Content/Dmg
@onready var def_label = $Content/Def
@onready var schedules = $Content/Schedules
@onready var tiers = $Content/Tiers

func display_unit():
	if unit == null:
		content.visible = false
		on_hover.visible = false
		return

	content.visible = true
	name_label.text = unit.name
	avatar.texture = unit.texture
	dmg_label.text = str(unit.dmg)
	def_label.text = str(unit.def)
	
	var schedule_controls = schedules.get_children()
	for i in 3:
		schedule_controls[i].schedule = unit.schedules[i]
	tiers.schedules = unit.schedules

func _ready():
	display_unit()
	mouse_entered.connect(func():
		if content.visible && pressed.get_connections().size() > 0:
			on_hover.visible = true
			Sounds.play_hover()
	)

	mouse_exited.connect(func():
		on_hover.visible = false
	)

func _gui_input(event):
	if on_hover.visible && event.is_action_pressed("LeftClick"):
		pressed.emit(unit)
