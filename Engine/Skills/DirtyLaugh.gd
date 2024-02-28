extends Skill
class_name SkillDirtyLaugh

func _init():
	name = "Dirty Laugh"
	description = "SKILL_DIRTY_LAUGH_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_team = query.get_enemy_team()
	return [LogSkillUsed.new(unit, self), LogStacksAdd.new(unit, enemy_team, Stacks.Kind.SELFHARM, 1)]
