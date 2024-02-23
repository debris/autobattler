extends Resource
class_name DisplaySettings

signal language_changed

# How long each step of the game should take. Affects the animation time
@export var step_time: float = 0.5

@export var screen_transition_time: float = 0.75

@export var language: String = "en":
	set(value):
		language = value
		TranslationServer.set_locale(value)
		language_changed.emit()

static var singleton

static func default() -> DisplaySettings:
	if singleton == null:
		singleton = DisplaySettings.new()
	return singleton
