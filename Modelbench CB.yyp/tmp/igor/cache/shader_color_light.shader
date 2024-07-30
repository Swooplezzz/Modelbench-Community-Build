/// shader_color_light
/// @desc Blends all pixels by the given color factor

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec4 in_Wave;
attribute vec3 in_Tangent;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec4 vColor;
varying vec2 vTexCoord;

uniform vec4 uBlendColor;

// Wind
uniform float uTime;
uniform float uWindEnable;
uniform float uWindTerrain;
uniform float uWindSpeed;
uniform float uWindStrength;

vec3 getWind()
{
	return vec3(
		sin((uTime + in_Position.x * 10.0 + in_Position.y + in_Position.z) * (uWindSpeed / 5.0)) * max(in_Wave.x * uWindTerrain, uWindEnable) * uWindStrength,
		sin((uTime + in_Position.x + in_Position.y * 10.0 + in_Position.z) * (uWindSpeed / 7.5)) * max(in_Wave.x * uWindTerrain, uWindEnable) * uWindStrength,
		sin((uTime + in_Position.x + in_Position.y + in_Position.z * 10.0) * (uWindSpeed / 10.0)) * max(in_Wave.y * uWindTerrain, uWindEnable) * uWindStrength
	);
}

void main()
{
	vec3 off = getWind();
	vPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position + off, 1.0)).xyz;
	vNormal = (gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz;
	vColor = in_Colour * uBlendColor;
	vTexCoord = in_TextureCoord;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position + off, 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform sampler2D uTexture;
uniform vec2 uTexScale;

uniform vec4 uMixColor;
uniform float uBrightness;
uniform vec4 uHighlightColor;

uniform vec3 uCameraDirection;
uniform vec4 uAmbientColor;
uniform vec4 uLightColor;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec4 vColor;
varying vec2 vTexCoord;

void main()
{
	vec2 tex = fract(vTexCoord) * uTexScale;
	vec4 baseColor = vColor * texture2D(uTexture, tex); // Get base
	
	baseColor.rgb = mix(baseColor.rgb, uMixColor.rgb, uMixColor.a); // Mix
	baseColor.rgb = mix(baseColor.rgb, uHighlightColor.rgb, uHighlightColor.a); // Highlight
	
	// Lighting
	float dif;
	vec3 light;
	
	// Light 1 (Right)
	dif = clamp(max(0.0, dot(normalize(vNormal), cross(uCameraDirection, vec3(0.0, 0.0, 1.0)))), 0.0, 1.0);	
	light += (dif * uLightColor.rgb * .125);
	
	// Light 2 (Left)
	dif = clamp(max(0.0, dot(normalize(vNormal), cross(uCameraDirection, vec3(0.0, 0.0, -1.0)))), 0.0, 1.0);	
	light += (dif * uLightColor.rgb * .35);
	
	// Light 3 (From camera)
	dif = clamp(max(0.0, dot(normalize(vNormal), uCameraDirection)), 0.0, 1.0);	
	light += (dif * dif * uLightColor.rgb);
	
	// Light 4 (Top)
	dif = clamp(max(0.0, dot(normalize(vNormal), vec3(0.0, 0.0, 1.0))), 0.0, 1.0);	
	light += (dif * uLightColor.rgb * .8);
	
	// Light 5 (Bottom)
	dif = clamp(max(0.0, dot(normalize(vNormal), vec3(0.0, 0.0, -1.0))), 0.0, 1.0);	
	light += (dif * uLightColor.rgb * .4);
	
	light = mix((light + uAmbientColor.rgb), vec3(1.0), vec3(uBrightness));
	light = clamp(light, vec3(0.0), vec3(1.0));
	
	gl_FragColor = vec4(baseColor.rgb * light, baseColor.a);
	
	if (gl_FragColor.a == 0.0)
		discard;
}

