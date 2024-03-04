extends Control

@export var unit: BattleUnit:
	set(value):
		unit = value
		if is_node_ready():
			_update_icon()

@export var index: int = 0:
	set(value):
		index = value
		if is_node_ready():
			_update_index()

# rename to action
@export var skill_kind: Schedule.Kind:
	set(value):
		skill_kind = value
		if is_node_ready():
			_update_skill_kind()

@onready var icon: TextureRect = $Icon
@onready var skill_rect: ColorRect = $SkillRect
@onready var index_label: Label = $ColorRect/IndexLabel
@onready var display_tooltip: DisplayTooltip = $DisplayTooltip

func _ready():
	_update_icon()
	_update_index()
	_update_skill_kind()

func _update_icon():
	if unit != null:
		icon.texture = unit.texture
		_update_tooltip()

func _update_index():
	index_label.text = str(index)

func _update_skill_kind():
	skill_rect.color = GameColors.schedule_color(skill_kind)
	if unit != null:
		_update_tooltip()

func _update_tooltip():
	var skill_text = ""
	match skill_kind:
		Schedule.Kind.DMG: skill_text = "ATTACKS"
		Schedule.Kind.DEF: skill_text = "DEFENDS"
		Schedule.Kind.SKILL: skill_text = "USES SKILL"
	
	display_tooltip.text = unit.name + " " + tr(skill_text)
	