extends Control

signal selected

@export var unit: OwnedUnit

@onready var name_label = $NameLabel

func _ready():
	name_label.text = unit.base.name

func _on_select_pressed():
	selected.emit()
