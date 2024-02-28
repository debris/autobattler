extends Skill
class_name SkillSelfishExchange

func _init():
	name = "Selfish Exchange"
	description = "SKILL_SELFISH_EXCHANGE_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()

	var my_team_power = query.get_my_team().power	
	var enemy_team_power = query.get_enemy_team().power

	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	if enemy_team_power > my_team_power:
		result.push_back(LogSwapPower.new(unit))

	return result