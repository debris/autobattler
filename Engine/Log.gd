extends Resource
class_name Log

var unit: BattleUnit

func _finalize(battle_state: BattleState):
	print_debug("UNIMPLEMENTED LOG 'finalize'")
	assert(false)
