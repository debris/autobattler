extends ColorRect

@onready var team_grid = $TeamGrid
@onready var power_label = $Power

@export var battle_team: BattleTeam:
	set(value):
		battle_team = value
		
		for child in team_grid.get_children():
			child.queue_free()

		for battle_unit in battle_team.members:
			var control = preload("res://UI/BattleUnitControl.tscn").instantiate()
			control.battle_unit = battle_unit
			team_grid.add_child(control)

func _ready():
	pass

func _process(delta):
	power_label.text = "POWER: " + str(battle_team.power)
