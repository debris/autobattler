extends Skill
class_name SkillDefend

func _init():
	name = "Defend"
	description = "Standard Defend"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var value = unit.def + unit.def_bonus
	var my_team = query.get_my_team()
	my_team.power += value
	unit.def_bonus = 0
	return [LogDefend.new(unit, value)]
