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

		fill_buffer = buffer_create(paint_texture_width * paint_texture_height * 4, buffer_fixed, 1);
		selection_buffer = buffer_create(paint_texture_width * paint_texture_height * 4, buffer_fixed, 1);
		alpha_fill_buffer = buffer_create(paint_texture_width * paint_texture_height * 4, buffer_fixed, 1);
		
		buffer_get_surface(fill_buffer, color_surf, 0);
		buffer_get_surface(selection_buffer, selection_surf, 0);
		buffer_get_surface(alpha_fill_buffer, alpha_surf, 0);
		if(app_check_shift(false))
		draw_floodfill(color_surf, alpha_surf, xx + .5, yy + .5,surface_getpixel(color_surf, xx +1, yy +1), color, 0, color_get_red(surface_getpixel(alpha_surf, xx +1, yy +1)))
		else
		draw_floodfill_no_border(color_surf, alpha_surf, xx + .5, yy + .5,surface_getpixel(color_surf, xx +1, yy +1), color, 0, color_get_red(surface_getpixel(alpha_surf, xx +1, yy +1)))

		floodfill_frame_count = 0;
		filling = true;
		
		if (sprite_exists(color_spr))
			sprite_delete(color_spr)
		color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
		
		if (sprite_exists(alpha_spr))
			sprite_delete(alpha_spr)
		alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
	}
}