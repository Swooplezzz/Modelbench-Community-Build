/// painter_apply_huesat()

function painter_apply_huesat()
{
	var sizex, sizey;
	sizex = (selection_btmright[0] - selection_topleft[0]);
	sizey = (selection_btmright[1] - selection_topleft[1]);
	
	surface_set_target(color_surf)
	{
		alphafix
		draw_clear_alpha(c_black, 0)
		draw_sprite(color_spr,0,0,0)

		render_shader_obj = shader_map[?shader_huesat]

		shader_set(shader_huesat)
		render_set_uniform("u_Position", hue)
		render_set_uniform("u_Position_s", sat/100)
		render_set_uniform("u_Position_l", val/100)
		render_set_uniform("u_colmask", 1)
	
		draw_sprite_ext(transform_spr, 0, (selection_topleft[X]), (selection_topleft[Y]), sizex / selection_size[X], sizey / selection_size[Y], 0, c_white, 1)

		shader_reset()
		gpu_set_blendmode(bm_normal)
	}
	surface_reset_target()
	
	if(sprite_exists(alpha_spr))
		sprite_delete(alpha_spr)
	alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

	if(sprite_exists(color_spr))
		sprite_delete(color_spr)
	color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)

	painter_create_finalspr();
	adjusting_hue = false;
	popup_close();
}