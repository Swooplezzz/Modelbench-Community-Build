/// shader_preview
/// Used when drawing a texture

attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec3 in_Normal;
attribute vec3 in_Wave;
attribute vec3 in_Tangent;

varying vec2 vTexCoord;
varying vec4 vColor;
varying vec3 vPosition;
varying vec3 vNormal;
varying vec3 vWorldNormal;

varying vec2 vN;

varying float vWind;

void main() {
	vNormal = in_Normal;
	vPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.0)).xyz;
	
	vWorldNormal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz);
	
	vColor = in_Colour;
    vTexCoord = in_TextureCoord;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
}


//######################_==_YOYO_SHADER_MARKER_==_######################@~
varying vec2 vTexCoord;
varying vec3 vWorldNormal;
varying vec3 vPosition;
varying vec4 vColor;

uniform vec3 uCameraPosition;

uniform vec4 uColorLight;
uniform vec4 uColorDark;
uniform vec3 uLightPosition;

uniform int uIsGround;

void main()
{
	vec4 final_color = vec4(uColorDark.rgb, 1.0);
	
	float fadesize = 1.0;
	float lightsize = 4250.0;
	
	if (uIsGround > 0)
		final_color.rgb += vec3(0.4) * pow(1.0 - clamp((distance(vPosition, vec3(0.0)) - 512.0 * (1.0 - fadesize)) / (512.0 * fadesize), 0.0, 1.0), 3.0);
	
	// Attenuation factor
	float att = 1.0 - clamp((distance(vPosition, uLightPosition) - lightsize * (1.0 - fadesize)) / (lightsize * fadesize), 0.0, 1.0);
	final_color.rgb += .1 * uColorLight.rgb * att;
	
	att = pow(att, 3.0);
	
	final_color.rgb = mix(final_color.rgb, uColorLight.rgb, att * 1.5); 
	
	//final_color.rgb += uColorLight.rgb * 1.0;//smoothstep(clamp(1.0 - (distance(vPosition, uLightPosition)/5000.0), 0.0, 1.0), 0.0, 1.0);
	
    gl_FragColor = final_color;
}

