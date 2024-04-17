/// painter_free()

function painter_free()
{
	surface_free(alpha_surf)
	surface_free(tex_surf)
	surface_free(color_surf)
	surface_free(draw_surf)
	surface_free(selection_surf)
}