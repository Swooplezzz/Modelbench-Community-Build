/// painter_done(inbounds)
/// @arg inbounds

function painter_done(inbounds)
{
	surface_set_target(color_surf)
	{
		draw_clear_alpha(c_black, 0)
		draw_sprite(color_spr, 0, 0, 0)
	
		if ((selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION) || selection_moved && (adjusting_brightness_contrast || adjusting_hue))
		{
			alphafix
			shader_set(shader_colormask)
			draw_surface(transform_surf, 0, 0)	
			shader_reset()
			gpu_set_blendmode(bm_normal)

		}
	}
	surface_reset_target()
	
	// Update the alpha mask
	surface_set_target(alpha_surf)
	{
		draw_clear(c_black)

	    draw_sprite(alpha_spr, 0, 0, 0)
		if ((selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION)|| selection_moved && (adjusting_brightness_contrast || adjusting_hue))
		{
			alphafix
			shader_set(shader_alphamask)
			draw_surface(transform_surf, 0, 0)	
			shader_reset()
		}
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()

	if (selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION || selection_moved && (adjusting_brightness_contrast || adjusting_hue))
	{
		if (sprite_exists(alpha_spr))
			sprite_delete(alpha_spr)
		alpha_spr = sprite_create_from_surface(alpha_surf, 0, 0, surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

		if (sprite_exists(color_spr))
			sprite_delete(color_spr)
		color_spr = sprite_create_from_surface(color_surf, 0, 0, surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
	}

	if (painter_update_spr || selection_moved && (adjusting_brightness_contrast || adjusting_hue))
	painter_create_final_spr()

	if (painter_update_spr)
		if (paint_tool_selected != e_paint.TRANSFORM_SELECTION || (adjusting_brightness_contrast || adjusting_hue))
			painter_update_transform_sprite()
	
	if (mouse_left_released || mouse_right_released)
		if (paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE || paint_tool_selected = e_paint.SHAPE)
			painter_history_set("painting", final_spr, selection_spr, transform_spr)
	
	if (keybinds[e_keybind.ELEMENT_DELETE].pressed && selection_active)
		painter_history_set("painting", final_spr, selection_spr, transform_spr)
}