extends Skill
class_name SkillDoubleCross

func _init():
	name = "Double Cross"
	description = "Swap places with the enemy unit with the highest defence"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_unit_to_swap = query.get_enemy_team().iterator().compare(Compare.highest_def)
	return [LogSkillUsed.new(unit, self), LogSwapPlaces.new(unit, enemy_unit_to_swap)]
