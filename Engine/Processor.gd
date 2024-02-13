extends Object 
class_name Processor

func _process_logs(_pl_iterator: ProcessedLogs):
	null

func _process_changes(changes: ExecutionChanges, battle_state: BattleState) -> Array[ExecutionEnv]:
	var processed_logs = ProcessedLogs.new(changes.execution_logs, battle_state)
	_process_logs(processed_logs)
	var new_logs_same_move: Array[Log] = []
	var new_exes: Array[ExecutionEnv] = []
	var pl_iterator = processed_logs.iterator()
	var pl = pl_iterator.next()
	while pl != null:
		new_logs_same_move.push_back(pl.get_value())
		new_logs_same_move.append_array(pl.get_replies_same_move())
		new_exes.append_array(pl.get_replies_exes())
		pl = pl_iterator.next()
	
	changes.execution_logs = new_logs_same_move
	return new_exes
