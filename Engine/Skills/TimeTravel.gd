# Modifes the round number
extends Skill
class_name SkillTimeTravel

func _init():
	name = "Time Travel"
	description = "If this units offense is higher than defense, increase the round counter by 1, if it's lower, decrease by 1. If they are the same, do nothing."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	if unit.dmg > unit.def:
		result.push_back(LogRoundAdd.new(unit, 1))
	elif unit.def > unit.dmg:
		result.push_back(LogRoundAdd.new(unit, -1))
	return result
