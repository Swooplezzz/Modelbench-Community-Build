/// painter_tool_erase(x, y, prevx, prevy)
/// @arg x
/// @arg y
/// @arg prevx
/// @arg prevy

function painter_tool_erase(xx, yy, prevx, prevy)
{
	surface_set_target(draw_surf)
	{
		// Erase
		if (paint_tool_selected = e_paint.ERASE)
		{
			draw_circle_color(xx, yy, (paint_width * 0.5) + 0.1, c_black, c_black, false);
			draw_line_width_color(prevx, prevy, xx, yy, paint_width + 0.2, c_black, c_black);
			
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf, 0, 0)
			gpu_set_blendmode(bm_normal)
			
			painter_erase_apply();
		}

		if (selection_active && keybinds[e_keybind.ELEMENT_DELETE].pressed)
		{
			draw_clear(c_black)
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf, 0, 0)
			gpu_set_blendmode(bm_normal)
			
			painter_erase_apply();
		}
	}
	surface_reset_target();
}