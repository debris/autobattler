extends Skill
class_name SkillLokiSwap

func _init():
	name = "Loki Swap"
	description = "SKILL_LOKI_SWAP_DESC"

func _execute(query: BattleQuery) -> Array[Log]:
	var unit = query.get_this_unit()
	var team = query.get_my_team()
	var enemy_team = query.get_enemy_team()
	var find_highest_dmg = func(t) -> BattleUnit:
		var target = t.members[0]
		for i in t.members.size() - 1:
			if target == null || (t.members[i + 1] != null && (t.members[i + 1].dmg > target.dmg)):
				target = t.members[i + 1]
		return target
	
	var target_a = find_highest_dmg.call(team)
	var target_b = find_highest_dmg.call(enemy_team)
	return [LogSkillUsed.new(unit, self), LogSwapSkills.new(target_a, target_b)]
