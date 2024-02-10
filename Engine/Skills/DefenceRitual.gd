extends Skill
class_name SkillDefenceRitual

func _init():
	name = "Defence Ritual"
	description = "Increase *defence* of all other orcs in the team by 10%."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	query.get_my_team()\
		.iterator()\
		.filter(Filters.tag("orc"))\
		.filter(Filters.not_this_unit(unit))\
		.for_each(func(battle_unit): 
			var value = max(1, battle_unit.def * 10 / 100)
			result.push_back(LogDefAdd.new(battle_unit, value))\
		)
	
	return result
