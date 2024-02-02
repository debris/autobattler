extends Resource
class_name BattleState

signal action_executed(Action)

var round: int
var team_a: BattleTeam
var team_b: BattleTeam

func _init(a: Team, b: Team):
	round = 0
	team_a = BattleTeam.new(a)
	team_b = BattleTeam.new(b)

func execute_round():
	_execute_skills()
	_execute_def()
	_execute_dmg()

# private
func _execute_def():
	for battle_unit in team_a.members:
		if battle_unit.unit.is_def_active_at_round(round):
			team_a.power += battle_unit.def
			action_executed.emit(ActionTeamDefend.new(battle_unit, team_a, battle_unit.def))

	for battle_unit in team_b.members:
		if battle_unit.unit.is_def_active_at_round(round):
			team_b.power += battle_unit.def
			action_executed.emit(ActionTeamDefend.new(battle_unit, team_b, battle_unit.def))

func _execute_dmg():
	for battle_unit in team_a.members:
		if battle_unit.unit.is_dmg_active_at_round(round):
			team_b.power -= battle_unit.dmg
			action_executed.emit(ActionTeamAttack.new(battle_unit, team_a, battle_unit.dmg))

	for battle_unit in team_b.members:
		if battle_unit.unit.is_dmg_active_at_round(round):
			team_a.power -= battle_unit.dmg
			action_executed.emit(ActionTeamAttack.new(battle_unit, team_b, battle_unit.dmg))

# private
func _execute_skills():
	var team_a_actions = []
	for battle_unit in team_a.members:
		if battle_unit.unit.is_skill_active_at_round(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_a, self)
			team_a_actions.push_back(action)
	
	var team_b_actions = []
	for battle_unit in team_b.members:
		if battle_unit.unit.is_skill_active_at_round(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_b, self)
			team_b_actions.push_back(action)
	
	for action in team_a_actions:
		action._execute()
		action_executed.emit(action)
	
	for action in team_b_actions:
		action._execute()
		action_executed.emit(action)
