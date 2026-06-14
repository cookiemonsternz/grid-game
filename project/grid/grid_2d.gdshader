shader_type spatial;

group_uniforms hex;
uniform float threshold;
uniform float size;

group_uniforms height;
uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;

varying vec2 tex_position;

#define FLAT_TOP_HEXAGON

#ifdef FLAT_TOP_HEXAGON
const vec2 s = vec2(1.7320508, 1.0);
#else
const vec2 s = vec2(1.0, 1.7320508);
#endif

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(141.13, 289.97)))*43758.5453);
}

float hex(vec2 p) {
	p = abs(p);
	
	#ifdef FLAT_TOP_HEXAGON
	return max(dot(p, s*0.5), p.y) * 2.0;
	#else
	return max(dot(p, s*0.5), p.x) * 2.0;
	#endif
}

vec4 get_hex(vec2 p) {
	#ifdef FLAT_TOP_HEXAGON
	vec4 hC = floor(vec4(p, p - vec2(1.0, 0.5))/s.xyxy) + 0.5;
	#else
	vec4 hC = floor(vec4(p, p - vec2(0.5, 1.0))/s.xyxy) + 0.5;
	#endif
	
	vec4 h = vec4(p - hC.xy*s, p - (hC.zw + 0.5)*s);
	
	return dot(h.xy, h.xy) < dot(h.zw, h.zw) 
		? vec4(h.xy, hC.xy) 
		: vec4(h.zw, hC.zw + 0.5);
}

void vertex() {
	tex_position = get_hex(VERTEX.xz * size).xy;
	float height = texture(noise, tex_position).x;
	VERTEX.y += height * height_scale;
}

void fragment() {
	//NORMAL_MAP = texture(normalmap, tex_position).xyz;
	
	//vec2 u = (FRAGCOORVIEWPORT_SIZE)
	//vec4 h = get_hex(UV * size);
	vec4 h = vec4(tex_position, 0.0, 0.0);
	float eDist = hex(h.xy);
	
	ALBEDO = eDist > threshold ? vec3(1.0) : vec3(0.0);
	//ALBEDO = vec3(tex_position * 0.1, 0.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
