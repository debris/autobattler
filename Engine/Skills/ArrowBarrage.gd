extends Skill
class_name SkillArrowBarrage

func _init():
	name = "Arrow Barrage"
	description = "Rain down a barrage of arrows upon all enemies and reduce their *defense* by 10%"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var enemy_battle_team = query.get_enemy_team()
	
	var result: Array[Log] = [LogSkillUsed.new(unit, self)]
	for enemy_unit in enemy_battle_team.members:
		if enemy_unit != null && enemy_unit.def > 0:
			var value = max(1, enemy_unit.def * 10 / 100)
			result.push_back(LogDefAdd.new(enemy_unit, -value))
		
	return result
