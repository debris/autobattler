extends Resource
class_name Log

var unit: BattleUnit
var valid: bool = true

func _finalize(battle_state: BattleState):
	print_debug("UNIMPLEMENTED: Log 'finalize'")
	assert(false)

func _to_string() -> String:
	print_debug("UNIMPLEMENTED: Log 'finalize'")
	return ""

func _display_is_valid() -> String:
	if valid:
		return ""
	return " (INVALID)"
