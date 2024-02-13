extends Skill
class_name SkillSelfcare

func _init():
	name = "Self-Care"
	description = "50% of bonuses converts into pernament improvements."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()

	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	if unit.dmg_bonus > 0:
		var value = unit.dmg_bonus / 2
		result.push_back(LogDmgBonusAdd.new(unit, unit.dmg_bonus))
		result.push_back(LogDmgAdd.new(unit, value))

	if unit.def_bonus > 0:
		var value = unit.def_bonus / 2
		result.push_back(LogDefBonusAdd.new(unit, unit.def_bonus))
		result.push_back(LogDefAdd.new(unit, value))

	return result
