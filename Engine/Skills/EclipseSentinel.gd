extends Skill
class_name SkillEclipseSentinel

func _init():
	name = "Eclipse Sentinel"
	description = "Add 1 stack of *vigilance*."

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var my_team = query.get_my_team()
	return [LogSkillUsed.new(unit, self), LogStacksAdd.new(unit, my_team, Stacks.Kind.VIGILANT, 1)]
