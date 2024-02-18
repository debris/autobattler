extends Control

enum Result {
	VICTORY,
	DEFEAT,
	TIE,
}

signal battle_finished(result)

@export var player_team: Team
@export var enemy_team: Team
@export var player_team_level: int
@export var enemy_team_level: int
@export var bench: Array[OwnedUnit]

@onready var team_a_control = $TeamA
@onready var team_b_control = $TeamB
@onready var team_a_power = $TeamAPower
@onready var team_b_power = $TeamBPower
@onready var round_label = $RightPanel/Round
@onready var phase_label = $RightPanel/Phase
@onready var console_logs = $ConsoleLogs
@onready var pause_button = $CanvasLayer/Control/Pause
@onready var step_button = $CanvasLayer/Control/Step
@onready var start_button = $Start
@onready var victory_label = $VictoryLabel
@onready var change_grid = $ChangeGrid
@onready var continue_button = $Continue
@onready var level_a_label = $LevelA
@onready var level_b_label = $LevelB
@onready var stacks_control_a = $StacksControlA
@onready var stacks_control_b = $StacksControlB

var battle_state: BattleState
var battle_controller: BattleController
var paused = false
var result: Result

func _ready():
	assert(player_team.members.size() == 6)
	assert(enemy_team.members.size() == 6)
	
	battle_controller = BattleController.default()
	battle_controller.show_details.connect(func(battle_query):
		paused = true
		var details = load("res://UI/UnitDetails.tscn").instantiate()
		details.unit = battle_query.get_this_unit()
		add_child(details)
	)
	battle_controller.move_unit_left.connect(func(i): 
		if i > 0:
			var members = battle_state.team_b.members
			var tmp = members[i - 1]
			members[i - 1] = members[i]
			members[i] = tmp
			
			# update the upstream team
			if members[i] != null:
				player_team.members[i] = members[i].unit
			else:
				player_team.members[i] = null
			
			if members[i - 1] != null:
				player_team.members[i - 1] = members[i - 1].unit
			else:
				player_team.members[i - 1] = null
			team_b_control.refresh()
	)
	battle_controller.move_unit_right.connect(func(i): 
		var members = battle_state.team_b.members
		if i < members.size() - 1:
			var tmp = members[i + 1]
			members[i + 1] = members[i]
			members[i] = tmp
			
			# update the upstream team
			if members[i] != null:
				player_team.members[i] = members[i].unit
			else:
				player_team.members[i] = null
			
			if members[i + 1] != null:
				player_team.members[i + 1] = members[i + 1].unit
			else:
				player_team.members[i + 1] = null
			team_b_control.refresh()
	)
	battle_controller.change_pressed.connect(func(i):
		var list = preload("res://UI/UnitList.tscn").instantiate()
		list.units = bench
		list.selected_unit.connect(func(index):
			var members = battle_state.team_b.members
			var tmp = bench[index]
			if members[i] != null:
				bench[index] = members[i].unit
			else:
				bench.remove_at(index)
			members[i] = BattleUnit.new(tmp, player_team_level)

			player_team.members[i] = tmp
			team_b_control.refresh()
			list.queue_free()
		)
		add_child(list)
	)

	battle_state = BattleState.new(BattleTeam.new(enemy_team, enemy_team_level), BattleTeam.new(player_team, player_team_level))
	team_a_control.battle_team_query = battle_state.team_a_query()
	team_b_control.battle_team_query = battle_state.team_b_query()
	team_a_power.battle_team = battle_state.team_a
	team_b_power.battle_team = battle_state.team_b
	
	stacks_control_a.stacks = battle_state.team_a.stacks
	stacks_control_b.stacks = battle_state.team_b.stacks

	battle_state.action_executed.connect(_wait_for_display)
	console_logs.battle_state = battle_state

# private
func _wait_for_display():
	await get_tree().create_timer(DisplaySettings.default().step_time).timeout
	
	var victory = battle_state.team_a.power <= 0
	var defeat = battle_state.team_b.power <= 0
	var tie = victory && defeat
	
	if tie:
		return on_battle_end(Result.TIE)
	
	if victory:
		return on_battle_end(Result.VICTORY)

	if defeat:
		return on_battle_end(Result.DEFEAT)
	
	if !paused:
		battle_state.proceed()

func on_battle_end(battle_result):
	result = battle_result
	match result:
		Result.VICTORY: victory_label.text = "victory"
		Result.DEFEAT: victory_label.text = "defeat"
		Result.TIE: victory_label.text = "tie"
	
	continue_button.visible = true
	victory_label.visible = true
	step_button.visible = false
	pause_button.visible = false
	paused = true

func _process(_delta):
	round_label.text = str(battle_state.round + 1)
	phase_label.text = str(battle_state.phase + 1) + " of 3"
	level_a_label.text = "LEVEL " + str(enemy_team_level + 1)
	level_b_label.text = "LEVEL " + str(player_team_level + 1)
	
	if !paused:
		pause_button.text = "PAUSE"
	else:
		pause_button.text = "PLAY"

func _on_pause_pressed():
	paused = !paused
	if !paused:
		battle_state.proceed()

func _on_console_pressed():
	console_logs.visible = !console_logs.visible

func _on_step_pressed():
	battle_state.proceed()

func _on_start_pressed():
	paused = false
	start_button.visible = false
	step_button.visible = true
	pause_button.visible = true
	change_grid.visible = false

	while true:
		await battle_state.execute_round()

func _on_continue_pressed():
	battle_finished.emit(result)
