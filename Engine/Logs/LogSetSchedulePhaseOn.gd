# paint schedule LPto be (in)active
extends Log
class_name LogSetSchedulePhaseOn

var round: int
var schedule: int
var active: bool

func _init(u: BattleUnit, r, s, a):
	unit = u
	round = r
	schedule = s
	active = a

func _finalize(_battle_state: BattleState):
	unit.schedules[schedule].set_active(round, active)

func _to_string() -> String:
	if active:
		return unit.name + " gets schedule painted"
	else:
		return unit.name + " gets schedule cleaned up"
