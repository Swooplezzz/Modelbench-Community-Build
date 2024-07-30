/// shader_draw_texture
/// Used when drawing a texture

attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 vTexCoord;
varying vec4 vColor;

void main()
{
	vColor = in_Colour;
	vTexCoord = in_TextureCoord;
	
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
uniform sampler2D uTexture;
uniform vec2 uTexScale;

varying vec2 vTexCoord;
varying vec4 vColor;

void main()
{
	vec2 tex = fract(vTexCoord) * uTexScale;
	
	vec4 color;
	color = texture2D(uTexture, tex);
	color *= vColor;
	
	gl_FragColor = color;
}

