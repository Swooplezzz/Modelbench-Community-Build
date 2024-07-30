/// shader_high_light_sun
/// @desc Add shadows from the sun

attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;
attribute vec4 in_Wave;
attribute vec3 in_Tangent;

uniform float uBrightness;
uniform int uIsGround;
uniform vec3 uSunAt;

uniform mat4 uLightMatrix;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vTexCoord;
varying vec4 vScreenCoord;
varying float vBrightness;

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
	vec3 off = getWind();
	vPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position + off, 1.0)).xyz;
	vNormal = (gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.0)).xyz;
	vTexCoord = in_TextureCoord;
	vScreenCoord = uLightMatrix * vec4(vPosition, 1.0);
	
	// Single normal for ground
	if (uIsGround > 0)
		vPosition = uSunAt;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position + off, 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
#define PI 3.14159265
#define TAU PI * 2.0
#define MAXSAMPLES 128

uniform sampler2D uTexture;
uniform vec2 uTexScale;
uniform vec4 uBlendColor;
uniform int uIsSky;

uniform vec3 uLightPosition;
uniform vec4 uLightColor;
uniform float uLightNear;
uniform float uLightFar;
uniform float uLightAmount;

uniform sampler2D uDepthBuffer;

uniform int uBlurQuality;
uniform float uBlurSize;
uniform int uIsGround;
uniform float uBrightness;

varying vec3 vPosition;
varying float vDepth;
varying vec3 vNormal;
varying vec2 vTexCoord;
varying vec4 vScreenCoord;

float unpackDepth(vec4 c)
{
	return c.r + c.g / 255.0 + c.b / (255.0 * 255.0);
}

void main()
{
	vec3 light;
	
	if (uIsSky > 0 || uIsGround > 0)
		light = vec3(1.0);
	else
	{
		// Diffuse factor
		float dif = max(0.0, dot(normalize(vNormal), normalize(uLightPosition - vPosition)));	
		dif = clamp(dif, 0.0, 1.0);
		
		float shadow = 0.0;
	
		if (dif > 0.0)
		{
			//dif *= uDiffuseBoost;
			
			float fragDepth = min(vScreenCoord.z, uLightFar);
			vec2 fragCoord = (vec2(vScreenCoord.x, -vScreenCoord.y) / vScreenCoord.z + 1.0) / 2.0;
		
			// Texture position must be valid
			if (fragCoord.x > 0.0 && fragCoord.y > 0.0 && fragCoord.x < 1.0 && fragCoord.y < 1.0)
			{
				// Blur size(Increase if there's light bleeding)
				float blurSize = uBlurSize;
				
				// Calculate bias
				float bias = 1.0 + (uLightFar / fragDepth) * blurSize;
			
				// Calculate sample size
				float sampleSize = blurSize / fragDepth;
			
				// Find shadow
				for (int i = 0; i < MAXSAMPLES; i++)
				{
					if (i < uBlurQuality)
					{
						// Sample from circle
						float angle = (float(i) / float(uBlurQuality)) * TAU;
						vec2 off = vec2(cos(angle), sin(angle));
					
						// Get sample depth
						vec2 sampleCoord = fragCoord + off * sampleSize;
						float sampleDepth = uLightNear + unpackDepth(texture2D(uDepthBuffer, sampleCoord)) * (uLightFar - uLightNear);
					
						// Add to shadow
						shadow += ((fragDepth - bias) > sampleDepth) ? 1.0 : 0.0;
					}
					else
						break;
				}
			
				shadow /= float(uBlurQuality);
			}
		}
	
		// Calculate light
		light = (uBrightness/uLightAmount) + (uLightColor.rgb * dif * (1.0 - shadow));
	}
	
	// Set final color
	vec2 tex = fract(vTexCoord) * uTexScale;
	vec4 baseColor = texture2D(uTexture, tex);
	gl_FragColor = vec4(light, uBlendColor.a * baseColor.a);
	
	if (gl_FragColor.a == 0.0)
		discard;
}

