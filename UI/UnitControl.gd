extends Control

signal pressed

@onready var on_hover = $OnHover
@onready var content = $Content
@onready var name_label = $Content/Name
@onready var avatar = $Content/Avatar
@onready var dmg_label = $Content/Dmg
@onready var def_label = $Content/Def

func display_unit(unit):
	if unit == null:
		content.visible = false
		on_hover.visible = false
		return

	content.visible = true
	name_label.text = unit.name
	avatar.texture = unit.texture
	dmg_label.text = str(unit.dmg)
	def_label.text = str(unit.def)

func _ready():
	mouse_entered.connect(func():
		if content.visible && pressed.get_connections().size() > 0:
			on_hover.visible = true
			Sounds.play_hover()
	)

	mouse_exited.connect(func():
		on_hover.visible = false
	)

func _gui_input(event):
	if on_hover.visible && event.is_action_pressed("LeftClick"):
		pressed.emit()
