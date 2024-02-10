extends Skill
class_name SkillAzureMomentum

func _init():
	name = "Azure Momentum"
	description = "Grants *bonus skill activations* to the next two creatures if they also activate skill this phase."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]

	query.get_next_units()\
		.limit(2)\
		.filter(Filters.phase_skill(query))\
		.for_each(func(battle_unit):
			result.push_back(LogSkillCastBonus.new(battle_unit, 1))\
		)

	return result
