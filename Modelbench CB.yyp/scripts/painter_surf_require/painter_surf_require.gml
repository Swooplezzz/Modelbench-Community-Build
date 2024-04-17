/// painter_surf_require()

function painter_surf_require()
{
	tex_surf = surface_require(tex_surf, paint_texture_width, paint_texture_height)
	draw_surf = surface_require(draw_surf, paint_texture_width, paint_texture_height)
	alpha_surf = surface_require(alpha_surf, paint_texture_width, paint_texture_height)
	color_surf = surface_require(color_surf, paint_texture_width, paint_texture_height)
	selection_surf = surface_require(selection_surf, paint_texture_width, paint_texture_height)
	transform_surf = surface_require(transform_surf, paint_texture_width, paint_texture_height)
}