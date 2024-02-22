extends Control

@onready var step_animation_time_label = $ScrollContainer/GridContainer/StepAnimationTimeLabel
@onready var step_animation_time_slider = $ScrollContainer/GridContainer/StepAnimationTimeSlider
@onready var screen_change_time_label = $ScrollContainer/GridContainer/ScreenChangeTimeLabel
@onready var screen_change_time_slider = $ScrollContainer/GridContainer/ScreenChangeTimeSlider
@onready var language_options = $ScrollContainer/GridContainer/LanguageOptions

var display_settings: DisplaySettings

func _ready():
	display_settings = DisplaySettings.default()
	step_animation_time_slider.value = display_settings.step_time
	screen_change_time_slider.value = display_settings.screen_transition_time
	
	match display_settings.language:
		"en": language_options.select(0)
		"de": language_options.select(1)
		"fr": language_options.select(2)
	

func update_display():
	step_animation_time_label.text = "step animation time: " + str(display_settings.step_time)
	screen_change_time_label.text = "screen change time: " + str(display_settings.screen_transition_time)

func _on_step_animation_time_slider_value_changed(value):
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
	
	display_settings.language = lang
