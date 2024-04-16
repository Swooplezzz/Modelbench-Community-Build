/// painter_update_floodfill()

function painter_update_floodfill()
{
	if (array_length(fillarr) > 0)
	{
		var i = 0;
	
		for (var a = array_length(fillarr) - 1; a >= 0; a--)
		{
			if (i > 400)
				break;
				
			draw_floodfill(fillarr[a].surf,fillarr[a].alphasurf,fillarr[a].xx,fillarr[a].yy,fillarr[a].targ_color,fillarr[a].color, fillarr[a].side, fillarr[a].targ_alpha)	
			i++
			array_delete(fillarr, a,1)
		}

		if(sprite_exists(colorspr))
			sprite_delete(colorspr)
		colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
		
		if(sprite_exists(alphaspr))
			sprite_delete(alphaspr)
		alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
	}
	
	if (array_length(fillarr) = 0 && filling)
	{
		filling = false	
		
		buffer_set_surface(fill_buffer, colorsurf,0);
		buffer_set_surface(alpha_fill_buffer, alphasurf,0);
		buffer_delete(fill_buffer)
		buffer_delete(selection_buffer)
		buffer_delete(alpha_fill_buffer)
		
		if(sprite_exists(colorspr))
			sprite_delete(colorspr)
		colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
		
		if(sprite_exists(alphaspr))
			sprite_delete(alphaspr)
		alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
		
		painter_create_finalspr()
		painter_history_set("painting", finalspr, selectionspr, transformspr)
	}
}