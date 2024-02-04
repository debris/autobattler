extends Resource
class_name Log

var unit: BattleUnit

func _finalize(battle_state: BattleState):
	print_debug("UNIMPLEMENTED: Log 'finalize'")
	assert(false)

func _to_string() -> String:
	print_debug("UNIMPLEMENTED: Log 'finalize'")
	return ""
