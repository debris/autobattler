extends Skill
class_name SkillGhoulBite

func _init():
	name = "Ghoul Bite"
	description = "SKILL_GHOUL_BITE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_team = query.get_enemy_team()
	return [LogSkillUsed.new(unit, self), LogStacksAdd.new(unit, enemy_team, Stacks.Kind.POISON, 1)]
