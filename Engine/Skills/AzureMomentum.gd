extends Skill
class_name SkillAzureMomentum

func _init():
	name = "Azure Momentum"
	description = "Grants *bonus skill cast* to the next two creatures if they also use skill this round."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	
	var next_unit = query.get_next_unit()
	if next_unit != null:
		var schedule = next_unit.schedules[query.get_phase()]
		if schedule.kind == Schedule.Kind.SKILL && schedule.at(query.get_round()):
			result.push_back(LogSkillCastBonus.new(next_unit, 1))
	
		next_unit = query.with_root(next_unit).get_next_unit()
		if next_unit != null:
				schedule = next_unit.schedules[query.get_phase()]
				if schedule.kind == Schedule.Kind.SKILL && schedule.at(query.get_round()):
					result.push_back(LogSkillCastBonus.new(next_unit, 1))

	return result
