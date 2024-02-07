extends Skill
class_name SkillArcherTraining

func _init():
	name = "Archer Training"
	description = "Increase *damage* by 10% for every other archer on the team."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var multipliers = 0
	for battle_unit in team.members:
		if battle_unit != null && battle_unit.get_instance_id() != unit.get_instance_id() && battle_unit.tags.has("archer"):
			multipliers += 1
	
	if multipliers != 0:
		var value = multipliers * unit.dmg * 10 / 100
		result.push_back(LogDmgAdd.new(unit, value))
	
		
	return result
