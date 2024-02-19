extends Control

signal pressed(battle_unit: BattleUnit)

@export var battle_team_query: BattleTeamQuery

@onready var team_grid = $TeamGrid

func _process(_delta):
	var queries = battle_team_query.get_member_queries()
	var children = team_grid.get_children()
	
	for i in queries.size():
		children[i].battle_query = queries[i]

func _on_battle_unit_control_pressed(battle_unit):
	pressed.emit(battle_unit)
