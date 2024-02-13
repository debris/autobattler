extends Object 
class_name Processor

func _process_logs(_pl_iterator: ProcessedLogs):
	null

func _process_changes(changes: ExecutionChanges, battle_state: BattleState) -> ExecutionChanges:
	var processed_logs = ProcessedLogs.new(changes.execution_logs, battle_state)
	_process_logs(processed_logs)
	var new_logs_same_move: Array[Log] = []
	var new_logs_next_move: Array[Log] = []
	var pl_iterator = processed_logs.iterator()
	var pl = pl_iterator.next()
	while pl != null:
		new_logs_same_move.push_back(pl.get_value())
		new_logs_same_move.append_array(pl.get_replies_same_move())
		new_logs_next_move.append_array(pl.get_replies_next_move())
		for execution_env in pl.get_exes():
			var new_changes = execution_env.execute(battle_state)
			new_logs_next_move.append_array(new_changes.execution_logs)
		
		pl = pl_iterator.next()
	
	changes.execution_logs = new_logs_same_move
	
	if new_logs_next_move.size() == 0:
		return null
	else:
		return ExecutionChanges.new(null, null, new_logs_next_move, changes.depth + 1)
