extends Action
class_name ActionTeamAttack

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v
