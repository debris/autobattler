extends Skill
class_name SkillMimicry

func _init():
	name = "Mimicry"
	description = "SKILL_MIMICRY_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_team = query.get_enemy_team()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var log_of_last_skill = query.get_reverse_all_logs_iterator()\
		.filter(func(log_to_check): return log_to_check is LogSkillUsed)\
		.filter(func(log_to_check): return !log_to_check.skill is SkillMimicry)\
		.find(func(log_to_check):
			var other_query = BattleQuery.new(log_to_check.unit, query.battle_state)
			var enemy_team2 = other_query.get_my_team()
			return enemy_team.get_instance_id() == enemy_team2.get_instance_id()\
		)

	if log_of_last_skill.is_some():
		var the_skill = log_of_last_skill.get_value().skill
		result.append(LogSkillScheduled.new(unit, the_skill))
	return result
