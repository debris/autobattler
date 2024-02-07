extends Resource
class_name BattleTeamQuery

var root: BattleTeam
var battle_state: BattleState

func _init(r, s):
	root = r
	battle_state = s

func get_member_queries() -> Array[Query]:
	var result: Array[Query] = []
	for member in root.members:
		if member == null:
			result.push_back(BattleQueryNull.new())
		else:
			result.push_back(BattleQuery.new(member, battle_state))
	return result
