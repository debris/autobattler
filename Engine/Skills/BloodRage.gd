extends Skill
class_name SkillBloodRage

func _init():
	name = "Blood Rage"
	description = "SKILL_BLOOD_RAGE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var value = unit.dmg * 20 / 100
	return [LogSkillUsed.new(unit, self), LogDmgAdd.new(unit, value)]
