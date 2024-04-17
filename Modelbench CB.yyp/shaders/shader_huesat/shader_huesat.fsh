varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_Position;
uniform float u_Position_s;
uniform float u_Position_l;
uniform float u_colmask;
uniform sampler2D u_clipsampler;
#ifndef saturate
#define saturate(v) clamp(v,0.,1.)
//      clamp(v,0.,1.)
#endif
// https://en.wikipedia.org/wiki/YIQ

const mat3 rgb2yiq = mat3(0.299, 0.587, 0.114, 0.595716, -0.274453, -0.321263, 0.211456, -0.522591, 0.311135);
const mat3 yiq2rgb = mat3(1.0, 0.9563, 0.6210, 1.0, -0.2721, -0.6474, 1.0, -1.1070, 1.7046);


float EPSILON = 1e-10;
vec3 HUEtoRGB(float hue)
{
    // Hue [0..1] to RGB [0..1]
    // See http://www.chilliant.com/rgb2hsv.html
    vec3 rgb = abs(hue * 6. - vec3(3, 2, 4)) * vec3(1, -1, -1) + vec3(-1, 2, 2);
    return clamp(rgb, 0., 1.);
}
vec3 RGBtoHCV(vec3 rgb)
{
    // RGB [0..1] to Hue-Chroma-Value [0..1]
    // Based on work by Sam Hocevar and Emil Persson
    vec4 p = (rgb.g < rgb.b) ? vec4(rgb.bg, -1., 2. / 3.) : vec4(rgb.gb, 0., -1. / 3.);
    vec4 q = (rgb.r < p.x) ? vec4(p.xyw, rgb.r) : vec4(rgb.r, p.yzx);
    float c = q.x - min(q.w, q.y);
    float h = abs((q.w - q.y) / (6. * c + EPSILON) + q.z);
    return vec3(h, c, q.x);
}

vec3 RGBtoHSL(vec3 rgb)
{
    // RGB [0..1] to Hue-Saturation-Lightness [0..1]
    vec3 hcv = RGBtoHCV(rgb);
    float z = hcv.z - hcv.y * 0.5;
    float s = hcv.y / (1. - abs(z * 2. - 1.) + EPSILON);
    return vec3(hcv.x, s, z);
}

vec3 rgb2hsl(vec3 c){
	float cMin=min(min(c.r,c.g),c.b),
	      cMax=max(max(c.r,c.g),c.b),
	      delta=cMax-cMin;
	vec3 hsl=vec3(0.,0.,(cMax+cMin)/2.);
	if(delta!=0.0){ //If it has chroma and isn't gray.
		if(hsl.z<.5){
			hsl.y=delta/(cMax+cMin); //Saturation.
		}else{
			hsl.y=delta/(2.-cMax-cMin); //Saturation.
		}
		float deltaR=(((cMax-c.r)/6.)+(delta/2.))/delta,
		      deltaG=(((cMax-c.g)/6.)+(delta/2.))/delta,
		      deltaB=(((cMax-c.b)/6.)+(delta/2.))/delta;
		//Hue.
		if(c.r==cMax){
			hsl.x=deltaB-deltaG;
		}else if(c.g==cMax){
			hsl.x=(1./3.)+deltaR-deltaB;
		}else{ //if(c.b==cMax){
			hsl.x=(2./3.)+deltaG-deltaR;
		}
		hsl.x=fract(hsl.x);
	}
	return hsl;
}

vec3 hue2rgb(float hue){
	hue=fract(hue);
	return saturate(vec3(
		abs(hue*6.-3.)-1.,
		2.-abs(hue*6.-2.),
		2.-abs(hue*6.-4.)
	));
}
vec3 hsl2rgb(vec3 hsl){
	if(hsl.y==0.){
		return vec3(hsl.z); //Luminance.
	}else{
		float b;
		if(hsl.z<.5){
			b=hsl.z*(1.+hsl.y);
		}else{
			b=hsl.z+hsl.y-hsl.y*hsl.z;
		}
		float a=2.*hsl.z-b;
		return a+hue2rgb(hsl.x)*(b-a);
		/*vec3(
			hueRamp(a,b,hsl.x+(1./3.)),
			hueRamp(a,b,hsl.x),
			hueRamp(a,b,hsl.x-(1./3.))
		);*/
	}
}

vec3 HSLtoRGB(vec3 hsl)
{
    // Hue-Saturation-Lightness [0..1] to RGB [0..1]
    vec3 rgb = HUEtoRGB(hsl.x);
    float c = (1. - abs(2. * hsl.z - 1.)) * hsl.y;
    return (rgb - 0.5) * c + hsl.z;
}

void main()
{
    vec4 tColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    vec4 clip = texture2D(u_clipsampler, v_vTexcoord) * v_vColour;

	if(tColor.a == 0.0) discard;
	//vec3 color;
    //float Max = max(tColor.r, max(tColor.g, tColor.b)); // get max channel of pixel
    //float Min = min(tColor.r, min(tColor.g, tColor.b)); // get min channel of pixel
    //float Sat = Min/Max; // get current saturation of pixel
	//Sat = clamp(Sat, 0.0, 1.0);
    //// set saturation to pixel that depends on Position uniform
    //color.r = clamp(Max-(Max-tColor.r)/Sat*(u_Position_s), 0.0, 1.); // for red channel
    //color.g = clamp(Max-(Max-tColor.g)/Sat*(u_Position_s), 0.0, 1.); // for green channel
    //color.b = clamp(Max-(Max-tColor.b)/Sat*(u_Position_s), 0.0, 1.); // for blue channel
	
    //vec3 yColor = (color.rgb ) * rgb2yiq; 

    //float originalHue = atan(yColor.b, yColor.g);
    //float finalHue = originalHue + u_Position;

    //float chroma = sqrt(yColor.b * yColor.b + yColor.g * yColor.g);
	
    //vec3 yFinalColor = vec3(yColor.r, chroma * cos(finalHue), chroma  * sin(finalHue));
	//vec3 col = yFinalColor * yiq2rgb;
	//col = adjustValue(col);
	vec3 vHSV = vec3(u_Position, u_Position_s , u_Position_l);
    vec3 fragRGB = tColor.rgb;
    vec3 fragHSV = rgb2hsl(fragRGB).xyz;
    fragHSV.x += vHSV.x / 360.0;
    fragHSV.y *= vHSV.y;
	
	if(u_Position_l > 0.0)
    fragHSV.z += vHSV.z;
	else
	fragHSV.z *= (vHSV.z + 1.0);
    fragHSV.x = mod(fragHSV.x, 1.0);


    fragRGB = hsl2rgb(fragHSV);
	if(u_colmask > 0.0)
		gl_FragColor = vec4(fragRGB, 1.0);
	else if(clip.a > 0.0)
		gl_FragColor = tColor;
	else
	gl_FragColor = vec4(fragRGB * tColor.a, tColor.a );
}
