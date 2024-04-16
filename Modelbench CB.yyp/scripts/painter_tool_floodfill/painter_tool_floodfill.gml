/// painter_tool_floodfill(x, y, mousebutton)
/// @arg x
/// @arg y
/// @arg mousebutton

function painter_tool_floodfill(xx, yy, mousebutton)
{
	if (paint_tool_selected = e_paint.FILL && !filling)
	{
		var color = (mousebutton = mb_left ? paint_primary_color : paint_secondary_color)
		if (painter_main_color = 1)
			color = (mousebutton = mb_left ? paint_secondary_color : paint_primary_color)

		fill_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
		selection_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
		alpha_fill_buffer = buffer_create(texturewidth * textureheight * 4, buffer_fixed, 1);
		
		buffer_get_surface(fill_buffer, colorsurf, 0);
		buffer_get_surface(selection_buffer, selectionsurf, 0);
		buffer_get_surface(alpha_fill_buffer, alphasurf, 0);
		
		draw_floodfill_add(colorsurf, alphasurf, xx + .5, yy + .5, surface_getpixel(colorsurf, xx + 1, yy + 1), color, 0, color_get_red(surface_getpixel(alphasurf, xx + 1, yy + 1)))
		filling = true;
		
		if (sprite_exists(colorspr))
			sprite_delete(colorspr)
		colorspr = sprite_create_from_surface(colorsurf, 0, 0, surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
		
		if (sprite_exists(alphaspr))
			sprite_delete(alphaspr)
		alphaspr = sprite_create_from_surface(alphasurf, 0, 0, surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
	}
}