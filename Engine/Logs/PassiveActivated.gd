extends Log
class_name LogPassiveActivated

var passive: Passive

func _init(u, p: Passive):
	unit = u
	passive = p

func _finalize(_battle_state: BattleState):
	pass

func _to_string() -> String:
	return unit.name + " activated \"" + passive.name + "\" passive"
