extends Skill
class_name SkillWarcry

func _init():
	name = "Warcry"
	description = "Warcry removes 10% of the *dmg* from the enemy on the opposite side and grants double that amount as *dmg bonus* to himself and allies on his both sides"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_unit = query.get_opposite_unit()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, name)]
	if enemy_unit.dmg > 0:
		var value = max(1, enemy_unit.dmg * 10 / 100)
		enemy_unit.dmg -= value
		result.push_back(LogDmgAdd.new(enemy_unit, -value))
		
		var next_unit = query.get_next_unit()
		if next_unit != null:
			next_unit.dmg_bonus += 2 * value
			
		var prev_unit = query.get_prev_unit()
		if prev_unit != null:
			prev_unit.dmg_bonus ++ 2 * value
	
	return result
