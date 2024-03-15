# Unit type that exists only during battles
# keeps temporarily state of the owned unit
extends Resource
class_name BattleUnit

var unit: OwnedUnit
var name: String
var texture: Texture2D
var dmg: int
var def: int
var abilities: Array[Ability]
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
# memorized team_level
var team_level: int
# empowered
var empowered: int

func increase_by_x_percent(value: float, x: float):
	return value * (1.0 + x / 100.0)

func _init(u: OwnedUnit, tl: int = 0):
	team_level = tl
	unit = u
	name = u.base.name
	texture = u.base.texture
	empowered = u.empowered
	var multiplier = team_level + u.empowered
	dmg = int(increase_by_x_percent(u.dmg, multiplier * 10.0))
	def = int(increase_by_x_percent(u.def, multiplier * 10.0))
	abilities = []
	abilities.assign(u.abilities)
	
	# we may need a deep copy here if there are cards that modify the schedule
	# during the battle
	schedules = []
	for i in u.schedules:
		schedules.push_back(i.copy())
	schedule_pointer = SchedulePointer.new()
	dmg_bonus = 0
	def_bonus = 0
	skill_bonus_casts = 0
	
	tags = {}
	for tag in u.tags.keys():
		tags[tag] = null

func turn_into(other: BattleUnit):	
	var copy_fields = func(battle_unit: BattleUnit, fields):
		for key in fields.keys():
			if !key.begins_with("@"):
				battle_unit[key] = fields[key]

	var tmp = inst_to_dict(other)
	copy_fields.call(self, tmp)

func skills_at(phase: int) -> Array[Skill]:
	assert(phase >= 0 && phase <= 2, "there are only 3 phases")
	match schedules[phase].kind:
		Schedule.Kind.SKILL:
			var result: Array[Skill] = []
			result.assign(abilities.filter(func(ability): return ability is Skill))
			return result
		Schedule.Kind.DEF: return [SkillDefend.new()]
		Schedule.Kind.DMG: return [SkillAttack.new()]
	assert(false)
	return []

func damage_per_round() -> float:
	var phase = 0
	while schedules[phase].kind != Schedule.Kind.DMG:
		phase += 1

	return schedules[phase].frequency() * dmg

func defense_per_round() -> float:
	var phase = 0
	while schedules[phase].kind != Schedule.Kind.DEF:
		phase += 1

	return schedules[phase].frequency() * def
