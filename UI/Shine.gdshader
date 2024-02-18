// based on
// https://godotshaders.com/shader/2d-shine-highlight/

shader_type canvas_item;

uniform vec4 shine_color : source_color = vec4(1.0);
uniform float shine_speed : hint_range(-10.0, 10.0, 0.1) = 1.0;
uniform float shine_size : hint_range(0.01, 1.0, 0.01) = 0.01;
uniform float x_offset: hint_range(-1, 1) = 0;

void fragment() {
	float shine = step(1.0 - shine_size * 0.5, 0.5 + 0.5 * sin(-SCREEN_UV.x + x_offset - SCREEN_UV.y * 0.3 + TIME * shine_speed));
	COLOR.rgb = mix(COLOR.rgb, shine_color.rgb, shine * shine_color.a);
}