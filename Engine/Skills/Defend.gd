extends Skill
class_name SkillDefend

func _init():
	name = "Defend"
	description = "Standard Defend"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var value = unit.def + unit.def_bonus
	return [LogDefend.new(unit, value)]
