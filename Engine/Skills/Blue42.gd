extends Skill
class_name SkillBlue42

func _init():
	name = "Blue 42"
	description = "Increase *defence* by 10% for every other defender on the team."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var multipliers = team.iterator()\
		.count(Filters.tag("defender"))
	
	if unit.tags.has("defender"):
		multipliers -= 1

	if multipliers != 0:
		var value = multipliers * unit.def * 10 / 100
		result.push_back(LogDefAdd.new(unit, value))

	return result
