extends Log
class_name LogRoundAdd

var value: int

func _init(u, v):
	unit = u
	value = v

func _finalize(battle_state: BattleState):
	battle_state.round = max(0, battle_state.round + value)

func _to_string() -> String:
	return unit.unit.base.name + " changed the round number by " + str(value)