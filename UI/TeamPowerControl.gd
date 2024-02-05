@tool
extends Control
class_name TeamPowerControl

@export var battle_team: BattleTeam

var power_label: Label
var background: ColorRect
var frame = Frame

func _ready():
	background = ColorRect.new()
	background.color = Color(30.0/255.0, 30.0/255.0, 30.0/255.0)
	add_child(background)
	
	frame = Frame.new()
	add_child(frame)
	
	power_label = Label.new()
	power_label.add_theme_font_size_override("font_size", 40)
	power_label.add_theme_color_override("font_color", Color.WHITE) #Color(30.0/255.0, 30.0/255.0, 30.0/255.0, 1.0))
	power_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	power_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_child(power_label)

func _process(_delta):
	power_label.size = size - Vector2(16, 0)
	background.size = size
	frame.size = size
	if battle_team != null:
		power_label.text = "" + str(battle_team.power)
