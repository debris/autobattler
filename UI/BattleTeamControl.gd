extends Control

@export var battle_team_query: BattleTeamQuery:
	set(value):
		battle_team_query = value
		refresh()

@onready var team_grid = $TeamGrid

func refresh():
	for child in team_grid.get_children():
		child.queue_free()

	for query in battle_team_query.get_member_queries():
		var control = preload("res://UI/BattleUnitControl.tscn").instantiate()
		control.battle_query = query
		team_grid.add_child(control)

func _process(_delta):
	var queries = battle_team_query.get_member_queries()
	var children = team_grid.get_children()
	
	for i in queries.size():
		children[i].battle_query = queries[i]
