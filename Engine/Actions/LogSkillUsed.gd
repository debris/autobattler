extends Log
class_name LogSkillUsed

var skill: Skill
var success: bool

func _init(u, n: Skill, s = true):
	unit = u
	skill = n
	success = s

func _finalize(_battle_state: BattleState):
	pass
