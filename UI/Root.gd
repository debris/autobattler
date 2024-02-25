extends CanvasLayer

#@onready var overlay = $GlobalOverlay

var generator: Generator
var save: Save
var save_name: String
var current_view: Control

func enemy_team_size() -> int:
	if save.chapter == 0:
		return max(1, min(6, save.count_units() - 1))
	return 6
#
func enemy_team_level(chapter: int) -> int:
	return 2 * chapter

func close_view(view):
	# close global overlay first
	if "global_overlay" in view:
		view.global_overlay.visible = false

	await get_tree().create_timer(DisplaySettings.default().screen_transition_time).timeout
	if view != null:
		view.queue_free()

# fancy screen transition
func present_view(view):
	if current_view == null:
		add_child(view)
		current_view = view
		return
	
	close_view(current_view)
	current_view = view

	var back_buffer_copy = BackBufferCopy.new()
	back_buffer_copy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	var transition = preload("res://UI/Transition.tscn").instantiate()
	add_child(back_buffer_copy)
	add_child(view)
	add_child(transition)
	await get_tree().create_timer(DisplaySettings.default().screen_transition_time).timeout
	if back_buffer_copy != null:
		back_buffer_copy.queue_free()
	if transition != null:
		transition.queue_free()

func _ready():
	Sounds.start_main_theme_track()
	GlobalOverlay.on_exit = reset
	GlobalOverlay.on_character_pressed = func(overlay):
		var character_view = load("res://UI/Character.tscn").instantiate()
		character_view.save_name = save_name
		character_view.save = save
		overlay.present_subview(character_view)
	GlobalOverlay.on_team_pressed = func(overlay):
		var unit_list = load("res://UI/UnitList.tscn").instantiate()
		unit_list.selectable = false
		var battle_units: Array = save.all_units().collect().map(func(unit):
			return BattleUnit.new(unit, save.player_team_level)
		)
		unit_list.units.assign(battle_units)
		overlay.present_subview(unit_list)
	GlobalOverlay.goto_loadgame = loadgame_screen
	reset()

func reset():
	save = null
	save_name = ""

	var main_menu = preload("res://UI/MainMenu.tscn").instantiate()
	present_view(main_menu)
	await main_menu.play_pressed
	loadgame_screen()

func loadgame_screen():
	save = null
	save_name = ""

	# LOAD GAME
	while save == null:
		var load_game = preload("res://UI/Loadgame.tscn").instantiate()
		present_view(load_game)
		var action = await load_game.action_selected
	
		if action is LoadgameActionNew:
			var select_name = preload("res://UI/SelectName.tscn").instantiate()
			present_view(select_name)
			var select_name_action = await select_name.action_selected
			
			if select_name_action is SelectNameActionCancel:
				continue
			
			if select_name_action is SelectNameActionProceed:
				save = Save.new()
				save_name = select_name_action.selected_name
				# dont save here, as the team is incomplete, save only after selecting starting units
	
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
		select_units.title_text = "SELECT_2_UNITS"
		select_units.reroll_button_visible = true
		select_units.dialog_progress = save.dialog_progress
		select_units.reroll_button_pressed.connect(func():
			select_units.out_of = generator.random_team(6)
		)
		present_view(select_units)
		var units = await select_units.selected_units
		save.team.members = units
		while save.team.members.size() < 6:
			save.team.members.push_back(null)


	# GAME LOOP
	generator = Generator.new((save_name + str(save.chapter)).hash())
	var map = generator.random_map(Map.COLUMNS, Map.ROWS)
	while true:
		# save the game after every completed location
		save.write_save(save_name)
		
		var map_control = preload("res://UI/Map.tscn").instantiate()
		# TODO: refactor so selected location is not modified internally
		map_control.map = map
		map_control.dialog_progress = save.dialog_progress
		present_view(map_control)
		await map_control.selected_location
		
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
			await display_event(current_location._view())


func display_battle(collection: Array[Unit]):
	# lets fight with our team
	var battle = preload("res://UI/Battle.tscn").instantiate()
	battle.player_team_level = save.player_team_level
	battle.enemy_team_level = enemy_team_level(save.chapter)
	# TODO refactor so team and bench are not modified internally
	battle.player_team = save.team
	battle.bench = save.bench
	battle.enemy_team = generator.random_team(enemy_team_size(), collection)
	battle.dialog_progress = save.dialog_progress
	present_view(battle)
	var _result = await battle.battle_finished

	# after the fight lets get some rewards
	var select_reward = preload("res://UI/SelectUnits.tscn").instantiate()
	select_reward.to_select = 1
	select_reward.out_of = generator.random_team(6, collection)
	select_reward.player_team_level = save.player_team_level
	select_reward.title_text = "SELECT_REWARD"
	select_reward.team_button_visible = true
	select_reward.dialog_progress = save.dialog_progress

	present_view(select_reward)
	var units = await select_reward.selected_units
	assert(units.size() == 1)
	
	var added = false
	for i in save.team.members.size():
		if save.team.members[i] == null:
			save.team.members[i] = units[0]
			added = true
			break

	if !added:
		save.bench.push_back(units[0])

func display_event(event_view: Control):
	event_view.save = save
	present_view(event_view)
	await event_view.proceed
