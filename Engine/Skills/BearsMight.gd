extends Skill
class_name SkillBearsMight

func _init():
	name = "Bear's Might"
	description = "If unit on the right is defending this turn, it defends for extra defence equal to this characters *defence*."

func _execute(query: BattleQuery) -> Array[Action]:
	var unit = query.get_this_unit()
	var next_unit = query.get_next_unit()
	if next_unit != null && next_unit.unit.def_schedule.at(query.get_round()):
		next_unit.def_bonus += unit.def
		return [ActionSkillUsed.new(unit, name), ActionAddDefBonus.new(next_unit, unit.def)]
		
	return [ActionSkillUsed.new(unit, name, false)]
