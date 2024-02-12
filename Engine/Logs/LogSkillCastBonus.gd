extends Log
class_name LogSkillCastBonus

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(_battle_state: BattleState):
	unit.skill_bonus_casts = max(0, unit.skill_bonus_casts + value)

func _to_string() -> String:
	return unit.name + " gets " + str(value) + " extra skill use"
