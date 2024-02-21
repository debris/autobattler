shader_type canvas_item;

float hex(in vec2 p){
    const float hexSize = .8660254;
    const vec2 s = vec2(1, 1.7320508);
    
    p = abs(p);
    return max(dot(p, s*.5), p.x) - hexSize;
}

void fragment() {
	vec2 uv = vec2((UV.x - 0.5) * 1.7320508, (UV.y - 0.5) * 2.);
    COLOR.a = smoothstep(.01, 0., hex(uv));
}
