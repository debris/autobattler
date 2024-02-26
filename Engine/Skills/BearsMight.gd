extends Skill
class_name SkillBearsMight

func _init():
	name = "Bear's Might"
	description = "SKILL_BEARS_MIGHT_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	
	query.get_next_units()\
		.first()\
		.filter(Filters.phase_defence(query))\
		.for_each(func(battle_unit):
			result.push_back(LogDefBonusAdd.new(battle_unit, unit.def))\
		)

	return result
