extends Skill
class_name BloodRage

func _init():
	name = "BloodRage"

func _execute(unit: BattleUnit, _team: BattleTeam, _battle_state: BattleState) -> Action:
	# increase unit dmg by 20%
	return ActionIncreaseDmg.new(unit, 20)
