@tool
extends Control
class_name TeamPowerControl

@export var battle_team: BattleTeam

var power_label: Label

func _ready():
	power_label = Label.new()
	power_label.add_theme_font_size_override("font_size", 40)
	power_label.add_theme_color_override("font_color", Color.BLACK) #Color(30.0/255.0, 30.0/255.0, 30.0/255.0, 1.0))
	power_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	power_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_child(power_label)

func _process(_delta):
	power_label.size = size
	if battle_team != null:
		power_label.text = "" + str(battle_team.power)
