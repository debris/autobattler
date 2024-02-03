extends Resource
class_name Skill

var name: String

func _execute(_unit: BattleUnit, _team: BattleTeam, _battle_state: BattleState) -> Action:
	return Action.new()
