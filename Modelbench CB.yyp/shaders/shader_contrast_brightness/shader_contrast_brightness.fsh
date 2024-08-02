
varying vec2 vTexCoord;
varying vec4 vColor;

uniform float uContrast;
uniform float uBrightness;

uniform float u_colmask;
uniform sampler2D u_clipsampler;

void main()
{
    vec4 baseColor = texture2D(gm_BaseTexture, vTexCoord)*vColor;
    vec4 ogColor = baseColor;
	vec4 clip = texture2D(u_clipsampler, vTexCoord)*vColor;

	if(baseColor.a == 0.0) discard;
	// Brightness and contrast
	baseColor.rgb *= vec3(uContrast + 1.0);
	baseColor.rgb = clamp(baseColor.rgb, vec3(0.0), vec3(1.0));
	
	baseColor.rgb += vec3(uBrightness);
	
    if(u_colmask > 0.0)
	gl_FragColor = vec4(baseColor.rgb, 1.0);
	else if(clip.a > 0.0)
	gl_FragColor = ogColor;
	else
	gl_FragColor = vec4(baseColor.rgb * baseColor.a, baseColor.a );
}
