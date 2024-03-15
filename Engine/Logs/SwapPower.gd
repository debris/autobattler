extends Log
class_name LogSwapPower

func _init(u: BattleUnit):
	unit = u

func _finalize(battle_state: BattleState):
	var power = battle_state.team_a.power
	battle_state.team_a.power = battle_state.team_b.power
	battle_state.team_b.power = power

func _to_string() -> String:
	return unit.name + "swapped power of both teams."
