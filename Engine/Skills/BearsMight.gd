extends Skill
class_name SkillBearsMight

func _init():
	name = "Bear's Might"
	description = "If unit on the right is defending in this phase, it defends for extra defence equal to this characters *defence*."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var next_unit = query.get_next_unit()
	if next_unit != null:
		var schedule = next_unit.schedules[query.get_phase()]
		if schedule.kind == Schedule.Kind.DEF && schedule.at(query.get_round()):
			return [LogSkillUsed.new(unit, self), LogDefBonusAdd.new(next_unit, unit.def)]
		
	return [LogSkillUsed.new(unit, self, false)]
