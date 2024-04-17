///painter_clear_selection()

function painter_clear_selection()
{
	surface_set_target(draw_surf)
	{
		draw_clear(c_black)
	
		gpu_set_blendmode(bm_subtract)
		draw_surface(selection_surf,0,0)
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()

	painter_erase_apply()

	surface_set_target(draw_surf)
	{
		draw_clear_alpha(c_black, 0)
	}
	surface_reset_target()
}