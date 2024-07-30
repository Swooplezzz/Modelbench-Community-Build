/// shader_ground

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec4 in_Wave;
attribute vec3 in_Tangent;

varying vec3 vPosition;

void main()
{
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
	vPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.0)).xyz;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform vec3 uCameraPosition;
uniform int uFade;
uniform vec4 uFadeColor;
uniform float uFadeStart;
uniform float uFadeEnd;
uniform vec4 uBlendColor;

varying vec3 vPosition;

void main()
{
	float fade = 0.0;
	
	if (uFade > 0)
	{
		float dis = distance(vPosition.xyz, uCameraPosition.xyz);
		fade = clamp((dis - uFadeStart) / (uFadeEnd - uFadeStart), 0.0, 1.0);
	
		float angle = 1.0 - dot(vec3(0.0, 0.0, 1.0), normalize(uCameraPosition - vPosition));
		float angleFade = clamp((angle - 0.9) / (1.0 - 0.9), 0.0, 1.0);
	
		fade = clamp(fade + angleFade, 0.0, 1.0);
	
		if (fade > .999)
			discard;
	}
	
	gl_FragColor = vec4(mix(uBlendColor.rgb, uFadeColor.rgb, vec3(fade)), 1.0);
}

