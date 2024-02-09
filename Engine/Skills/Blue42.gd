extends Skill
class_name SkillBlue42

func _init():
	name = "Blue 42"
	description = "Increase *defence* by 10% for every other defender on the team."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var multipliers = 0
	for battle_unit in team.members:
		if battle_unit != null && battle_unit.get_instance_id() != unit.get_instance_id() && battle_unit.tags.has("defender"):
			multipliers += 1
	
	if multipliers != 0:
		var value = multipliers * unit.dmg * 10 / 100
		result.push_back(LogDefAdd.new(unit, value))
	
		
	return result
