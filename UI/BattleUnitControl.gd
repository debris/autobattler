extends Control

const MAX_ROTATION: float = 2.0

@export var battle_query: BattleQuery

@onready var control = $Control
@onready var active_control = $Control/ActiveControl
@onready var image_rect = $Control/Control/ImageRect
@onready var name_label = $Control/Name
@onready var def_label = $Control/Def
@onready var dmg_label = $Control/Dmg
@onready var dmg_bonus_label = $Control/DmgBonus
@onready var def_bonus_label = $Control/DefBonus

@onready var dmg_schedule_control = $Control/GridContainer/ScheduleDmg
@onready var def_schedule_control = $Control/GridContainer/ScheduleDef
@onready var skill_schedule_control = $Control/GridContainer/ScheduleSkill

var battle_unit: BattleUnit
var processed_logs = 0
var processed_round = -1
var processed_phase = 0
var default_modulate

func _ready():
	#control.rotation = deg_to_rad(randf_range(-MAX_ROTATION, MAX_ROTATION))
	#control.pivot_offset.x = randf_range(0, size.x)
	battle_unit = battle_query.get_this_unit()

func _process(delta):
	name_label.text = battle_unit.unit.base.name
	image_rect.texture = battle_unit.texture
	
	dmg_schedule_control.schedule = battle_unit.unit.dmg_schedule
	dmg_schedule_control.schedule_pointer = battle_unit.dmg_schedule_pointer
	dmg_schedule_control.the_color = GameColors.red()
	def_schedule_control.schedule = battle_unit.unit.def_schedule
	def_schedule_control.schedule_pointer = battle_unit.def_schedule_pointer
	def_schedule_control.the_color = GameColors.green()
	skill_schedule_control.schedule = battle_unit.unit.skill_schedule
	skill_schedule_control.schedule_pointer = battle_unit.skill_schedule_pointer
	skill_schedule_control.the_color = GameColors.blue()

	def_label.text = str(battle_unit.def)
	dmg_label.text = str(battle_unit.dmg)
	if battle_unit.dmg_bonus == 0:
		dmg_bonus_label.text = ""
	else:
		dmg_bonus_label.text = "x"
			
	if battle_unit.def_bonus == 0:
		def_bonus_label.text = ""
	else:
		def_bonus_label.text = "x"

	default_modulate = Color.WHITE
	if !battle_query.is_on_schedule():
		default_modulate = Color(Color.WHITE, 0.4)

	if processed_round != battle_query.get_round() || processed_phase != battle_query.get_phase():
		control.modulate = default_modulate
		processed_round = battle_query.get_round()
		processed_phase = battle_query.get_phase()

	for log in battle_query.get_logs(processed_logs):
		_process_log(log)

	processed_logs = battle_query.get_total_log_count()
	active_control.visible = battle_query.is_active() && battle_query.is_on_schedule()

# private
func _process_log(action: Log):
	if action is LogAttack:
		_display_notification("ATTACK", GameColors.red())
		_shake()
	
	if action is LogDefend:
		_display_notification("DEFEND", GameColors.green())
		_spring()
	
	if action is LogSkillUsed:
		_display_notification(str(action.skill.name), GameColors.blue())
	
	if action is LogDmgAdd || action is LogDmgBonusAdd || action is LogDefAdd || action is LogDefBonusAdd:
		var color = GameColors.green()
		if action.value < 0:
			color = GameColors.red()
		
		var tween = create_tween()
		tween.tween_property(control, "modulate", color, 0.25).set_ease(Tween.EASE_IN)
		tween.tween_property(control, "modulate", default_modulate, 0.25).set_ease(Tween.EASE_OUT)

# private
func _shake():
	var offset = Vector2(0, 32.0)
	var tween = create_tween()
	
	# bottom half of the screen
	if global_position.y > (648 / 2):
		offset *= -1
	
	image_rect.scale = Vector2(1.1, 1.1)
	control.position = control.position + offset
	tween.tween_property(control, "position", Vector2.ZERO, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(image_rect, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _spring():
	var tween = create_tween()
	image_rect.scale = Vector2(1.1, 1.1)
	tween.tween_property(image_rect, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
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

