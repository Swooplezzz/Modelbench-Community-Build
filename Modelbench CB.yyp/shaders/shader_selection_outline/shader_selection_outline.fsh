uniform vec2 uTexSize;
uniform vec4 uColor;
uniform float uSize;
uniform float uTime;
varying vec2 vTexCoord;
varying vec4 v_vColour;

bool isHighlight(vec2 off)
{
	vec2 pos = vec2(vTexCoord.x + off.x * (1.0 / uTexSize.x),
					vTexCoord.y + off.y * (1.0 / uTexSize.y));
	if(pos.x > 1.0 || pos.y > 1.0 || pos.x < 0.0 || pos.y < 0.0)
	return true;

	return (texture2D(gm_BaseTexture, pos).a > 0.0);
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
	if (texture2D(gm_BaseTexture, vTexCoord).a > 0.0)
		discard;
	else
	{
		if (checkHighlight(size))
			gl_FragColor = vec4( vec3(1.0)* blackOrWhitey, 1.0) ;
		else
			gl_FragColor =  vec4(uColor.xyz, (0.35+sin(uTime * 0.1) *0.05)) ;
	}
}
