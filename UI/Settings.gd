extends Control

@onready var battle_step_time_label = $ScrollContainer/GridContainer/BattleStepTimeLabel
@onready var battle_step_time_slider = $ScrollContainer/GridContainer/BattleStepTimeSlider
@onready var screen_change_time_label = $ScrollContainer/GridContainer/ScreenChangeTimeLabel
@onready var screen_change_time_slider = $ScrollContainer/GridContainer/ScreenChangeTimeSlider
@onready var language_options = $ScrollContainer/GridContainer/LanguageOptions
@onready var music_label: Label = $ScrollContainer/GridContainer/MusicLabel
@onready var music_slider: Slider = $ScrollContainer/GridContainer/MusicOnSlider
@onready var sounds_label: Label = $ScrollContainer/GridContainer/SoundsLabel
@onready var sounds_slider: Slider = $ScrollContainer/GridContainer/SoundsOnSlider

var display_settings: DisplaySettings

func _ready():
	var bool_to_float = func(value: bool) -> float:
		if value:
			return 1.0
		else:
			return 0.0

	display_settings = DisplaySettings.default()
	battle_step_time_slider.value = display_settings.step_time
	screen_change_time_slider.value = display_settings.screen_transition_time
	music_slider.value = bool_to_float.call(display_settings.music_on)
	sounds_slider.value = bool_to_float.call(display_settings.sounds_on)
	
	match display_settings.language:
		"en": language_options.select(0)
		"de": language_options.select(1)
		"fr": language_options.select(2)
		"pl": language_options.select(3)
	

func update_display():
	var bool_to_text = func(value: bool) -> String:
		if value:
			return "ON"
		else:
			return "OFF"

	battle_step_time_label.text = tr("BATTLE_STEP_TIME").format({"time": str(display_settings.step_time)})
	screen_change_time_label.text = tr("SCREEN_CHANGE_TIME").format({"time": str(display_settings.screen_transition_time)})
	music_label.text = "MUSIC: " + bool_to_text.call(display_settings.music_on)
	sounds_label.text = "SOUNDS: " + bool_to_text.call(display_settings.sounds_on)

func _on_battle_step_time_slider_value_changed(value):
	display_settings.step_time = value
	update_display()
	
func _on_screen_change_time_slider_value_changed(value):
	display_settings.screen_transition_time = value
	update_display()

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()


func _on_language_options_item_selected(index):
	var lang = "en"
	if index == 0:
		lang = "en"
	elif index == 1:
		lang = "de"
	elif index == 2:
		lang = "fr"
	elif index == 3:
		lang = "pl"
	else:
		assert(false, "unsupported language")
	
	display_settings.language = lang
	update_display()

func _on_music_on_slider_value_changed(value: float):
	display_settings.music_on = !is_zero_approx(value)
	update_display()


func _on_sounds_on_slider_value_changed(value:float):
	display_settings.sounds_on = !is_zero_approx(value)
	update_display()
