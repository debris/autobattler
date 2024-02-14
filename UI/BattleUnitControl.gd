extends Control

@export var battle_query: BattleQuery
@export var click_to_show_details = true
@export var with_battle_logs = true

@onready var control = $Control
@onready var on_hover = $Control/OnHover
@onready var active_control = $Control/ActiveControl
@onready var active_on_schedule = $Control/ActiveOnSchedule

@onready var content = $Control/Content
@onready var image_rect = $Control/Content/ImageRect
@onready var name_label = $Control/Content/Name
@onready var def_label = $Control/Content/Def
@onready var dmg_label = $Control/Content/Dmg
@onready var dmg_bonus_label = $Control/Content/DmgBonus
@onready var def_bonus_label = $Control/Content/DefBonus

@onready var schedules_list = $Control/Content/Schedules
@onready var schedule_control2 = $Control/Content/Schedules/Schedule2
@onready var schedule_control1 = $Control/Content/Schedules/Schedule1
@onready var schedule_control0 = $Control/Content/Schedules/Schedule0

var display_settings: DisplaySettings
var battle_unit: BattleUnit
var logs_iterator: Iterator

func should_display_as_enemy() -> bool:
	return global_position.y < 324

func _ready():
	display_settings = DisplaySettings.default()
	
	mouse_entered.connect(func():
		if battle_unit != null:
			Sounds.play_hover()
			on_hover.visible = true
	)
	mouse_exited.connect(func():
		on_hover.visible = false
	)

func _process(_delta):
	# initialize only once
	if logs_iterator == null:
		logs_iterator = battle_query.get_all_logs_iterator()\
			.filter(func(battle_log):
				return battle_unit != null && (battle_log.unit.get_instance_id() == battle_unit.get_instance_id())\
			)
	
	battle_unit = battle_query.get_this_unit()
	if battle_unit == null:
		content.visible == false
		for content_child in content.get_children():
			content_child.visible = false
		active_control.visible = false
		active_on_schedule.visible = false
		
		return

	content.visible = true
	for content_child in content.get_children():
			content_child.visible = true
	name_label.visible = true

	name_label.text = battle_unit.name
	image_rect.texture = battle_unit.texture

	# always 3 schedules, let's grab them in reverse because of the rotation
	for i in 3:
		var index = 2 - i
		var schedule_control = schedules_list.get_child(index)
		schedule_control.schedule = battle_unit.schedules[i]
		schedule_control.phase = i
		schedule_control.schedule_pointer = battle_unit.schedule_pointer
		schedule_control.the_color = GameColors.schedule_color(battle_unit.schedules[i].kind)

	_display_bonuses()

	if !with_battle_logs:
		active_control.visible = false
		active_on_schedule.visible = false
		return

	logs_iterator.for_each(func(battle_log):
		_process_log(battle_log)
	)

	active_control.visible = battle_query.is_active()
	active_on_schedule.visible = battle_query.is_active() && battle_query.is_on_schedule()

func _gui_input(event):
	if click_to_show_details && on_hover.visible && event.is_action_released("LeftClick"):
		accept_event()
		Sounds.play_button_press()
		BattleController.default().show_details.emit(battle_query)

func _display_bonuses():
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
	tween.tween_property(control, "modulate", color, display_settings.step_time / 2).set_ease(Tween.EASE_IN)
	tween.tween_property(control, "modulate", Color.WHITE, display_settings.step_time / 2).set_ease(Tween.EASE_OUT)

# private
func _attack_animation():
	var offset = Vector2(0, 32.0)
	var tween = create_tween()
	
	if should_display_as_enemy():
		offset *= -1
	
	image_rect.scale = Vector2(1.1, 1.1)
	control.position = control.position - offset
	tween.tween_property(control, "position", Vector2.ZERO, display_settings.step_time / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(image_rect, "scale", Vector2.ONE, display_settings.step_time / 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _defend_animation():
	var tween = create_tween()
	image_rect.scale = Vector2(1.1, 1.1)
	tween.tween_property(image_rect, "scale", Vector2.ONE, display_settings.step_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)

# private
func _skill_animation():
	pass

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
	await get_tree().create_timer(display_settings.step_time).timeout
	if label != null:
		label.queue_free()

