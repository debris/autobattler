extends CanvasLayer

signal player_team_ready

func _ready():
	var generator = Generator.new()
	
	# TODO: load team
	var team = Team.new()
	
	# if there is no team to load, select new
	var select_units = preload("res://UI/SelectUnits.tscn").instantiate()
	select_units.to_select = 2
	add_child(select_units)
	
	select_units.selected_units.connect(func(units):
		team.members = units
		while team.members.size() < 6:
			team.members.push_back(null)
		select_units.queue_free()
		player_team_ready.emit()
	)
	
	await player_team_ready
	var battle = preload("res://UI/Battle.tscn").instantiate()
	battle.player_team = team
	battle.enemy_team = generator.random_team(1)
	add_child(battle)
