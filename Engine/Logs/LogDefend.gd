extends Log
class_name LogDefend

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v

func _finalize(battle_state: BattleState):
	var battle_query = BattleQuery.new(unit, battle_state)
	var team = battle_query.get_my_team()
	team.power += value
	unit.dmg_bonus = 0

func _to_string() -> String:
	return unit.unit.base.name + " DEFENDs for " + str(value)
