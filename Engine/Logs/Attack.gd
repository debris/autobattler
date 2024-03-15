extends Log
class_name LogAttack

var value: int

func _init(u: BattleUnit, v: int):
	unit = u
	value = v

func _finalize(battle_state: BattleState):
	var battle_query = BattleQuery.new(unit, battle_state)
	var enemy_team = battle_query.get_enemy_team()
	enemy_team.power -= value
	unit.dmg_bonus = 0

func _to_string() -> String:
	return unit.name + " ATTACKs enemy team for " + str(value)
