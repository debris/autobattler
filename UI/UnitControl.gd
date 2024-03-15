# Control capable of displaying all unit types: `Unit`, `OwnedUnit` and `BattleUnit`
extends Control

signal pressed(unit)

@export var unit: Resource:
	set(value):
		unit = value
		if is_node_ready():
			display_unit()

@export var details_tooltips_enabled: bool = false:
	set(value):
		details_tooltips_enabled = value
		if is_node_ready():
			display_unit()

@onready var on_hover = $OnHover
@onready var content = $Content
@onready var name_label = $Content/Name
@onready var avatar = $Content/Avatar
@onready var dmg_label = $Content/Dmg
@onready var def_label = $Content/Def

@onready var tooltip_name = $Content/Name/DisplayTooltip
@onready var tooltip_dmg = $Content/Dmg/DisplayTooltip
@onready var tooltip_def = $Content/Def/DisplayTooltip

@onready var details = $Content/Details
@onready var details_list = $Content/Details/UnitDetailsList

func display_unit():
	if unit == null:
		content.visible = false
		on_hover.visible = false
		return

	# do not update details_list on every frame, only when presented

	content.visible = true
	name_label.text = unit.name
	avatar.texture = unit.texture
	dmg_label.text = str(unit.dmg)
	def_label.text = str(unit.def)
	
	tooltip_name.enabled = details_tooltips_enabled
	tooltip_dmg.enabled = details_tooltips_enabled
	tooltip_def.enabled = details_tooltips_enabled

func _ready():
	display_unit()
	mouse_entered.connect(func():
		if content.visible && pressed.get_connections().size() > 0:
			on_hover.visible = true
			z_index = 1
			details_list.unit = unit
			details.visible = true
			Sounds.play_hover()
	)

	mouse_exited.connect(func():
		on_hover.visible = false
		z_index = 0
		details.visible = false
	)

func _gui_input(event):
	if on_hover.visible && event.is_action_pressed("LeftClick"):
		pressed.emit(unit)
