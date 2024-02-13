extends Log
class_name LogPoison

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v

func _finalize(battle_state: BattleState):
	var battle_query = BattleQuery.new(unit, battle_state)
	var team = battle_query.get_my_team()
	team.power -= value

func _to_string() -> String:
	return unit.name + " causes the team to take " + str(value) + " poison damage"
