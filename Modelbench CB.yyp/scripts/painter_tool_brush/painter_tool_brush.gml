/// painter_tool_brush(x, y, prevx, prevy, mousebutton)
/// @arg x
/// @arg y
/// @arg prevx
/// @arg prevy
/// @arg mousebutton

function painter_tool_brush(xx, yy, prevx, prevy, mousebutton)
{
	surface_set_target(draw_surf)
	{
		// Draw
		if (paint_tool_selected = e_paint.BRUSH)
		{
			var color = (mousebutton = mb_left ? paint_primary_color : paint_secondary_color)
			if (painter_main_color = 1)
				color = (mousebutton = mb_left ? paint_secondary_color : paint_primary_color)
		
			draw_circle_color(xx, yy, (paint_width * 0.5) + 0.1, color, color, false);
			draw_line_width_color(prevx, prevy, xx, yy, paint_width + 0.2, color, color);
		
			gpu_set_blendmode(bm_subtract)
			draw_set_color(c_black)
			draw_surface(selection_surf, 0, 0)
			gpu_set_blendmode(bm_normal)
		}
	}
	surface_reset_target();
}