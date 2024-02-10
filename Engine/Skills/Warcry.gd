extends Skill
class_name SkillWarcry

func _init():
	name = "Warcry"
	description = "Warcry removes 20% of the *dmg* from the enemy on the opposite side and grants double that amount as *dmg bonus* to himself and allies on his both sides"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_unit_option = query.get_opposite_unit().filter(func(u): return u.dmg > 0)
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	
	enemy_unit_option.for_each(func(enemy_unit): 
		var value = max(1, enemy_unit.dmg * 20 / 100)
		result.push_back(LogDmgAdd.new(enemy_unit, -value))
		
		var double_value = 2 * value
		result.push_back(LogDmgBonusAdd.new(unit, double_value))

		query.get_next_units()\
			.first()\
			.concat(query.get_prev_units().first())\
			.for_each(func(next_unit):\
				result.push_back(LogDmgBonusAdd.new(next_unit, double_value))
		)
	)
	
	return result
