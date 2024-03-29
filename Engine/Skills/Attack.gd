extends Skill
class_name SkillAttack

func _init():
	name = "Attack"
	description = "Standard Attack"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var value = unit.dmg + unit.dmg_bonus
	return [LogAttack.new(unit, value)]
