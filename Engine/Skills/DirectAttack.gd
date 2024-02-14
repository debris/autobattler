extends Skill
class_name SkillDirectAttack

func _init():
	name = "Direct Attack"
	description = "Direct units on both sides to attack the enemy."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	
	var prev_unit = query.get_prev_units().first()
	if prev_unit.is_some():
		result.push_back(LogSkillScheduled.new(prev_unit.get_value(), SkillAttack.new()))
	
	var next_unit = query.get_next_units().first()
	if next_unit.is_some():
		result.push_back(LogSkillScheduled.new(next_unit.get_value(), SkillAttack.new()))
	
	return result
