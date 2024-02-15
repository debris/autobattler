shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float percent: hint_range(0, 1) = 0.0;

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1. -smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void fragment() {
	float size = percent * 2.0;
	vec4 x = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = x;
	vec3 color = vec3(circle(UV,size));
	COLOR.a = 1.0 - color.r * color.g * color.b;
}
