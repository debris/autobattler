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

# bonus dmg is set to zero once it's used
var dmg_bonus: int
# bonus def is set to zero once it's used
var def_bonus: int

var skill_bonus_casts: int

func _init(u: OwnedUnit):
	unit = u
	dmg = u.dmg
	def = u.def
	dmg_schedule_pointer = SchedulePointer.new()
	def_schedule_pointer = SchedulePointer.new()
	skill_schedule_pointer = SchedulePointer.new()
	dmg_bonus = 0
	def_bonus = 0
	skill_bonus_casts = 0
