extends Control

@onready var unit_control = $ScrollContainer/GridContainer/Unit/UnitControl

func _ready():
	var help_unit = UnitCaptainBlaze.new()
	var schedules: Array[Schedule] = [
		Schedule.new(),
		Schedule.new(),
		Schedule.new()
	]
	schedules[0].kind = Schedule.Kind.SKILL
	schedules[0].data = [true, false, false] as Array[bool]
	schedules[1].kind = Schedule.Kind.DEF
	schedules[1].data = [false, true, false, false, true] as Array[bool]
	schedules[2].kind = Schedule.Kind.DMG
	schedules[2].data = [false, false, false, false, false, true, true, true] as Array[bool]
	var owned_unit = OwnedUnit.new(help_unit, schedules)
	unit_control.unit = owned_unit

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()
