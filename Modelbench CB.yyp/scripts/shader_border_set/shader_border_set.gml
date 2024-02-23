/// shader_border_set(color, size)
/// @arg color
/// @arg size

function shader_border_set(color, size, width, height, alpha, invert)
{
	render_set_uniform_vec2("uTexSize", width, height)
	
	render_set_uniform_color("uColor", color, alpha)

	render_set_uniform("uSize", size)
	render_set_uniform("uInvert", invert)
}
