extends Skill
class_name SkillPaint

var on: bool

func _init(o):
	on = o
	if on:
		name = "Paint"
		description = "Paints current phase as active for all units on the battlefield"
	else:
		name = "Cleanup"
		description = "Cleans current phase for all units on the battlefield"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	query.get_all_units().for_each(func(battle_unit): 
		result.push_back(LogSetSchedulePhaseOn.new(battle_unit, query.get_round(), query.get_phase(), on))
	)

	return result
