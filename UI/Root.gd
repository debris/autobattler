extends CanvasLayer

signal player_team_ready
signal battle_finished
signal reward_selected

var generator: Generator
var team: Team
var bench: Array[OwnedUnit]
var enemy_team_size

func _ready():
	generator = Generator.new(3)
	
	# TODO: load team
	team = Team.new()
	bench = [] as Array[OwnedUnit]
	enemy_team_size = 0

	if team.members.size() == 0:
		# if there is no team to load, select new
		var select_units = preload("res://UI/SelectUnits.tscn").instantiate()
		#select_units.generator = generator
		select_units.to_select = 2
		select_units.out_of = generator.random_team(6)
		select_units.selected_units.connect(func(units):
			team.members = units
			while team.members.size() < 6:
				team.members.push_back(null)
			select_units.queue_free()
			player_team_ready.emit()
		)
		add_child(select_units)
		await player_team_ready


	# game screen loop
	var enemy_team_size = 0
	var map = generator.random_map(Map.COLUMNS, Map.ROWS)
	while true:
		var map_control = preload("res://UI/Map.tscn").instantiate()
		map_control.map = map
		map_control.selected_location.connect(func():
			map_control.queue_free()
		)
		add_child(map_control)
		await map_control.selected_location
		
		var current_location = map.current_location()
		
		if current_location is LocationBattle:
			await display_battle(current_location.enemies_pool)

		if current_location is LocationBoss:
			# TODO: display a different kind of battle?
			await display_battle(Units.all)
			# progress to the new map
			map = generator.random_map(Map.COLUMNS, Map.ROWS)

		if current_location is LocationTreasure:
			var _treasure = generator.random_treasure()
		
		if current_location is LocationEvent:
			pass


func display_battle(collection: Array[Unit]):
	# lets fight with our team
	enemy_team_size = min(6, enemy_team_size + 1)
	var battle = preload("res://UI/Battle.tscn").instantiate()
	battle.player_team = team
	battle.bench = bench
	battle.enemy_team = generator.random_team(enemy_team_size, collection)
	battle.battle_finished.connect(func(_result):
		# TODO: depending on the result display different screens?
		battle.queue_free()
		battle_finished.emit()
	)
	add_child(battle)
	await battle_finished


	# after the fight lets get some rewards
	var select_reward = preload("res://UI/SelectUnits.tscn").instantiate()
	#select_reward.generator = generator
	select_reward.to_select = 1
	select_reward.out_of = generator.random_team(6, collection)
	select_reward.selected_units.connect(func(units):
		assert(units.size() == 1)
		var added = false
		for i in team.members.size():
			if team.members[i] == null:
				team.members[i] = units[0]
				added = true
				break
		if !added:
			bench.push_back(units[0])
		select_reward.queue_free()
		reward_selected.emit()
	)
	add_child(select_reward)
	await reward_selected
