/// painter_draw_apply()

function painter_draw_apply()
{
	// Update the surfaces and sprites after draw.
	if (mouse_left_released || mouse_right_released)
	{

		surface_set_target(alpha_surf)
		{
			draw_clear_alpha(c_black, 1)
			draw_sprite_ext(alpha_spr, 0, 0, 0, 1, 1, 0, c_white, 1)

			shader_set(shader_alphamask)
			alphafix
			draw_surface_ext(draw_surf, 0, 0, 1, 1, 0, c_white, paint_opacity)
			shader_reset()
			  
			gpu_set_colorwriteenable(true, true, true, true);
			gpu_set_blendmode(bm_normal);
		}
		surface_reset_target();
		
		surface_set_target(color_surf)
		{
			alphafix
			draw_clear_alpha(c_black, 0)

			draw_surface_ext(draw_surf,0,0,1,1,0,c_white, 1)
			draw_sprite(color_spr,0,0,0)

			shader_set(shader_premalpha)
			draw_surface_ext(draw_surf,0,0,1,1,0,c_white, paint_opacity)
			shader_reset()

			//draw_clear_alpha(c_black, 0)

			//gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);

			//gpu_set_colorwriteenable(false, false, false,true)
			//draw_sprite(color_spr,0,0,0)
			//gpu_set_colorwriteenable(true, true, true, false);

			//shader_set(shader_premalphacolmask)
			//draw_surface_ext(draw_surf,0,0,1,1,0,c_white, 1)

			//shader_reset()


			//draw_sprite(color_spr,0,0,0)

			//gpu_set_colorwriteenable(true, true, true, true);

			//shader_set(shader_premalpha)
			//draw_surface_ext(draw_surf,0,0,1,1,0,c_white, paint_opacity)
			//shader_reset()

			gpu_set_blendmode(bm_normal)
		}
		surface_reset_target()

		if (sprite_exists(alpha_spr))
			sprite_delete(alpha_spr)
		alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

		if (sprite_exists(color_spr))
			sprite_delete(color_spr)
		color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
		
		surface_set_target(draw_surf)
		{
			draw_clear_alpha(c_black, 0)
		}
		surface_reset_target();
		
		painter_update_spr = true;
	}
}