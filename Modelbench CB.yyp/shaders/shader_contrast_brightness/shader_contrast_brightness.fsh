
varying vec2 vTexCoord;

uniform float uContrast;
uniform float uBrightness;

uniform float u_colmask;
uniform sampler2D u_clipsampler;

void main()
{
    vec4 baseColor = texture2D(gm_BaseTexture, vTexCoord);
    vec4 ogColor = texture2D(gm_BaseTexture, vTexCoord);
	vec4 clip = texture2D(u_clipsampler, vTexCoord);

	if(baseColor.a == 0.0) discard;
	// Brightness and contrast
	baseColor.rgb = (baseColor.rgb - vec3(0.5)) * vec3(uContrast + 1.0) + vec3(uBrightness + 0.5);
	baseColor.rgb = clamp(baseColor.rgb, vec3(0.0), vec3(1.0));
	
	baseColor.rgb = 1.0 - (1.0 - baseColor.rgb);
	
    if(clip.a > 0.0)
	gl_FragColor = ogColor;
	else
	gl_FragColor = vec4(baseColor.rgb * baseColor.a, baseColor.a );
}
