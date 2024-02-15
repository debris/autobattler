// based on https://www.shadertoy.com/view/XsBfRW

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform float percent: hint_range(0, 1) = 0.0;

void fragment() {
	float progress = -2.7 * (1.0 - percent) + 1.8;
	
	float aspect = 1.0;
	float value;
	vec2 uv = UV;
	uv -= vec2(0.5, 0.5*aspect);
	float rot = radians(0.0);
	mat2 m = 1.0 * mat2(vec2(cos(rot), -sin(rot)), vec2(sin(rot), cos(rot)));
	uv  = m * uv;
	uv += vec2(0.5, 0.5*aspect);
	uv.y+=0.5*(1.0-aspect);
	vec2 pos = 10.0*uv;
	vec2 rep = fract(pos);
	float dist = 2.0*min(min(rep.x, 1.0-rep.x), min(rep.y, 1.0-rep.y));
	vec2 ruv = UV;
	float squareDist = 1.0 + pow(ruv.x, 3.0);
	float edge = sin(progress-squareDist*0.5)*0.5+0.5;
	edge = 2.0*fract(edge*0.5);
	value = fract (dist*2.0);
	value = mix(value, 1.0-value, step(1.0, edge));
	value *= 1.0-0.5*edge;
	edge = pow(abs(1.0-edge), 2.0);
	value = smoothstep( edge-0.05, edge, 0.95*value);
	value += squareDist*.1;
	vec4 x = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = x;
	COLOR.a = smoothstep(0.0, 1.0, 1.0 - clamp(value, 0.0, 1.0));
	//COLOR.a = 0.25*clamp(value, 0.0, 1.0);
}