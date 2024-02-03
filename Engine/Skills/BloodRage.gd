extends Skill
class_name SkillBloodRage

func _init():
	name = "Blood Rage"
	description = "Increase *damage* by 20%."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var value = unit.dmg * 20 / 100
	unit.dmg += value
	
	return [LogSkillUsed.new(unit, name), LogDmgAdd.new(unit, value)]
