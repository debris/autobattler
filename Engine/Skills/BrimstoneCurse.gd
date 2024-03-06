extends Skill
class_name SkillBrimstoneCurse

func _init():
	name = "Brimstone Curse"
	description = "SKILL_BRIMSTONE_CURSE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]

	query.get_all_units()\
		.for_each(func(battle_unit):
			var value = max(1, unit.def * 10 / 100)
			result.push_back(LogDefAdd.new(battle_unit, -value))
			var value2 = max(1, unit.dmg * 10 / 100)
			result.push_back(LogDmgAdd.new(battle_unit, -value2))
			pass\
		)

	return result
