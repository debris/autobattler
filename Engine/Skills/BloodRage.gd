extends Skill
class_name SkillBloodRage

func _init():
	name = "Blood Rage"
	description = "Increase *damage* by 20%."

func _execute(query: BattleQuery) -> Array[Action]:
	# increase unit dmg by 20%
	var unit = query.get_this_unit()
	unit.dmg += unit.dmg * 20 / 100
	
	# TODO: actions are basically logs at this point
	return [ActionSkillUsed.new(unit, name), ActionIncreaseDmg.new(unit, 20)]
