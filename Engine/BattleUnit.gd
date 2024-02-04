# Unit type that exists only during battles
# keeps temporarily state of the owned unit
extends Resource
class_name BattleUnit

var unit: OwnedUnit
var texture: Texture2D
var dmg: int
var def: int
var skill: Skill
var dmg_schedule_pointer: SchedulePointer
var def_schedule_pointer: SchedulePointer
var skill_schedule_pointer: SchedulePointer

# bonus dmg is set to zero once it's used
var dmg_bonus: int
# bonus def is set to zero once it's used
var def_bonus: int
var skill_bonus_casts: int
# hashset with all battle tags
var tags: Dictionary

func _init(u: OwnedUnit):
	unit = u
	texture = u.base.texture
	dmg = u.dmg
	def = u.def
	skill = u.skill
	dmg_schedule_pointer = SchedulePointer.new()
	def_schedule_pointer = SchedulePointer.new()
	skill_schedule_pointer = SchedulePointer.new()
	dmg_bonus = 0
	def_bonus = 0
	skill_bonus_casts = 0
	
	tags = {}
	for tag in u.base.tags:
		tags[tag] = null

func swap_with(other: BattleUnit):
	var tmp = inst_to_dict(self)
	var tmp2 = inst_to_dict(other)
	
	var copy_fields = func(unit: BattleUnit, fields):
		for key in fields.keys():
			if !key.begins_with("@"):
				unit[key] = fields[key]

	copy_fields.call(self, tmp2)
	copy_fields.call(other, tmp)

# 0, 1, 2
func skill_at(phase: int) -> Skill:
	if phase == 0:
		return skill
	elif phase == 1:
		return SkillDefend.new()
	elif phase == 2:
		return SkillAttack.new()
		
	assert("logic error, we should never get here")
	return Skill.new()
		

func schedule(phase: int) -> Schedule:
	if phase == 0:
		return unit.skill_schedule
	elif phase == 1:
		return unit.def_schedule
	elif phase == 2:
		return unit.dmg_schedule
	
	assert("logic error, we should never get here")
	return Schedule.new()

func schedule_pointer(phase: int) -> SchedulePointer:
	if phase == 0:
		return skill_schedule_pointer
	if phase == 1:
		return def_schedule_pointer
	elif phase == 2:
		return dmg_schedule_pointer

	assert("logic error, we should never be here")
	return SchedulePointer.new()
