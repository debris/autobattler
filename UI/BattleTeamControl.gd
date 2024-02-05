extends Control

@export var battle_team_query: BattleTeamQuery:
	set(value):
		battle_team_query = value
		
		for child in team_grid.get_children():
			child.queue_free()

		for battle_query in battle_team_query.get_member_queries():
			var control = preload("res://UI/BattleUnitControl.tscn").instantiate()
			control.battle_query = battle_query
			team_grid.add_child(control)

@onready var team_grid = $TeamGrid

func _ready():
	pass

func _process(delta):
	pass
