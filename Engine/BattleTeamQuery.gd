extends Resource
class_name BattleTeamQuery

var root: BattleTeam
var battle_state: BattleState

func _init(r, s):
	root = r
	battle_state = s

func get_member_queries() -> Array[Query]:
	var result: Array[Query] = []
	result.assign(root.members.map(func(member): return BattleQuery.new(member, battle_state)))
	return result
