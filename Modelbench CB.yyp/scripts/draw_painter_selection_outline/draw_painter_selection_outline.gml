/// draw_painter_selection_outline(color, size, width, height, alpha, invert)
/// @arg color
/// @arg size
/// @arg width
/// @arg height
/// @arg alpha
/// @arg invert

function draw_painter_selection_outline(color, size, width, height, alpha, invert)
{
	gpu_set_texrepeat(false)
	 
	render_shader_obj = shader_map[?shader_selection_outline]
	with (render_shader_obj)
		shader_use()
	
	shader_border_set(color, size, width, height, alpha, invert)
	 
	draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 1)

	with (render_shader_obj)
		shader_clear()
	gpu_set_texrepeat(true)
}