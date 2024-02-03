extends Resource
class_name BattleState

signal action_executed
signal _internal_proceed

var round: int
var team_a: BattleTeam
var team_b: BattleTeam
var logs: Array[Log]

func _init(a: Team, b: Team):
	round = 0
	team_a = BattleTeam.new(a)
	team_b = BattleTeam.new(b)

func team_a_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_a, self)

func team_b_query() -> BattleTeamQuery:
	return BattleTeamQuery.new(team_b, self)

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
			var value = battle_unit.def + battle_unit.def_bonus
			team_a.power += value
			battle_unit.def_bonus = 0
			await _display(battle_unit, battle_unit.def_schedule_pointer, [LogDefend.new(battle_unit, value)])
		else:
			await _display_none(battle_unit.def_schedule_pointer)

	for battle_unit in team_b.members:
		if battle_unit.unit.def_schedule.at(round):
			var value = battle_unit.def + battle_unit.def_bonus
			team_b.power += value
			battle_unit.def_bonus = 0
			await _display(battle_unit, battle_unit.def_schedule_pointer, [LogDefend.new(battle_unit, value)])
		else:
			await _display_none(battle_unit.def_schedule_pointer)

func _execute_dmg():
	for battle_unit in team_a.members:
		if battle_unit.unit.dmg_schedule.at(round):
			var value = battle_unit.dmg + battle_unit.dmg_bonus
			team_b.power -= value
			battle_unit.dmg_bonus = 0
			await _display(battle_unit, battle_unit.dmg_schedule_pointer, [LogAttack.new(battle_unit, value)])
		else:
			await _display_none(battle_unit.dmg_schedule_pointer)

	for battle_unit in team_b.members:
		if battle_unit.unit.dmg_schedule.at(round):
			var value = battle_unit.dmg + battle_unit.dmg_bonus
			team_a.power -= value
			battle_unit.dmg_bonus = 0
			await _display(battle_unit, battle_unit.dmg_schedule_pointer, [LogAttack.new(battle_unit, value)])
		else:
			await _display_none(battle_unit.dmg_schedule_pointer)

# private
func _execute_skills():
	for battle_unit in team_a.members:
		if battle_unit.unit.skill_schedule.at(round):
			var actions = battle_unit.unit.skill._execute(BattleQuery.new(battle_unit, self))
			await _display(battle_unit, battle_unit.skill_schedule_pointer, actions)
		else:
			await _display_none(battle_unit.skill_schedule_pointer)
	
	for battle_unit in team_b.members:
		if battle_unit.unit.skill_schedule.at(round):
			var actions = battle_unit.unit.skill._execute(BattleQuery.new(battle_unit, self))
			await _display(battle_unit, battle_unit.skill_schedule_pointer, actions)
		else:
			await _display_none(battle_unit.skill_schedule_pointer)

# private
func _display(battle_unit, schedule_pointer, actions):
	schedule_pointer.active = true
	schedule_pointer.round = round
	
	print_debug("actions: ", actions)
	logs.append_array(actions)
	
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next round
	schedule_pointer.round += 1

func _display_none(schedule_pointer):
	schedule_pointer.active = true
	schedule_pointer.round = round
	action_executed.emit()
	await _internal_proceed
	schedule_pointer.active = false
	# point at the next round
	schedule_pointer.round += 1
