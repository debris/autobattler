extends Control

const MAX_ROTATION: float = 2.0

@export var battle_unit: BattleUnit

@onready var control = $Control
@onready var image_rect = $Control/ImageRect
@onready var name_label = $Control/Name
@onready var def_label = $Control/Def
@onready var dmg_label = $Control/Dmg

@onready var dmg_schedule_control = $Control/GridContainer/ScheduleDmg
@onready var def_schedule_control = $Control/GridContainer/ScheduleDef
@onready var skill_schedule_control = $Control/GridContainer/ScheduleSkill

var processed_logs = 0

func _ready():
	#control.rotation = deg_to_rad(randf_range(-MAX_ROTATION, MAX_ROTATION))
	#control.pivot_offset.x = randf_range(0, size.x)
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

	for i in battle_unit.logs.size() - processed_logs:
		var index_to_process = i + processed_logs
		_process_log(battle_unit.logs[index_to_process])

	processed_logs = battle_unit.logs.size()

# private
func _process_log(action: Action):
	if action is ActionTeamAttack:
		_display_notification("ATTACK: " + str(action.value), GameColors.red())
		_shake()
	
	if action is ActionTeamDefend:
		_display_notification("DEFEND: " + str(action.value), GameColors.green())
	
	if action is ActionIncreaseDmg:
		_display_notification("DMG: " + str(action.increase), GameColors.blue())

# private
func _shake():
	var tween = create_tween()
	tween.tween_property(control, "position", control.position + Vector2(0, 16.0), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(control, "position", control.position, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	#pass

func _display_notification(text: String, color: Color):
	var label = Label.new()
	label.add_theme_color_override("font_color", color)
	label.text = text
	add_child(label)
	await get_tree().create_timer(2.0).timeout
	if label != null:
		label.queue_free()
