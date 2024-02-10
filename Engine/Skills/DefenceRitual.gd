extends Skill
class_name SkillDefenceRitual

func _init():
	name = "Defence Ritual"
	description = "Increase *defence* of all orcs in the team by 10%."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	ArrayIterator.new(team.members)\
		.filter(func(battle_unit): return battle_unit.tags.has("orc"))\
		.for_each(func(battle_unit): 
			var value = max(1, battle_unit.def * 10 / 100)
			result.push_back(LogDefAdd.new(battle_unit, value))\
		)
	
	return result
