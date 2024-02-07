extends Skill
class_name SkillShapeshift

func _init():
	name = "Shapeshift"
	description = "Copy looks and attributes of another character. On odd rounds character with the highest attack and on even with the highest defence. If no such character exists, do nothing."

func _execute(query: BattleQuery) -> Array[Log]:
	var battle_unit = query.get_this_unit()
	var target = battle_unit
	var all_units = query.get_all_units()

	if query.get_round() % 2 == 0:
		for unit in all_units:
			if unit != null && (unit.def > target.def):
				target = unit
	else:
		for unit in all_units:
			if unit != null && (unit.dmg > target.dmg):
				target = unit
	
	if battle_unit.get_instance_id() == target.get_instance_id():
		return []

	return [LogSkillUsed.new(battle_unit, self), LogShapeshift.new(battle_unit, target)]
