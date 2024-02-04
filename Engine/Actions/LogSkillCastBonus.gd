extends Log
class_name LogSkillCastBonus

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.skill_bonus_casts += value
