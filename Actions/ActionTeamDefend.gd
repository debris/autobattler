extends Action
class_name ActionTeamDefend

var unit: BattleUnit
var team: BattleTeam
var value: int

func _init(u: BattleUnit, t: BattleTeam, v: int):
	unit = u
	team = t
	value = v
