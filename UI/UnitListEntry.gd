extends Control

signal selected

@export var unit: OwnedUnit:
	set(value):
		unit = value
		if is_node_ready():
			update_display()

@onready var name_label = $NameLabel
@onready var serial_number_label = $SerialNumberLabel

func _ready():
	update_display()

func update_display():
	name_label.text = unit.base.name
	serial_number_label.text = unit.display_serial_number()

func _on_select_pressed():
	selected.emit()
