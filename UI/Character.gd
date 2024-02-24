extends Control

@export var save_name: String:
	set(value):
		save_name = value
		if is_node_ready():
			display_character_name()

@export var save: Save:
	set(value):
		save = value
		if is_node_ready():
			display_character()

@onready var name_label = $GridContainer/NameLabel
@onready var chapter_label = $GridContainer/ChapterLabel
@onready var level_label = $GridContainer/LevelLabel
@onready var units_label = $GridContainer/UnitsLabel

func display_character_name():
	name_label.text = save_name

func display_character():
	chapter_label.text = tr("CHAPTER").format({"chapter": str(save.chapter)})
	level_label.text = tr("LEVEL").format({"level": str(save.player_team_level)})
	units_label.text = tr("UNITS").format({"units": str(save.count_units())})

func _ready():
	display_character_name()
	display_character()

