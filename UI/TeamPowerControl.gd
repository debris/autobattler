@tool
extends Control
class_name TeamPowerControl

@export var battle_team: BattleTeam
@export var horizontal_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_RIGHT:
	set(value):
		horizontal_alignment = value
		if is_node_ready():
			_update_alignment()

var power_label: Label
var background: ColorRect
var frame = Frame

var displayed_power: int = -1

func _update_alignment():
	power_label.horizontal_alignment = horizontal_alignment

func _ready():
	background = ColorRect.new()
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.color = Color(Color.BLACK, 180.0/255.0)
	add_child(background)
	
	frame = Frame.new()
	frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(frame)
	
	power_label = Label.new()
	power_label.add_theme_font_size_override("font_size", 40)
	power_label.add_theme_color_override("font_color", Color.WHITE) #Color(30.0/255.0, 30.0/255.0, 30.0/255.0, 1.0))
	power_label.horizontal_alignment = horizontal_alignment
	power_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_child(power_label)

func _process(_delta):
	power_label.position = Vector2(16, 0)
	power_label.size = size - Vector2(32, 0)
	background.size = size
	frame.size = size
	if battle_team != null:
		if displayed_power != -1 && displayed_power != battle_team.power:
			var change = battle_team.power - displayed_power
			show_diff_label(change)
		displayed_power = battle_team.power
		power_label.text = "" + str(battle_team.power)

func show_diff_label(value):
	var color = GameColors.green()
	if value < 0:
		color = GameColors.red()
	
	var label = Label.new()
	label.add_theme_font_size_override("font_size", 40)
	label.add_theme_color_override("font_color", color)
	label.position = Vector2(size.x + 16, 0)
	label.size = size
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	label.text = str(value)
	add_child(label)
	await get_tree().create_timer(DisplaySettings.default().step_time).timeout
	label.queue_free()
