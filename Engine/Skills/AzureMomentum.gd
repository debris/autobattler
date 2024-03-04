extends Skill
class_name SkillAzureMomentum

func _init():
	name = "Azure Momentum"
	description = "SKILL_AZURE_MOMENTUM_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]

	query.get_next_units()\
		.limit(2)\
		.filter(Filters.phase_skill(query))\
		.for_each(func(battle_unit):
			result.push_back(LogSkillCastBonus.new(battle_unit, 2))\
		)

	return result
