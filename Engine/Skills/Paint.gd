extends Skill
class_name SkillPaint

@export var on: bool

func _init(o = true):
	on = o
	if on:
		name = "Paint"
		description = "SKILL_PAINT_DESC"
	else:
		name = "Cleanup"
		description = "SKILL_CLEANUP_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	query.get_all_units().for_each(func(battle_unit): 
		result.push_back(LogSetSchedulePhaseOn.new(battle_unit, query.get_round(), query.get_phase(), on))
	)

	return result
