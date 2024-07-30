/// shader_normals
/// @desc Blends all pixels by the given color factor

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec4 in_Wave;
attribute vec3 in_Tangent;

varying vec3 vPosition;
varying vec3 vNormal;
varying float vDepth;
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
	vNormal = in_Normal;
	vDepth = (gm_Matrices[MATRIX_WORLD_VIEW] * vec4(in_Position + off, 1.0)).z;
	vColor = in_Colour * uBlendColor;
	vTexCoord = in_TextureCoord;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position + off, 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform sampler2D uTexture;
uniform vec2 uTexScale;

//uniform vec4 uShape;

varying vec3 vPosition;
varying vec3 vNormal;
varying float vDepth;
varying vec4 vColor;
varying vec2 vTexCoord;

void main()
{
	vec2 tex = fract(vTexCoord) * uTexScale;
	vec4 baseColor = vColor * texture2D(uTexture, tex); // Get base
	
	// Discard if less than 1% opacity
	if (floor(baseColor.a * 255.0) / 250.0 < .005)
		discard;
	
	gl_FragColor = vec4((vNormal + 1.0) / 2.0, 1.0);
}

