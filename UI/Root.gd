extends CanvasLayer

signal units_selected
signal battle_finished
signal reward_selected

var generator: Generator
var team: Team
var bench: Array[OwnedUnit]
var enemy_team_size
var player_team_level
var enemy_team_level

var seed: int = 0

func close_view(view):
	await get_tree().create_timer(DisplaySettings.default().screen_transition_time).timeout
	if view != null:
		view.queue_free()

# fancy screen transition
func display_view_with_transition(view):
	var back_buffer_copy = BackBufferCopy.new()
	back_buffer_copy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	var transition = preload("res://UI/Transition.tscn").instantiate()
	add_child(back_buffer_copy)
	add_child(view)
	add_child(transition)
	await get_tree().create_timer(DisplaySettings.default().screen_transition_time + 0.1).timeout
	if back_buffer_copy != null:
		back_buffer_copy.queue_free()
	if transition != null:
		transition.queue_free()

func _ready():
	Sounds.start_main_theme_track()
	generator = Generator.new(seed)
	
	# TODO: load team
	team = Team.new()
	bench = [] as Array[OwnedUnit]
	#for i in 100:
		#bench.push_back(generator.random_unit())
	enemy_team_size = 0
	player_team_level = 0
	enemy_team_level = 0

	while team.members.size() == 0:
		# if there is no team to load, select new
		var select_units = preload("res://UI/SelectUnits.tscn").instantiate()
		#select_units.generator = generator
		select_units.to_select = 2
		select_units.out_of = generator.random_team(6)
		select_units.player_team_level = player_team_level
		select_units.title_text = "select 2 units"
		select_units.reroll_button_visible = true
		select_units.reroll_button_pressed.connect(func():
			seed += 1
			select_units.queue_free()
			# team size is still 0, so we will start over with a different seed
			units_selected.emit()
		)
		select_units.selected_units.connect(func(units):
			team.members = units
			while team.members.size() < 6:
				team.members.push_back(null)
			close_view(select_units)
			units_selected.emit()
		)
		add_child(select_units)
			
		await units_selected


	# game screen loop
	var map = generator.random_map(Map.COLUMNS, Map.ROWS)
	while true:
		var map_control = preload("res://UI/Map.tscn").instantiate()
		map_control.map = map
		map_control.selected_location.connect(func():
			close_view(map_control)
		)
		display_view_with_transition(map_control)
		await map_control.selected_location
		
		var current_location = map.current_location()
		
		if current_location is LocationBattle:
			await display_battle(current_location.enemies_pool)

		if current_location is LocationBoss:
			# TODO: display a different kind of battle?
			await display_battle(Units.all)
			# progress to the new map
			map = generator.random_map(Map.COLUMNS, Map.ROWS)
			player_team_level += 1
			enemy_team_level += 2

		if current_location is LocationTreasure:
			var _treasure = generator.random_treasure()
		
		if current_location is LocationEvent:
			pass


func display_battle(collection: Array[Unit]):
	# lets fight with our team
	enemy_team_size = min(6, enemy_team_size + 1)
	var battle = preload("res://UI/Battle.tscn").instantiate()
	battle.player_team_level = player_team_level
	battle.enemy_team_level = enemy_team_level
	battle.player_team = team
	battle.bench = bench
	battle.enemy_team = generator.random_team(enemy_team_size, collection)
	battle.battle_finished.connect(func(_result):
		# TODO: depending on the result display different screens?
		close_view(battle)
		battle_finished.emit()
	)
	display_view_with_transition(battle)
	await battle_finished


	# after the fight lets get some rewards
	var select_reward = preload("res://UI/SelectUnits.tscn").instantiate()
	select_reward.to_select = 1
	select_reward.out_of = generator.random_team(6, collection)
	select_reward.player_team_level = player_team_level
	select_reward.title_text = "select reward"
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
		close_view(select_reward)
		reward_selected.emit()
	)
	display_view_with_transition(select_reward)
	await reward_selected
