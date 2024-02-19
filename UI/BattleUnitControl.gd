extends Control

signal pressed(battle_unit)

@export var battle_query: BattleQuery
@onready var unit_control = $UnitControl

var display_settings: DisplaySettings
var battle_unit: BattleUnit
var logs_iterator: Iterator

func should_display_as_enemy() -> bool:
	return global_position.y < 160

func _ready():
	display_settings = DisplaySettings.default()
	unit_control.pressed.connect(func(_unit):
		pressed.emit(battle_unit)
	)

func _process(_delta):
	# initialize only once
	if logs_iterator == null:
		logs_iterator = battle_query.get_all_logs_iterator()\
			.filter(func(battle_log):
				return battle_unit != null && (battle_log.unit.get_instance_id() == battle_unit.get_instance_id())\
			)
	
	battle_unit = battle_query.get_this_unit()
	unit_control.unit = battle_unit
	
	if battle_unit == null:
		return

	# always 3 schedules, let's grab them in reverse because of the rotation
	for i in 3:
		var index = i
		var schedule_control = unit_control.schedules.get_child(index)
		schedule_control.schedule = battle_unit.schedules[i]
		schedule_control.phase = i
		schedule_control.schedule_pointer = battle_unit.schedule_pointer

	#_display_bonuses()

	logs_iterator.for_each(func(battle_log):
		_process_log(battle_log)
	)

	if battle_query.is_active():
		unit_control.scale = Vector2(1.1, 1.1)
	else:
		unit_control.scale = Vector2(1.0, 1.0)

	# TODO: REDO

#TODO: REDO
#func _display_bonuses():
	#def_label.text = str(battle_unit.def)
	#dmg_label.text = str(battle_unit.dmg)
#
	#if battle_unit.dmg_bonus == 0:
		#dmg_bonus_label.text = ""
	#else:
		#dmg_bonus_label.text = "x"
				#
	#if battle_unit.def_bonus == 0:
		#def_bonus_label.text = ""
	#else:
		#def_bonus_label.text = "x"

# private
func _process_log(action: Log):
	if !action.valid:
		_display_notification("PREVENTED", GameColors.red())
		_blink(GameColors.red())
		Sounds.play_action()
		# return so no more info is displayed
		return
	
	if action is LogAttack:
		_display_notification("ATTACK", GameColors.red())
		_attack_animation()
		Sounds.play_action()
	
	if action is LogDefend:
		_display_notification("DEFEND", GameColors.green())
		_defend_animation()
		Sounds.play_action()
	
	if action is LogSkillUsed:
		_display_notification(str(action.skill.name), GameColors.blue())
		_skill_animation()
		Sounds.play_action()
	
	if action is LogExhaustion:
		_display_notification("EXHAUSTED", GameColors.red())
		_blink(GameColors.red())
		Sounds.play_action()
	
	if action is LogPoison:
		_display_notification("POISON", GameColors.red())
		_blink(GameColors.red())
		Sounds.play_action()
	
	if action is LogDmgAdd || action is LogDmgBonusAdd || action is LogDefAdd || action is LogDefBonusAdd:
		var color = GameColors.green()
		if action.value < 0:
			color = GameColors.red()
		_blink(color)


func _blink(color: Color):
	var tween = create_tween()
	tween.tween_property(unit_control, "modulate", color, display_settings.step_time / 2).set_ease(Tween.EASE_IN)
	tween.tween_property(unit_control, "modulate", Color.WHITE, display_settings.step_time / 2).set_ease(Tween.EASE_OUT)

# private
func _attack_animation():
	var offset = Vector2(0, 32.0)
	var tween = create_tween()
	
	if should_display_as_enemy():
		offset *= -1
	
	unit_control.avatar.scale = Vector2(1.1, 1.1)
	unit_control.position = unit_control.position - offset
	tween.tween_property(unit_control, "position", Vector2.ZERO, display_settings.step_time / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(unit_control.avatar, "scale", Vector2.ONE, display_settings.step_time / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _defend_animation():
	var tween = create_tween()
	unit_control.avatar.scale = Vector2(1.1, 1.1)
	tween.tween_property(unit_control.avatar, "scale", Vector2.ONE, display_settings.step_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _skill_animation():
	pass

# private
func _display_notification(text: String, color: Color):
	var label = Label.new()
	label.add_theme_color_override("font_color", color)
	label.position = Vector2(0, size.y / 2.0)
	label.size = Vector2(size.x, 20.0)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 20)
	label.text = text
	unit_control.add_child(label)
	await get_tree().create_timer(display_settings.step_time).timeout
	if label != null:
		label.queue_free()

