extends Control

const MAX_ROTATION: float = 2.0

@export var battle_query: BattleQuery

@onready var control = $Control
@onready var image_rect = $Control/ImageRect
@onready var name_label = $Control/Name
@onready var def_label = $Control/Def
@onready var dmg_label = $Control/Dmg

@onready var dmg_schedule_control = $Control/GridContainer/ScheduleDmg
@onready var def_schedule_control = $Control/GridContainer/ScheduleDef
@onready var skill_schedule_control = $Control/GridContainer/ScheduleSkill

var battle_unit: BattleUnit
var processed_logs = 0

func _ready():
	#control.rotation = deg_to_rad(randf_range(-MAX_ROTATION, MAX_ROTATION))
	#control.pivot_offset.x = randf_range(0, size.x)
	battle_unit = battle_query.get_this_unit()
	name_label.text = battle_unit.unit.base.name
	image_rect.texture = battle_unit.unit.base.texture
	dmg_schedule_control.schedule = battle_unit.unit.dmg_schedule
	dmg_schedule_control.schedule_pointer = battle_unit.dmg_schedule_pointer
	dmg_schedule_control.the_color = GameColors.red()
	def_schedule_control.schedule = battle_unit.unit.def_schedule
	def_schedule_control.schedule_pointer = battle_unit.def_schedule_pointer
	def_schedule_control.the_color = GameColors.green()
	skill_schedule_control.schedule = battle_unit.unit.skill_schedule
	skill_schedule_control.schedule_pointer = battle_unit.skill_schedule_pointer
	skill_schedule_control.the_color = GameColors.blue()

func _process(delta):
	def_label.text = "" + str(battle_unit.def)
	dmg_label.text = "" + str(battle_unit.dmg)

	for log in battle_query.get_logs(processed_logs):
		_process_log(log)

	processed_logs = battle_query.get_total_log_count()

# private
func _process_log(action: Log):
	if action is LogAttack:
		_display_notification("ATTACK: " + str(action.value), GameColors.red())
		_shake()
	
	if action is LogDefend:
		_display_notification("DEFEND: " + str(action.value), GameColors.green())
		_spring()
	
	if action is LogSkillUsed:
		_display_notification(str(action.name), GameColors.blue())

# private
func _shake():
	var tween = create_tween()
	tween.tween_property(control, "position", control.position + Vector2(0, 16.0), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(control, "position", control.position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _spring():
	var tween = create_tween()
	control.pivot_offset = Vector2(size.x / 2, size.y / 2)
	#tween.tween_property(control, "scale", Vector2(1.1, 1.1), 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	control.scale = Vector2(1.1, 1.1)
	tween.tween_property(control, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

func _display_notification(text: String, color: Color):
	var label = Label.new()
	label.add_theme_color_override("font_color", color)
	label.position = Vector2(0, dmg_label.position.y)
	label.size = Vector2(size.x, dmg_label.size.y)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.text = text
	control.add_child(label)
	await get_tree().create_timer(2.0).timeout
	if label != null:
		label.queue_free()
