/// shader_sky
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
	
	//vDepth = (distance(vPosition, campos) - 0.1) / (32000.0 - 0.1);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
}


//######################_==_YOYO_SHADER_MARKER_==_######################@~
varying vec2 vTexCoord;
varying vec3 vWorldNormal;
varying vec3 vPosition;
varying vec4 vColor;

uniform vec3 uCameraPosition;

uniform vec4 uColorTop;
uniform vec4 uColorBottom;
uniform float uHorizonPow;
uniform float uContrast;

#define Scale vec3(.8)
#define K 19.19
vec3 hash(vec3 a)
{
    a = fract(a * Scale);
    a += dot(a, a.yxz + K);
    return fract((a.xxy + a.yxx) * a.zyx);
}

void main()
{
	vec3 normal = vWorldNormal + (hash(vPosition) * 0.01);
	float middle = (1.0 - abs(dot(normal, vec3(0.0, 0.0, -1.0))));
	middle = clamp((middle + 0.25), 0.0, 1.0);
	
	if (dot(normal, vec3(0.0, 0.0, -1.0)) < 0.0)
		middle = 1.0;
	else
		middle = (1.0 - abs(dot(normal, vec3(0.0, 0.0, -1.0))));
	
	middle = pow(middle, uHorizonPow);
	
	vec4 final_color = vec4(mix(uColorTop.rgb, uColorBottom.rgb, middle), 1.0);
	final_color.rgb = (final_color.rgb - vec3(0.5)) * vec3(uContrast) + vec3(0.5);
	
    gl_FragColor = final_color;
	
	if (final_color.a == 0.0)
		discard;
}

