extends Skill
class_name SkillPonyTrick

func _init():
	name = "Pony Trick"
	description = "SKILL_PONY_TRICK_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [
		LogSkillUsed.new(unit, self),
		LogSwapStats.new(unit)
	]	
	return result