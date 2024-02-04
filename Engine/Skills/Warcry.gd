extends Skill
class_name SkillWarcry

func _init():
	name = "Warcry"
	description = "Warcry removes 10% of the *dmg* from the enemy on the opposite side and grants double that amount as *dmg bonus* to himself and allies on his both sides"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_unit = query.get_opposite_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	if enemy_unit.dmg > 0:
		var value = max(1, enemy_unit.dmg * 10 / 100)
		result.push_back(LogDmgAdd.new(enemy_unit, -value))
		
		var double_value = value
		result.push_back(LogDmgAdd.new(unit, double_value))

		var next_unit = query.get_next_unit()
		if next_unit != null:
			result.push_back(LogDmgBonusAdd.new(next_unit, double_value))
			
		var prev_unit = query.get_prev_unit()
		if prev_unit != null:
			result.push_back(LogDmgBonusAdd.new(prev_unit, double_value))
	
	return result
