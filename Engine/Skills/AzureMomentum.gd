extends Skill
class_name SkillAzureMomentum

func _init():
	name = "Azure Momentum"
	description = "Grants *bonus skill cast* to the next two creatures if they also cast spell this round."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, name)]
	
	var next_unit = query.get_next_unit()
	if next_unit != null:
		if next_unit.unit.skill_schedule.at(query.get_round()):
			next_unit.skill_bonus_casts += 1
			result.push_back(LogSkillCastBonus.new(unit, 1))
	
		next_unit = query.with_root(next_unit).get_next_unit()
		if next_unit != null && next_unit.unit.skill_schedule.at(query.get_round()):
			next_unit.skill_bonus_casts += 1
			result.push_back(LogSkillCastBonus.new(unit, 1))

	return result
