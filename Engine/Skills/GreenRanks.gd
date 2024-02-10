extends Skill
class_name SkillGreenRanks

func _init():
	name = "Green Ranks"
	description = "Add 'orc' tag to the first unit that doesn't have it. Start with enemy team."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var not_orc = query.get_enemy_team()\
		.iterator()\
		.concat(query.get_my_team().iterator())\
		.find(Filters.no_tag("orc"))\
		.get_value()

	if not_orc != null:
		result.push_back(LogTagAdd.new(not_orc, "orc"))

	return result
