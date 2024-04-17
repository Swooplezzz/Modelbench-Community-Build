/// painter_apply_huesat()

function painter_apply_huesat()
{
	surface_set_target(colorsurf)
	{
		draw_clear_alpha(c_black,0)
		draw_sprite(colorspr,0,0,0)
		render_shader_obj = shader_map[?shader_huesat]

		shader_set(shader_huesat)
		render_set_uniform("u_Position", 2 * pi - degtorad(hue))
		render_set_uniform("u_Position_s", sat/100)
		alphafix

		draw_surface(transformsurf,0,0)	
		shader_reset()
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()
	
	//Update the alpha mask.
	surface_set_target(alphasurf)
	{
		draw_clear(c_black)

	    draw_sprite(alphaspr,0,0,0)

		alphafix
		shader_set(shader_alphamask)
		draw_surface(transformsurf,0,0)	
		shader_reset()

		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target()
	
	if (sprite_exists(alphaspr))
		sprite_delete(alphaspr)
	alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)

	if (sprite_exists(colorspr))
		sprite_delete(colorspr)
	colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)

	painter_create_finalspr();
	editing_hue = false;
	popup_close();
}