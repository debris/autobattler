extends Skill
class_name SkillUnionize

func _init():
	name = "Unionize"
	description = "SKILL_UNIONIZE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var my_team = query.get_my_team()
	var unit_to_unionize_a = my_team.members[query.get_round() % my_team.members.size()]
	if unit_to_unionize_a != null:
		result.push_back(LogSetSchedules.new(unit_to_unionize_a, unit.schedules))

	var enemy_team = query.get_enemy_team()
	var unit_to_unionize_b = enemy_team.members[query.get_round() % enemy_team.members.size()]
	if unit_to_unionize_b != null:
		result.push_back(LogSetSchedules.new(unit_to_unionize_b, unit.schedules))

	return result
