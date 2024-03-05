extends Skill
class_name SkillDivineBlessing

func _init():
	name = "Divine Blessing"
	description = "SKILL_DIVINE_BLESSING_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var my_team = query.get_my_team()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]

	var gods_count = query.get_all_units()\
		.filter(Filters.tag("god"))\
		.count()

	var value = max(1, my_team.power * gods_count * 10 / 100)
	result.push_back(LogPower.new(unit, my_team, value))

	return result
