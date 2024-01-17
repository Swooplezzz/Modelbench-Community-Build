/// shader_border_set(color, size)
/// @arg color
/// @arg size

function shader_border_set(color, size, width, height)
{
	render_set_uniform_vec2("uTexSize", width, height)
	
	render_set_uniform_color("uColor", color, 1)
	render_set_uniform("uSize", size)
}
