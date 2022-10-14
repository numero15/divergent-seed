shader_type spatial;

uniform sampler2D noise;
uniform sampler2D albedo;

void fragment(){
	ALBEDO = vec3(texture(albedo,UV*10.0).rgb);
}

void vertex(){
	VERTEX.y = texture(noise,UV).r*25.0;	
}