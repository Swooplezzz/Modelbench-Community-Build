/// shader_shape_outline

attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;

varying vec2 vTexCoord;
varying vec4 vColor;

void main()
{
	vTexCoord = in_TextureCoord;
	vColor = in_Colour;
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1.0);
}
