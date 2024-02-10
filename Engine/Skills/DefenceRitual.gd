extends Skill
class_name SkillDefenceRitual

func _init():
	name = "Defence Ritual"
	description = "Increase *defence* of all orcs in the team by 10%."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var orc_iterator = ArrayIterator.new(team.members).map(func(battle_unit): return battle_unit.tags.has("orc"))
	var orc_unit = orc_iterator.next()
	while orc_unit:
		var value = max(1, orc_unit.def * 10 / 100)
		result.push_back(LogDefAdd.new(orc_unit, value))
		orc_unit = orc_iterator.next()
	return result
