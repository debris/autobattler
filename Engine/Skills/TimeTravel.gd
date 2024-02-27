# Modifes the round number
extends Skill
class_name SkillTimeTravel

func _init():
	name = "Time Travel"
	description = "SKILL_TIME_TRAVEL_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	if unit.dmg > unit.def:
		result.push_back(LogRoundAdd.new(unit, 1))
	elif unit.def > unit.dmg:
		result.push_back(LogRoundAdd.new(unit, -1))
	return result
