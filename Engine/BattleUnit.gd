# Unit type that exists only during battles
# keeps temporarily state of the owned unit
extends Resource
class_name BattleUnit

var unit: OwnedUnit
var dmg: int
var def: int
var dmg_schedule_pointer: SchedulePointer
var def_schedule_pointer: SchedulePointer
var skill_schedule_pointer: SchedulePointer
var logs: Array[Action]

func _init(u: OwnedUnit):
	unit = u
	dmg = u.dmg
	def = u.def
	dmg_schedule_pointer = SchedulePointer.new()
	def_schedule_pointer = SchedulePointer.new()
	skill_schedule_pointer = SchedulePointer.new()
	logs = []
