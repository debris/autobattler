extends Skill
class_name SkillShapeshift

func _init():
	name = "Shapeshift"
	description = "Copy looks and attributes of another character. On odd rounds character with the highest attack and on even with the highest defence. If no such character exists, do nothing."

func _execute(query: BattleQuery) -> Array[Log]:
	var battle_unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(battle_unit, self)]
	
	var compare = null
	if query.get_round() % 2 == 0:
		compare = Compare.highest_def
	else:
		compare = Compare.highest_dmg

	var target = query.get_all_units().compare(compare)
	if battle_unit.get_instance_id() != target.get_instance_id():
		result.push_back(LogShapeshift.new(battle_unit, target))
	
	return result
