extends Resource
class_name ProcessedLog

var inner: Log
var battle_query: BattleQuery
var replies_same_move: Array[Log]
var replies_next_move: Array[Log]
var replies_exe: Array[ExecutionEnv]

func _init(i: Log, bs: BattleState):
	inner = i
	battle_query = BattleQuery.new(i.unit, bs)
	replies_same_move = []
	replies_next_move = []
	replies_exe = []

func get_value() -> Log:
	return inner
	
func get_replies_same_move() -> Array[Log]:
	return replies_same_move

func get_replies_next_move() -> Array[Log]:
	return replies_next_move

func get_exes() -> Array[ExecutionEnv]:
	return replies_exe

func query() -> BattleQuery:
	return battle_query

func reply_same_move(reply: Log):
	replies_same_move.push_back(reply)

func reply_next_move(reply: Log):
	replies_next_move.push_back(reply)

func reply_next_exe(env: ExecutionEnv):
	replies_exe.push_back(env)
