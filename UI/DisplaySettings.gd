extends Resource
class_name DisplaySettings

# How long each step of the game should take. Affects the animation time
@export var step_time: float = 0.5

@export var screen_transition_time: float = 0.75

static var singleton

static func default() -> DisplaySettings:
	if singleton == null:
		singleton = DisplaySettings.new()
	return singleton
