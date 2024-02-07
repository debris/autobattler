# Unit type that exists only during battles
# keeps temporarily state of the owned unit
extends Resource
class_name BattleUnit

var unit: OwnedUnit
var texture: Texture2D
var dmg: int
var def: int
var skill: Skill
var schedules: Array[Schedule]
var schedule_pointer: SchedulePointer
# bonus dmg is set to zero once it's used
var dmg_bonus: int
# bonus def is set to zero once it's used
var def_bonus: int
# bonus skills indicate how many extra times unit can use his skill this round
var skill_bonus_casts: int
# hashset with all battle tags
var tags: Dictionary
# indicates whether units action should trigger exhaustion dmg
var exhausted: bool

func _init(u: OwnedUnit):
	unit = u
	texture = u.base.texture
	dmg = u.dmg
	def = u.def
	skill = u.skill
	
	# we may need a deep copy here if there are cards that modify the schedule
	# during the battle
	schedules = []
	for i in u.schedules:
		schedules.push_back(i)
	schedule_pointer = SchedulePointer.new()
	dmg_bonus = 0
	def_bonus = 0
	skill_bonus_casts = 0
	
	tags = {}
	for tag in u.base.tags:
		tags[tag] = null

	exhausted = false

func swap_with(other: BattleUnit):
	var tmp = inst_to_dict(self)
	var tmp2 = inst_to_dict(other)
	
	var copy_fields = func(battle_unit: BattleUnit, fields):
		for key in fields.keys():
			if !key.begins_with("@"):
				battle_unit[key] = fields[key]

	copy_fields.call(self, tmp2)
	copy_fields.call(other, tmp)

func skill_at(phase: int) -> Skill:
	assert(phase >= 0 && phase <= 2, "there are only 3 phases")
	match schedules[phase].kind:
		Schedule.Kind.SKILL: return skill
		Schedule.Kind.DEF: return SkillDefend.new()
		Schedule.Kind.DMG: return SkillAttack.new()
	assert(false)
	return null
