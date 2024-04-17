/// painter_done(inbounds)
/// @arg inbounds

function painter_done(inbounds)
{
	surface_set_target(colorsurf)
	{
		draw_clear_alpha(c_black,0)
		draw_sprite(colorspr,0,0,0)
	
		if (selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION)
		{
			alphafix
			shader_set(shader_colormask)
			draw_surface(transformsurf,0,0)	
			shader_reset()
			gpu_set_blendmode(bm_normal)
		}
	}
	surface_reset_target()
	
	//Update the alpha mask.
	surface_set_target(alphasurf)
	{
		draw_clear(c_black)

	    draw_sprite(alphaspr,0,0,0)
		if(selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION)
		{
			alphafix
			shader_set(shader_alphamask)
			draw_surface(transformsurf,0,0)	
			shader_reset()
		}
		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target()

	if (selection_moved && paint_tool_selected != e_paint.TRANSFORM_SELECTION)
	{
		if(sprite_exists(alphaspr))
			sprite_delete(alphaspr)
		alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

		if(sprite_exists(colorspr))
			sprite_delete(colorspr)
		colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
	}

	//if(!filling)
	painter_create_finalspr();

	if (painter_update_spr)
	{
		if (paint_tool_selected != e_paint.TRANSFORM_SELECTION)
		{
			painter_update_transform_sprite()
		}
	}
	if (mouse_left_released || mouse_right_released)
	{
		if(paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE)
		{
			painter_history_set("painting", finalspr, selectionspr, transformspr)
		}
	}
	
	if (keybinds[e_keybind.ELEMENT_DELETE].pressed && selection_active)
	{
		painter_history_set("painting", finalspr, selectionspr, transformspr)
	}
}