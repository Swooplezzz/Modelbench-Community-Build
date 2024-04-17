/// painter_apply_huesat()

function painter_apply_huesat()
{
	surface_set_target(color_surf)
	{
		draw_clear_alpha(c_black,0)
		draw_sprite(color_spr,0,0,0)
		render_shader_obj = shader_map[?shader_huesat]

		shader_set(shader_huesat)
		render_set_uniform("u_Position", 2 * pi - degtorad(hue))
		render_set_uniform("u_Position_s", sat/100)
		alphafix

		draw_surface(transform_surf,0,0)	
		shader_reset()
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()
	
	//Update the alpha mask.
	surface_set_target(alpha_surf)
	{
		draw_clear(c_black)

	    draw_sprite(alpha_spr,0,0,0)

		alphafix
		shader_set(shader_alphamask)
		draw_surface(transform_surf,0,0)	
		shader_reset()

		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target()
	
	if (sprite_exists(alpha_spr))
		sprite_delete(alpha_spr)
	alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

	if (sprite_exists(color_spr))
		sprite_delete(color_spr)
	color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)

	painter_create_final_spr();
	adjusting_hue = false;
	popup_close();
}