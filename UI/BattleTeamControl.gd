extends Control

signal pressed(battle_unit: BattleUnit)

@export var battle_team_query: BattleTeamQuery

@onready var battle_unit1 = $BattleUnitControl
@onready var battle_unit2 = $BattleUnitControl2
@onready var battle_unit3 = $BattleUnitControl3
@onready var battle_unit4 = $BattleUnitControl4
@onready var battle_unit5 = $BattleUnitControl5
@onready var battle_unit6 = $BattleUnitControl6

func _process(_delta):
	var queries = battle_team_query.get_member_queries()

	# use this array instead of self.get_children, cause the view child order is different than the engine order
	var children = [
		battle_unit1,
		battle_unit2,
		battle_unit3,
		battle_unit4,
		battle_unit5,
		battle_unit6,
	]
	
	for i in queries.size():
		var child = children[i]
		child.battle_query = queries[i]

func _on_battle_unit_control_pressed(battle_unit):
	pressed.emit(battle_unit)
