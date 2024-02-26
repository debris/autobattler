extends Resource
class_name DisplaySettings

signal language_changed
signal music_on_changed
signal sounds_on_changed

# How long each step of the game should take. Affects the animation time
@export var step_time: float = 0.5:
	set(value):
		step_time = value
		save_settings()

@export var screen_transition_time: float = 0.75:
	set(value):
		screen_transition_time = value
		save_settings()

@export var language: String = "en":
	set(value):
		language = value
		TranslationServer.set_locale(value)
		language_changed.emit()	
		save_settings()

@export var music_on: bool = true:
	set(value):
		music_on = value
		music_on_changed.emit()
		save_settings()

@export var sounds_on: bool = true:
	set(value):
		sounds_on = value
		sounds_on_changed.emit()
		save_settings()

var config_name: String

static var singleton

static func ensure_loaded():
	DisplaySettings.default()

static func default() -> DisplaySettings:
	if singleton == null:
		if ResourceLoader.exists(save_path("default")):
			singleton = ResourceLoader.load(save_path("default"))
		else:
			singleton = DisplaySettings.new()

	TranslationServer.set_locale(singleton.language)
	return singleton

static func save_path(cn):
	return "user://" + cn + "settings.tres"

# save after modifying any property
func save_settings():
	ResourceSaver.save(self, DisplaySettings.save_path("default"))