# Game background
#
# Might be scrolling or not
# Allows smooth transition between 2 screens that may have scrolling background or not.
extends Sprite2D

static var shared_region_position: float = 255.0
static var screen_enter_time: int
static var last_update_time: int

@export var scroll: bool = true

func _ready():
	screen_enter_time = Time.get_ticks_msec()
	last_update_time = Time.get_ticks_msec()

func _process(_delta):
	var to_seconds = func(val: int):
		return float(val) / 1000.0

	var current_time = Time.get_ticks_msec()
	if !scroll && to_seconds.call(current_time - screen_enter_time) > DisplaySettings.default().screen_transition_time:
		return
	_update_scroll_position()

func _update_scroll_position():
	const CONCRETE_PACE: float = 25.0
	var current_time = Time.get_ticks_msec()
	var time_diff = float(current_time - last_update_time) / 1000.0
	shared_region_position -= time_diff * CONCRETE_PACE
	region_rect.position.y = shared_region_position
	last_update_time = current_time
