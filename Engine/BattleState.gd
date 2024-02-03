extends Resource
class_name BattleState

signal action_executed
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
			await _display(battle_unit, battle_unit.def_schedule_pointer, ActionTeamDefend.new(battle_unit, team_a, battle_unit.def))

	for battle_unit in team_b.members:
		if battle_unit.unit.def_schedule.at(round):
			team_b.power += battle_unit.def
			await _display(battle_unit, battle_unit.def_schedule_pointer, ActionTeamDefend.new(battle_unit, team_b, battle_unit.def))

func _execute_dmg():
	for battle_unit in team_a.members:
		if battle_unit.unit.dmg_schedule.at(round):
			team_b.power -= battle_unit.dmg
			await _display(battle_unit, battle_unit.dmg_schedule_pointer, ActionTeamAttack.new(battle_unit, team_a, battle_unit.dmg))

	for battle_unit in team_b.members:
		if battle_unit.unit.dmg_schedule.at(round):
			team_a.power -= battle_unit.dmg
			await _display(battle_unit, battle_unit.dmg_schedule_pointer, ActionTeamAttack.new(battle_unit, team_b, battle_unit.dmg))

# private
func _execute_skills():
	for battle_unit in team_a.members:
		if battle_unit.unit.skill_schedule.at(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_a, self)
			action._execute()
			await _display(battle_unit, battle_unit.skill_schedule_pointer, action)
	
	for battle_unit in team_b.members:
		if battle_unit.unit.skill_schedule.at(round):
			var action = battle_unit.unit.skill._execute(battle_unit, team_b, self)
			action._execute()
			await _display(battle_unit, battle_unit.skill_schedule_pointer, action)

# private
func _display(battle_unit, schedule_pointer, action):
	schedule_pointer.active = true
	battle_unit.logs.push_back(action)
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
