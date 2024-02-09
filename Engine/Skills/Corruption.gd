extends Skill
class_name SkillCorruption

func _init():
	name = "Corruption"
	description = "Decrease opponent's *defense* by 20%."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var opposite_unit = query.get_opposite_unit()
	if opposite_unit != null:
		var value = opposite_unit.def * 20 / 100
		result.push_back(LogDefAdd.new(opposite_unit, -value))
	return result