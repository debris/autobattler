extends Skill
class_name SkillAzureMomentum

func _init():
	name = "Azure Momentum"
	description = "Grants *bonus skill activations* to the next two creatures if they also activate skill this phase."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]

	query.get_next_units().limit(2).filter(func(battle_unit):
		var schedule = battle_unit.schedules[query.get_phase()]
		return schedule.is_skill() && schedule.at(query.get_round())
	).for_each(func(battle_unit):
		result.push_back(LogSkillCastBonus.new(battle_unit, 1))
	)

	return result
