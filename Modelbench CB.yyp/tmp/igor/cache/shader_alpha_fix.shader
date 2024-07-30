/// shader_alpha_fix
/// @desc Renders everything black with only alpha

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec4 in_Wave;
attribute vec3 in_Tangent;

varying vec2 vTexCoord;

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
	vTexCoord = in_TextureCoord;
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position + getWind(), 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform sampler2D uTexture;
uniform vec2 uTexScale;

varying vec2 vTexCoord;

void main()
{
	vec2 tex = fract(vTexCoord) * uTexScale;
	vec4 baseColor = texture2D(uTexture, tex);
	if (baseColor.a == 0.0)
		discard;
		
	gl_FragColor = vec4(0.0, 0.0, 0.0, baseColor.a);
}


