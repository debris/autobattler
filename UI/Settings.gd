extends Control

@onready var step_animation_time_label = $ScrollContainer/GridContainer/StepAnimationTimeLabel
@onready var step_animation_time_slider = $ScrollContainer/GridContainer/StepAnimationTimeSlider
@onready var screen_change_time_label = $ScrollContainer/GridContainer/ScreenChangeTimeLabel
@onready var screen_change_time_slider = $ScrollContainer/GridContainer/ScreenChangeTimeSlider

var display_settings: DisplaySettings

func _ready():
	display_settings = DisplaySettings.default()
	step_animation_time_slider.value = display_settings.step_time
	screen_change_time_slider.value = display_settings.screen_transition_time
	

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
