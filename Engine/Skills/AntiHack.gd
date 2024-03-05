extends Skill
class_name SkillAntiHack

func _init():
	name = "Anti-Hack"
	description = "SKILL_ANTI_HACK_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	query.get_my_team()\
		.iterator()\
		.filter(Filters.tag("cyborg"))\
		.for_each(func(battle_unit): 
			var value = max(1, unit.def * 10 / 100)
			result.push_back(LogDefAdd.new(battle_unit, value))\
		)
	
	return result
