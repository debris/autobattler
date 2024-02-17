extends Control

@onready var content = $Content
@onready var name_label = $Content/Name
@onready var avatar = $Content/Avatar
@onready var dmg_label = $Content/Dmg
@onready var def_label = $Content/Def

func display_owned_unit(unit: OwnedUnit):
	if unit == null:
		content.visible = false
		return

	content.visible = true
	name_label.text = unit.base.name
	avatar.texture = unit.base.texture
	dmg_label.text = str(unit.dmg)
	def_label.text = str(unit.def)
