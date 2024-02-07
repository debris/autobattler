shader_type canvas_item;

void fragment() {
	// distance from the vertical center
	float center = abs(UV.y * 2.0 - 1.0);
	// fade out the edges, 1.5 is arbitrary
	COLOR.a = 1.5 * (1.0 - center);
}

