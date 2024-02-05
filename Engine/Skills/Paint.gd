extends Skill
class_name SkillPaint

func _init():
	name = "Paint"
	description = "Paints current cycle as active for all units on the battlefield"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var all_units = query.get_all_units()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	for battle_unit in all_units:
		result.push_back(LogSetSchedulePhaseOn.new(battle_unit, query.get_round(), query.get_phase(), true))
	return result
