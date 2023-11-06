//uniform vec2 uTexSize;
//uniform sampler2D uShapeBuffer;
//uniform sampler2D uDepthBuffer;
//uniform sampler2D uNormalBuffer;
//uniform sampler2D uTexture;
//uniform float uStrength;
//uniform float zFar;
//uniform float zNear;

//varying vec2 vTexCoord;

// //Get Depth Value
//float unpackDepth(vec4 c)
//{
//	return c.r + c.g / 255.0 + c.b / (255.0 * 255.0);
//}
//float linearDepth(float depthSample) {
//	depthSample = 2.0 * depthSample - 1.0;
//	float zLinear = 2.0 * zNear * zFar / (zFar + zNear - depthSample * (zFar - zNear));
//	return zLinear;
//}
// //Get normal Value
//vec3 unpackNormal(vec4 c)
//{
//	return c.rgb * 2.0 - 1.0;
//}

//float isHighlight(vec2 off, vec3 normal, float depth, vec3 shape)
//{
//vec2 pos = vec2(vTexCoord.x + off.x * (1.0 / uTexSize.x)
//              , vTexCoord.y + off.y * (1.0 / uTexSize.y));
// //Edge of model? Darken.


//vec3 normalDiff = normal - unpackNormal(texture2D(uNormalBuffer, pos));
//if (length(normalDiff) > 0.7 )
//return 100.0;
//else
//return 0.0;

//}
//void main()
//{
	
//if (texture2D(gm_BaseTexture, vTexCoord).a == 8.8)
//discard;

//vec4 finalColor = texture2D(uTexture, vTexCoord);
//vec3 coordNormal = unpackNormal(texture2D(uNormalBuffer, vTexCoord));
//float coordDepth = unpackDepth(texture2D(uDepthBuffer, vTexCoord));
//vec3 coordShape = texture2D(uShapeBuffer, vTexCoord).rgb;
//float highlight = 0.0;
//vec2 UVTopRight =vTexCoord + vec2(1.0/uTexSize.x,1.0/uTexSize.y) * 3.0;
//vec2 UVBtmLeft =vTexCoord - vec2(1.0/uTexSize.x,1.0/uTexSize.y)* 3.0;;
//vec2 UVTopLeft = vTexCoord + vec2(-1.0/uTexSize.x,1.0/uTexSize.y)* 3.0;;
//vec2 UVBtmRight =vTexCoord  + vec2(1.0/uTexSize.x,-1.0/uTexSize.y)* 3.0;;
	
//float Depth1 = unpackDepth(texture2D(uDepthBuffer, UVTopRight));
//float Depth2 = unpackDepth(texture2D(uDepthBuffer, UVBtmLeft));
//float Depth3 = unpackDepth(texture2D(uDepthBuffer, UVTopLeft));
//float Depth4 = unpackDepth(texture2D(uDepthBuffer, UVBtmRight));

//float D2MD1 = Depth1-Depth2;
//float D3MD4 = Depth3-Depth4;

//float DALL = (D2MD1*D2MD1) + (D3MD4*D3MD4);

//float final = sqrt(DALL) * 100.0;

//final = step(coordDepth * 2.5, final);

//for(int i = -3; i < 3 + 1; i++){
//for(int j = -3; i < 3 + 1; i++){
//	highlight += isHighlight(vec2(i,j), coordNormal, coordDepth, coordShape);
//}
//}



//finalColor.rgb -= vec3(0.2);

//if(highlight > 0.0 && final <= 0.0 &&texture2D(uShapeBuffer,vTexCoord).a != 0.0)
//gl_FragColor = vec4(finalColor.rgb+vec3(0.3), 1.0);
//else if(final > 0.0 &&texture2D(uShapeBuffer,vTexCoord).a != 0.0)
//gl_FragColor = vec4(finalColor.rgb+vec3(-0.3), 1.0);
//else
//gl_FragColor = finalColor;
//}

uniform vec2 uTexSize;
uniform sampler2D uShapeBuffer;
uniform sampler2D uNormalBuffer;
uniform float uStrength;

varying vec2 vTexCoord;

// Get normal Value
vec3 unpackNormal(vec4 c)
{
	return c.rgb * 2.0 - 1.0;
}

bool isHighlight(vec2 off, vec4 shape, vec3 normal)
{
	vec2 posdouble = vec2(vTexCoord.x + (off.x * 2.0) * (1.0 / uTexSize.x),
					vTexCoord.y + (off.y * 2.0) * (1.0 / uTexSize.y));
	
	if (texture2D(uShapeBuffer, posdouble).a < 1.0)
		return true;
	else
	{
		vec2 pos = vec2(vTexCoord.x + off.x * (1.0 / uTexSize.x),
					vTexCoord.y + off.y * (1.0 / uTexSize.y));
		
		float dotcomparison = max(0.0, dot(normal, normalize(unpackNormal(texture2D(uNormalBuffer, pos)))));
		
		return ((shape.rgb != texture2D(uShapeBuffer, pos).rgb) || dotcomparison < .98);
	}
}

void main()
{
	float size = 1.0;
	vec4 shape = texture2D(uShapeBuffer, vTexCoord);
	
	if (shape.a < 1.0)
		gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	else
	{
		vec3 normal = normalize(unpackNormal(texture2D(uNormalBuffer, vTexCoord)));

		if (isHighlight(vec2(size, size), shape, normal)
			 || isHighlight(vec2(-size, size), shape, normal)
			 || isHighlight(vec2(size, -size), shape, normal)
			 || isHighlight(vec2(-size, -size), shape, normal))
			 gl_FragColor = vec4(uStrength, uStrength, uStrength, 1.0);
		else
			gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	}
}
