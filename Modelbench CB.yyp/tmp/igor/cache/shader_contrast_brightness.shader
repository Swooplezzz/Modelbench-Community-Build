//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 vTexCoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    vTexCoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~

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

