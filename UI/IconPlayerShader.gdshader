shader_type canvas_item;

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1. -smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void fragment() {
	vec3 color = vec3(circle(UV,0.8));
	COLOR.a = color.r * color.g * color.b;
}
