extends Control

@export var battle_team_query: BattleTeamQuery:
	set(value):
		battle_team_query = value
		
		for child in team_grid.get_children():
			child.queue_free()

		for query in battle_team_query.get_member_queries():
			if query is BattleQueryNull:
				var control = preload("res://UI/BattleUnitSlotControl.tscn").instantiate()
				team_grid.add_child(control)
			else:
				var control = preload("res://UI/BattleUnitControl.tscn").instantiate()
				control.battle_query = query
				team_grid.add_child(control)

@onready var team_grid = $TeamGrid

func _ready():
	pass

func _process(delta):
	pass
