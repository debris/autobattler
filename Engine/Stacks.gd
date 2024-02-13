extends Resource
class_name Stacks

enum Kind {
	VIGILANT,
	POISON,
}

var inner: Dictionary

func _init():
	inner = {}
	for kind in Kind.keys():
		var k = kind.to_lower()
		inner[k] = 0

func set_value(kind: Kind, value: int):
	inner[Kind.keys()[kind].to_lower()] = value

func get_value(kind: Kind) -> int:
	return inner.get(Kind.keys()[kind].to_lower())

func increase_by(kind: Kind, value: int):
	var x = get_value(kind)
	set_value(kind, x + value)
