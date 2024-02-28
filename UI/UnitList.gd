extends Control

signal selected_unit(unit: BattleUnit)

@export var units: Array[BattleUnit]
@export var selectable: bool = true

@onready var list = $LeftContianer/Control/ScrollBorders/ScrollContainer/UnitsContainer
@onready var name_filter = $LeftContianer/Control/NameFilter
@onready var unit_control = $RightContainer/Control/UnitControl

var sort_order: bool = true

func _ready():
	for unit in units:
		var entry = preload("res://UI/UnitListEntry.tscn").instantiate()
		entry.unit = unit
		entry.selected.connect(func():
			selected_unit.emit(units[entry.get_index()])
		)
		entry.mouse_entered.connect(func(): 
			# the order of units may change, so we always need to look at the latest version of the units list
			unit_control.unit = units[entry.get_index()]
		)
		entry.mouse_exited.connect(func():
			unit_control.unit = null
		)
		entry.selectable = selectable
		list.add_child(entry)

func _gui_input(event):
	var mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if rect.has_point(mouse_position):
		accept_event()
		if event.is_action_released("LeftClick"):
			queue_free()

func update_display():
	for i in units.size():
		list.get_child(i).unit = units[i]

func _on_name_button_pressed():
	units.sort_custom(func(a, b):
		if sort_order:
			return a.name > b.name
		else:
			return a.name < b.name
	)
	sort_order = !sort_order
	update_display()

func sort_by(kind: Schedule.Kind):
	units.sort_custom(func(a, b):
		var pattern = func(s): return s.kind == kind
		var to_binary = func(v): if v: return "1" else: return "0"
		var pos_a = ArrayIterator.new(a.schedules).until(pattern).count()
		var pos_b = ArrayIterator.new(b.schedules).until(pattern).count()
		if sort_order:
			if pos_a == pos_b:
				var a_str = "".join(ArrayIterator.new(a.schedules).find(pattern).get_value().data.map(to_binary))
				var b_str = "".join(ArrayIterator.new(b.schedules).find(pattern).get_value().data.map(to_binary))
				return a_str < b_str
			else:
				return pos_a > pos_b
		else:
			if pos_a == pos_b:
				var a_str = "".join(ArrayIterator.new(a.schedules).find(pattern).get_value().data.map(to_binary))
				var b_str = "".join(ArrayIterator.new(b.schedules).find(pattern).get_value().data.map(to_binary))
				return a_str > b_str
			else:
				return pos_a < pos_b
	)
	sort_order = !sort_order
	update_display()

func _on_skill_button_pressed():
	sort_by(Schedule.Kind.SKILL)

func _on_attack_button_pressed():
	sort_by(Schedule.Kind.DMG)

func _on_defence_button_pressed():
	sort_by(Schedule.Kind.DEF)

func _on_name_filter_text_changed():
	if name_filter.text.contains("\n"):
		name_filter.text = name_filter.text.replace("\n", "")
		name_filter.set_caret_column(name_filter.text.length())
		return
	
	for entry_control in list.get_children():
		if name_filter.text == null || name_filter.text == "":
			entry_control.visible = true
		else:
			entry_control.visible = entry_control.unit.name.to_lower().contains(name_filter.text.to_lower())
