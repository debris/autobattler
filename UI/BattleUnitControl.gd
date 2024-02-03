extends Control

@export var battle_unit: BattleUnit

@onready var name_label = $Name
@onready var def_label = $Def
@onready var dmg_label = $Dmg

func _ready():
	name_label.text = battle_unit.unit.base.name

func _process(delta):
	def_label.text = "DEF: " + str(battle_unit.def)
	dmg_label.text = "DMG: " + str(battle_unit.dmg)
