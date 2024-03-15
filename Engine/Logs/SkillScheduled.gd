extends Log
class_name LogSkillScheduled

var skill: Skill

func _init(u, n: Skill):
	unit = u
	skill = n

func _finalize(_battle_state: BattleState):
	pass

func _to_string() -> String:
	return unit.name + " scheduled \"" + skill.name + "\" skill"
