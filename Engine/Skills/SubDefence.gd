extends Skill
class_name SkillSubDefence

func _init():
	name = "Sub Defence"
	description = "Substitutes the weakest defender in the team with a special defence unit."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	var team = query.get_my_team()
	var weakest_unit = team.members[0]
	for i in team.members.size() - 1:
		var battle_unit = team.members[i + 1]
		if weakest_unit == null || (battle_unit != null && battle_unit.def < weakest_unit.def):
			weakest_unit = battle_unit
	
	var sub_owned = OwnedUnit.new(UnitDefenceSub.new(), weakest_unit.schedules)
	result.push_back(LogSwapPlaces.new(weakest_unit, BattleUnit.new(sub_owned)))
	return result
