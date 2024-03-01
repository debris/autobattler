extends Control

signal pressed(battle_unit: BattleUnit)

@export var battle_team_query: BattleTeamQuery
@export var tooltip_side: Side = Side.SIDE_TOP

func _process(_delta):
	var queries = battle_team_query.get_member_queries()
	var children = get_children()
	
	for i in queries.size():
		var child = children[i]
		child.battle_query = queries[i]
		var display_tooltip: DisplayTooltip = child.get_node("DisplayTooltip")
		display_tooltip.enabled = queries[i].root != null
		display_tooltip.side = tooltip_side

func _on_battle_unit_control_pressed(battle_unit):
	pressed.emit(battle_unit)
