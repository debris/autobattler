extends Resource
class_name ProcessedLog

var inner: Log
var battle_query: BattleQuery
var replies_same_move: Array[Log]
# TODO: consider grouping them in arrays Array[Array[Log]]
# so they are processed in 
var replies_exes: Array[ExecutionEnv]

func _init(i: Log, bs: BattleState):
	inner = i
	battle_query = BattleQuery.new(i.unit, bs)
	replies_same_move = []
	replies_exes = []

func get_value() -> Log:
	return inner
	
func get_unit():
	return inner.unit

func get_skill():
	return inner.skill

func get_replies_same_move() -> Array[Log]:
	return replies_same_move

func get_replies_exes() -> Array[ExecutionEnv]:
	return replies_exes

func query() -> BattleQuery:
	return battle_query

func reply_same_move(reply: Log):
	replies_same_move.push_back(reply)

func reply_next_move(reply: Log):
	replies_exes.push_back(ExecutionEnv.new(inner.unit, SkillFromLog.new(reply, "", "")))

func reply_next_exe(env: ExecutionEnv):
	replies_exes.push_back(env)

func passive_activated(passive: Passive):
	reply_same_move(LogPassiveActivated.new(get_unit(), passive))
