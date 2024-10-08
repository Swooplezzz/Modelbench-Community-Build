/// painter_tool_color_picker(x, y, mousebutton)
/// @arg x
/// @arg y
/// @arg mousebutton

function painter_tool_color_picker(xx, yy, mousebutton)
{
	if (paint_tool_selected = e_paint.PICK)
	{
		if (mousebutton = mb_left)
			paint_primary_color = surface_getpixel(color_surf, xx + 1, yy + 1)
		if (mousebutton = mb_right)
			paint_secondary_color = surface_getpixel(color_surf, xx + 1, yy + 1)
		
		if (mouse_left_released || mouse_right_released)
		{
			var color = surface_getpixel(color_surf, xx + 1, yy + 1);
			add_recent_color(color)
			painter_colorpicker_update(null, color, true)
		}
	}
}