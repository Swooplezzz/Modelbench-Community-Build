/// painter_cpy_pst()

function painter_cpy_pst()
{
	if (keybinds[e_keybind.PASTE].pressed)
	{
		//show_debug_message(view_area_x)
		if (clipboard_has_img())
		{
			clipboard_dump_image(app.model_folder + "\\clipboard.png")
			
			var tempspr = sprite_add(app.model_folder + "\\clipboard.png", 1, false, false, 0, 0);
			
			var offset = vec2(mousexsnap, mouseysnap)
			offset[X] = snap(offset[X], 1)
			offset[Y] = snap(offset[Y], 1)
			offset[X] = clamp(offset[X], 0, paint_texture_width - sprite_get_width(tempspr))
			offset[Y] = clamp(offset[Y], 0, paint_texture_height - sprite_get_height(tempspr))
			
			if (selection_moved)
			{
				surface_set_target(color_surf)
				{
					draw_clear_alpha(c_black, 0)
					draw_sprite(color_spr, 0, 0, 0)
					
					alphafix
					shader_set(shader_premalpha);
					draw_surface(transform_surf, 0, 0)
					shader_reset()
					gpu_set_blendmode(bm_normal)
				}
				surface_reset_target();
				
				// Update the alpha mask.
				surface_set_target(alpha_surf)
				{
					draw_clear(c_black);
					
					draw_sprite(alpha_spr, 0, 0, 0)
					alphafix
					shader_set(shader_alphamask)
					draw_surface(transform_surf, 0, 0)
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
				}
				surface_reset_target();
				
				if (sprite_exists(alpha_spr))
					sprite_delete(alpha_spr)
				alpha_spr = sprite_create_from_surface(alpha_surf, 0, 0, surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0);
				
				if (sprite_exists(color_spr))
					sprite_delete(color_spr)
				color_spr = sprite_create_from_surface(color_surf, 0, 0, surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0);
				
				painter_create_final_spr()
			}
			
			surface_set_target(transform_surf)
			{
				draw_clear_alpha(c_black, 0)
				alphafix
				
				draw_sprite_ext(tempspr, 0, offset[X], offset[Y], 1, 1, 0, c_white, 1)
				
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target();
			
			if (sprite_exists(transform_spr))
				sprite_delete(transform_spr)
			transform_spr = sprite_create_from_surface(transform_surf, offset[X], offset[Y], sprite_get_width(tempspr), sprite_get_height(tempspr), false, false, 0, 0);
			
			surface_set_target(selection_surf);
			{
				draw_clear(c_black);

				gpu_set_blendmode(bm_subtract)
				shader_set(shader_selectionmask)
				draw_sprite_ext(tempspr, 0, offset[X], offset[Y], 1, 1, 0, c_white, 1)
				shader_reset()
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target()

			if (sprite_exists(selection_spr))
				sprite_delete(selection_spr)
			selection_spr = sprite_create_from_surface(selection_surf, 0, 0, paint_texture_width, paint_texture_height, false, false, 0, 0)
			
			selection_active = true
			selection_topleft = vec2(offset[X], offset[Y])
			selection_btmright = vec2(offset[X] + sprite_get_width(tempspr),offset[Y] +  sprite_get_height(tempspr))

			selection_size = vec2(selection_btmright[0] - selection_topleft[0], selection_btmright[1] - selection_topleft[1])
			selection_pos = point2D_copy(selection_topleft)
			selection_pos[X] += selection_size[X] / 2
			selection_pos[Y] += selection_size[Y] / 2
			painter_get_sel_trn_spr()
			selection_moved = true
			paint_tool_selected = e_paint.TRANSFORM_SELECTION
			sprite_delete(tempspr)
			painter_history_set("transform", final_spr, selection_spr, transform_spr , sel_trn_spr)

			#region dumped code
			// surface_set_target(color_surf){
			// draw_clear_alpha(c_black, 0)
			// shader_set(shader_colormask)
			// draw_sprite(tempspr,0,0,0)
			// shader_reset()

			// gpu_set_blendmode(bm_normal);
			// }
			//	surface_reset_target()
			// surface_set_target(alpha_surf){

			// draw_clear_alpha(c_black, 1)
			// shader_set(shader_alphamask)
			// alphafix
			// draw_sprite_ext(tempspr, 0,0,0,1,1,0, c_white, 1)
			// shader_reset()
			//	gpu_set_colorwriteenable(true, true, true, true);

			// gpu_set_blendmode(bm_normal);
			// }
			//	surface_reset_target()
			//	sprite_delete(tempspr)
			//	if(sprite_exists(color_spr))
			// sprite_delete(color_spr)
			// color_spr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
			//	if(sprite_exists(alpha_spr))
			// sprite_delete(alpha_spr)
			// alpha_spr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)
			#endregion

			sprite_delete(tempspr)
		}
	}
	if (keybinds[e_keybind.COPY].pressed && selection_active)
	{
		sprite_save(transform_spr, 0, app.model_folder + "\\clipboard.png")
		clipboard_load_image(app.model_folder + "\\clipboard.png")
	}
	if (keybinds[e_keybind.CUT].pressed && selection_active)
	{
		sprite_save(transform_spr, 0, app.model_folder + "\\clipboard.png")
		clipboard_load_image(app.model_folder + "\\clipboard.png")
		
		painter_clear_selection()
		painter_create_final_spr()
		surface_set_target(selection_surf)
		{
			draw_clear_alpha(c_black, 0)
			selection_topleft = vec2(0, 0)
			selection_btmright = vec2(0, 0)
			selection_active = false
		}
		surface_reset_target()
	}
	if (keybinds[e_keybind.ELEMENT_DELETE].pressed && selection_active)
	{
		painter_clear_selection()
		painter_create_final_spr()
		surface_set_target(selection_surf)
		{
			draw_clear_alpha(c_black, 0)
			selection_topleft = vec2(0, 0)
			selection_btmright = vec2(0, 0)
			selection_active = false
		}
		surface_reset_target()
	}
}
