extends Skill
class_name SkillSubDefence

func _init():
	name = "Sub Defence"
	description = "SKILL_SUB_DEFENCE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	
	var weakest_unit = query.get_my_team().iterator().compare(Compare.lowest_def)

	var sub_owned = OwnedUnit.new(UnitDefenceSub.new(), weakest_unit.schedules)
	result.push_back(LogTurnInto.new(weakest_unit, BattleUnit.new(sub_owned, unit.team_level)))
	return result
