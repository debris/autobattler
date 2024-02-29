extends Sprite2D

static var shared_region_position = 255.0

func _process(_delta):
	var global_time = float(Time.get_ticks_msec()) / 1000.0;
	const CONCRETE_PACE: float = 25.0
	shared_region_position = -global_time * CONCRETE_PACE
	region_rect.position.y = shared_region_position
