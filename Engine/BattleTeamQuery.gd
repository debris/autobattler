extends Resource
class_name BattleTeamQuery

var root: BattleTeam
var battle_state: BattleState

func _init(r, s):
	root = r
	battle_state = s

func get_member_queries() -> Array[BattleQuery]:
	var result: Array[BattleQuery] = []
	for member in root.members:
		result.push_back(BattleQuery.new(member, battle_state))
	return result
