extends Resource
class_name BattleState

signal action_executed(Action)
signal _internal_proceed

var round: int
var team_a: BattleTeam
var team_b: BattleTeam

func _init(a: Team, b: Team):
	round = 0
	team_a = BattleTeam.new(a)
	team_b = BattleTeam.new(b)

func execute_round():
	await _execute_skills()
	await _execute_def()
	await _execute_dmg()
	round += 1

func proceed():
	_internal_proceed.emit()

# private
func _execute_def():
	for battle_unit in team_a.members:
		if battle_unit.unit.def_schedule.at(round):
			team_a.power += battle_unit.def
			action_executed.emit(ActionTeamDefend.new(battle_unit, team_a, battle_unit.def))
			await _internal_proceed

	for battle_unit in team_b.members:
		if battle_unit.unit.def_schedule.at(round):
			team_b.power += battle_unit.def
			action_executed.emit(ActionTeamDefend.new(battle_unit, team_b, battle_unit.def))
			await _internal_proceed

func _execute_dmg():
	for battle_unit in team_a.members:
		if battle_unit.unit.dmg_schedule.at(round):
			team_b.power -= battle_unit.dmg
			action_executed.emit(ActionTeamAttack.new(battle_unit, team_a, battle_unit.dmg))
			await _internal_proceed

	for battle_unit in team_b.members:
		if battle_unit.unit.dmg_schedule.at(round):
			team_a.power -= battle_unit.dmg
			action_executed.emit(ActionTeamAttack.new(battle_unit, team_b, battle_unit.dmg))
			await _internal_proceed

# private
func _execute_skills():
	var team_a_actions = []
	for battle_unit in team_a.members:
		if battle_unit.unit.skill_schedule.at(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_a, self)
			team_a_actions.push_back(action)
	
	var team_b_actions = []
	for battle_unit in team_b.members:
		if battle_unit.unit.skill_schedule.at(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_b, self)
			team_b_actions.push_back(action)
	
	for action in team_a_actions:
		action._execute()
		action_executed.emit(action)
		await _internal_proceed
	
	for action in team_b_actions:
		action._execute()
		action_executed.emit(action)
		await _internal_proceed
