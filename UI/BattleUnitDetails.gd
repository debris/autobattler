extends CanvasLayer

@export var battle_query: BattleQuery

@onready var battle_unit_control = $Control/Unit

func _ready():
	battle_unit_control.battle_query = battle_query
