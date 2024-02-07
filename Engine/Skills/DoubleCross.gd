extends Skill
class_name SkillDoubleCross

func _init():
	name = "Double Cross"
	description = "Swap places with the enemy unit with the highest defence"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_team = query.get_enemy_team()
	var enemy_unit_to_swap = enemy_team.members[0]
	for i in enemy_team.members.size() - 1:
		var enemy_unit = enemy_team.members[i + 1]
		if enemy_unit_to_swap == null || (enemy_unit != null && (enemy_unit.def > enemy_unit_to_swap.def)):
			enemy_unit_to_swap = enemy_unit
	
	return [LogSkillUsed.new(unit, self), LogSwapPlaces.new(unit, enemy_unit_to_swap)]
