//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 vTexCoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    vTexCoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform vec2 uTexSize;
uniform vec4 uColor;
uniform float uSize;
uniform float uTime;
uniform float uInvert;
varying vec2 vTexCoord;
varying vec4 v_vColour;

bool isHighlight(vec2 off)
{
	vec2 pos = vec2(vTexCoord.x + off.x * (1.0 / uTexSize.x),
					vTexCoord.y + off.y * (1.0 / uTexSize.y));
	if(pos.x > 1.0 || pos.y > 1.0 || pos.x < 0.0 || pos.y < 0.0)
	return true;
	
	if(uInvert == 0.0)
	return (texture2D(gm_BaseTexture, pos).a > 0.0);
	else
	return (texture2D(gm_BaseTexture, pos).a < 1.0);
	
	return false;

}

bool checkHighlight(float size)
{
	return (isHighlight(vec2(size, size)) || isHighlight(vec2(-size, size)) || isHighlight(vec2(size, -size)) || isHighlight(vec2(-size, -size)));
}

void main()
{
	float blackOrWhitex = 0.0;
	float blackOrWhitey = 0.0;

	if(sin((vTexCoord.y* uTexSize.y + vTexCoord.x* uTexSize.x) * 0.5 + uTime * 0.05)  >0.0){
	blackOrWhitey = 1.0;	
	}
	
	float size = uSize;
	if ((texture2D(gm_BaseTexture, vTexCoord).a > 0.0 && uInvert == 0.0) || (texture2D(gm_BaseTexture, vTexCoord).a < 1.0 && uInvert == 1.0))
		discard;
	else
	{
		if (checkHighlight(size))
			gl_FragColor = vec4( vec3(1.0)* blackOrWhitey, 1.0) ;
		else
			gl_FragColor =  vec4(uColor.xyz, (uColor.a+sin(uTime * 0.1) *0.05)) ;
	}
}

