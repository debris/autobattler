// based on https://www.shadertoy.com/view/lsBGzh

shader_type canvas_item;

uniform vec4 blood_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float percent: hint_range(0, 1.0) = 0.0;

float DE( vec2 pp, out bool blood, float t )
{
	pp.y += (
		.4 * sin(.5*2.3*pp.x+pp.y) +
		.2 * sin(.5*5.5*pp.x+pp.y) +
		0.1*sin(.5*13.7*pp.x)+
		0.06*sin(.5*23.*pp.x));
	
	pp += vec2(0.,0.4)*t;
	
	float thresh = 5.3;
	
	blood = pp.y > thresh;
	
	float d = abs(pp.y - thresh);
	// todo use proper implicit dist
	//d /= sqrt(1.+grad*grad);
	return d;
}

vec4 sceneColour( in vec2 pp, vec2 iResolution )
{
	float progress = -0.5 * percent - 1.5;
	
	// for progress to be -2 
	float endTime = 16.;
	float rewind = 2.;
	float t = mod( progress, endTime+rewind );
	
	if( t > endTime )
		t = endTime * (1.-(t-endTime)/rewind);
	
	bool blood;
	float d = DE( pp, blood, t );
	
	if( !blood ) {
		return vec4(0.0);
	} else {
		return blood_color;
	}
}

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = UV;
	uv.y *= -0.7;
	COLOR.rgba = sceneColour(uv, iResolution);
}

