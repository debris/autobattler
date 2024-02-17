extends CanvasLayer

var generator: Generator
var save: Save
var save_name: String

func enemy_team_size() -> int:
	if save.chapter == 0:
		return save.count_units() - 1
	return 6
#
func enemy_team_level(chapter: int) -> int:
	return 2 * chapter

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

	# LOAD GAME
	while save == null:
		var load_game = preload("res://UI/Loadgame.tscn").instantiate()
		add_child(load_game)
		var action = await load_game.action_selected
		close_view(load_game)
	
		if action is LoadgameActionNew:
			var select_name = preload("res://UI/SelectName.tscn").instantiate()
			display_view_with_transition(select_name)
			#save_name = await select_name.selected_name
			var select_name_action = await select_name.action_selected
			close_view(select_name)
			
			if select_name_action is SelectNameActionCancel:
				continue
			
			if select_name_action is SelectNameActionProceed:
				save_name = select_name_action.selected_name
				save = Save.new()
				save.write_save(save_name)
	
		if action is LoadgameActionLoad:
			save = action.save
			save_name = action.save_name

	# SELECT STARTING UNITS
	generator = Generator.new(save_name.hash())
	while save.count_units() == 0:
		# if there is no team to load, select new
		var select_units = preload("res://UI/SelectUnits.tscn").instantiate()
		select_units.to_select = 2
		select_units.out_of = generator.random_team(6)
		select_units.player_team_level = save.player_team_level
		select_units.title_text = "select 2 units"
		select_units.reroll_button_visible = true
		select_units.reroll_button_pressed.connect(func():
			select_units.out_of = generator.random_team(6)
		)
		display_view_with_transition(select_units)
		var units = await select_units.selected_units
		save.team.members = units
		while save.team.members.size() < 6:
			save.team.members.push_back(null)
		close_view(select_units)


	# GAME LOOP
	generator = Generator.new((save_name + str(save.chapter)).hash())
	var map = generator.random_map(Map.COLUMNS, Map.ROWS)
	while true:
		# save the game after every completed location
		save.write_save(save_name)
		
		var map_control = preload("res://UI/Map.tscn").instantiate()
		map_control.map = map
		display_view_with_transition(map_control)
		await map_control.selected_location
		close_view(map_control)
		
		var current_location = map.current_location()
		
		if current_location is LocationBattle:
			await display_battle(current_location.enemies_pool)

		if current_location is LocationBoss:
			# TODO: display a different kind of battle?
			await display_battle(Units.all)
			# progress to the new map
			save.player_team_level += 1
			save.chapter += 1
			generator = Generator.new((save_name + str(save.chapter)).hash())
			map = generator.random_map(Map.COLUMNS, Map.ROWS)

		if current_location is LocationTreasure:
			var _treasure = generator.random_treasure()
		
		if current_location is LocationEvent:
			pass


func display_battle(collection: Array[Unit]):
	# lets fight with our team
	var battle = preload("res://UI/Battle.tscn").instantiate()
	battle.player_team_level = save.player_team_level
	battle.enemy_team_level = enemy_team_level(save.chapter)
	battle.player_team = save.team
	battle.bench = save.bench
	battle.enemy_team = generator.random_team(enemy_team_size(), collection)
	display_view_with_transition(battle)
	var _result = await battle.battle_finished
	close_view(battle)


	# after the fight lets get some rewards
	var select_reward = preload("res://UI/SelectUnits.tscn").instantiate()
	select_reward.to_select = 1
	select_reward.out_of = generator.random_team(6, collection)
	select_reward.player_team_level = save.player_team_level
	select_reward.title_text = "select reward"
	display_view_with_transition(select_reward)
	var units = await select_reward.selected_units
	assert(units.size() == 1)
	close_view(select_reward)
	
	var added = false
	for i in save.team.members.size():
		if save.team.members[i] == null:
			save.team.members[i] = units[0]
			added = true
			break

	if !added:
		save.bench.push_back(units[0])
