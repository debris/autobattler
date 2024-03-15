extends Log
class_name LogPower

var team: BattleTeam
var value: int

func _init(u: BattleUnit, t: BattleTeam, v: int):
	unit = u
	team = t
	value = v

func _finalize(_battle_state: BattleState):
	team.power += value

func _to_string() -> String:
	# TODO: add increases and decreases
	return unit.name + " changed team power by " + str(value)