extends Skill
class_name SkillPaint

var on: bool

func _init(o):
	on = o
	if on:
		name = "Paint"
		description = "Paints current cycle as active for all units on the battlefield"
	else:
		name = "Cleanup"
		description = "Cleans current cycle for all units on the battlefield"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var all_units = query.get_all_units()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	for battle_unit in all_units:
		if battle_unit != null:
			result.push_back(LogSetSchedulePhaseOn.new(battle_unit, query.get_round(), query.get_phase(), on))
	return result
