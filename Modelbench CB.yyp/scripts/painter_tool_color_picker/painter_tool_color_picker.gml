/// painter_tool_color_picker(x, y)
/// @arg x
/// @arg y

function painter_tool_color_picker(xx, yy, mousebutton)
{
	if (paint_tool_selected = e_paint.PICK)
	{
		if (mousebutton = mb_left)
			paint_primary_color = surface_getpixel(colorsurf, xx + 1, yy + 1);
		if (mousebutton = mb_right)
			paint_secondary_color = surface_getpixel(colorsurf, xx + 1, yy + 1);
		
		if (mouse_left_released || mouse_right_released)
			add_recent_color(surface_getpixel(colorsurf, xx + 1, yy + 1));
	}
}