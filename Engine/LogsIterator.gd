extends Object
class_name LogsIterator

var battle_state: BattleState
var filter_unit: BattleUnit
var current_position: int

func _init(bs: BattleState, u: BattleUnit = null):
	battle_state = bs
	filter_unit = u
	current_position = 0

func next() -> Log:
	var result = null
	while battle_state.logs.size() > current_position && result == null:
		var log = battle_state.logs[current_position]
		if filter_unit == null || (log.unit.get_instance_id() == filter_unit.get_instance_id()):
			result = log
		current_position += 1
	return result
