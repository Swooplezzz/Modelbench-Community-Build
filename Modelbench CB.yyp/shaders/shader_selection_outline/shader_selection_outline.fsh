//
// Simple passthrough fragment shader
//
varying vec2 vTexCoord;
varying vec4 v_vColour;
vec2 uTexSize = vec2(100.0);
float isHighlight(vec2 off, vec4 shape)
{
	vec2 posdouble = vec2(vTexCoord.x + (off.x * 2.0) * (1.0 / uTexSize.x),
					vTexCoord.y + (off.y * 2.0) * (1.0 / uTexSize.y));
	
	if (texture2D(gm_BaseTexture, posdouble).a < 1.0)
		return 1.0;
	else
	{
		vec2 pos = vec2(vTexCoord.x + off.x * (1.0 / uTexSize.x),
					vTexCoord.y + off.y * (1.0 / uTexSize.y));
		if(((shape.rgb != texture2D(gm_BaseTexture, pos).rgb)))
		return 1.0;
	}
	return 0.0;
}
void main()
{
	vec4 shape = v_vColour * texture2D( gm_BaseTexture, vTexCoord );
	float highlight = 0.0;
	for(int i = -1; i < 1 + 1; i++){
			for(int j = -1; j < 1 + 1; j++){
				highlight += isHighlight(vec2(i,j), shape);
	        }
	}
	if (highlight > 0.0)
	  gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vTexCoord ) + vec4(1.0,.6,0.2,1.0);
	else
      gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vTexCoord );
}
