/// painter_history()

function painter_history()
{
	if (keybinds[e_keybind.REDO].pressed)
	{
		if (painter_history_pos > 0)
		{
			painter_history_pos -= 1;
			if (sprite_exists(alpha_spr))
				sprite_delete(alpha_spr)
			if (sprite_exists(color_spr))
				sprite_delete(color_spr)
		
			final_spr = sprite_duplicate(painter_history[painter_history_pos].sprite)
		
			surface_set_target(alpha_surf)
			{
				draw_clear_alpha(c_black, 1)
				alphafix
				shader_set(shader_alphamask)
				draw_sprite(final_spr,0,0,0)
				shader_reset()
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target()
			
			surface_set_target(color_surf)
			{
				draw_clear_alpha(c_black, 0)
				shader_set(shader_colormask)
				draw_sprite(final_spr,0,0,0)
				shader_reset()
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target()
			
			color_spr = sprite_create_from_surface(color_surf,0,0,surface_get_width(color_surf),surface_get_height(color_surf), false, false,0,0)
			alpha_spr = sprite_create_from_surface(alpha_surf,0,0,surface_get_width(alpha_surf),surface_get_height(alpha_surf), false, false,0,0)
			painter_update_spr = true;
			
			if (painter_history[painter_history_pos].val = "selection")
				paint_tool_selected = e_paint.BOX_SELECT
			
			selection_spr = sprite_duplicate(painter_history[painter_history_pos].selsprite)
			surface_set_target(selection_surf)
			{
				draw_sprite(selection_spr,0,0,0)
			}
			surface_reset_target()
			
			transform_spr = sprite_duplicate(painter_history[painter_history_pos].trnsprite)
			
			if (painter_history[painter_history_pos].val = "transform")
			{
				paint_tool_selected = e_paint.TRANSFORM_SELECTION
				selection_moved = true
			}

			selection_topleft = painter_history[painter_history_pos].pos_tl;
			selection_pos = painter_history[painter_history_pos].selection_pos;
			selection_btmright = painter_history[painter_history_pos].pos_br;
			selection_size = painter_history[painter_history_pos].sel_size;
			sel_trn_spr = painter_history[painter_history_pos].seltrnsprite;
			selection_active = painter_history[painter_history_pos].sel_active;
			selection_rot = painter_history[painter_history_pos].selection_rot;
			
			if (!selection_active)
			{
				surface_set_target(selection_surf)
				{
					draw_clear_alpha(c_black,0)
					selection_topleft = vec2(0,0)
					selection_btmright = vec2(0,0)
				}
				surface_reset_target()	
			}
		}
	}
	else if (keybinds[e_keybind.UNDO].pressed)
	{
		if (painter_history_pos + 1< painter_history_amount)
		{
			painter_history_pos += 1;
			if(sprite_exists(alpha_spr))
				sprite_delete(alpha_spr)
			if(sprite_exists(color_spr))
				sprite_delete(color_spr)
		
			final_spr = sprite_duplicate(painter_history[painter_history_pos].sprite)
		
			surface_set_target(alpha_surf)
			{
				draw_clear_alpha(c_black, 1)
				alphafix
				shader_set(shader_alphamask)
				draw_sprite(final_spr,0,0,0)
				shader_reset()
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target()
			
			surface_set_target(color_surf)
			{
				draw_clear_alpha(c_black, 0)
				shader_set(shader_colormask)
				draw_sprite(final_spr,0,0,0)
				shader_reset()
				gpu_set_blendmode(bm_normal)
			}
			surface_reset_target()
			
			color_spr = sprite_create_from_surface(color_surf,0,0,surface_get_width(color_surf),surface_get_height(color_surf), false, false,0,0)
			alpha_spr = sprite_create_from_surface(alpha_surf,0,0,surface_get_width(alpha_surf),surface_get_height(alpha_surf), false, false,0,0)
			painter_update_spr = true;
			
			if(painter_history[painter_history_pos].val = "selection")
				paint_tool_selected = e_paint.BOX_SELECT
			
			selection_spr = sprite_duplicate(painter_history[painter_history_pos].selsprite)
			surface_set_target(selection_surf)
			{
				draw_sprite(selection_spr,0,0,0)
			}
			surface_reset_target()
			
			transform_spr = sprite_duplicate(painter_history[painter_history_pos].trnsprite)
			
			selection_topleft = painter_history[painter_history_pos].pos_tl;
			selection_pos = painter_history[painter_history_pos].selection_pos;
			selection_btmright = painter_history[painter_history_pos].pos_br;
			selection_size = painter_history[painter_history_pos].sel_size;
			sel_trn_spr = painter_history[painter_history_pos].seltrnsprite;
			selection_active = painter_history[painter_history_pos].sel_active;
			selection_rot = painter_history[painter_history_pos].selection_rot;
			if (painter_history[painter_history_pos].val = "transform")
			{
				paint_tool_selected = e_paint.TRANSFORM_SELECTION
				selection_moved = true;
			}
			else{
			painter_get_sel_trn_spr()	
			}
			if (!selection_active)
			{
				surface_set_target(selection_surf)
				{
					draw_clear_alpha(c_black,0)
					selection_topleft = vec2(0,0)
					selection_btmright = vec2(0,0)
				}
				surface_reset_target()	
			}
		}
	}
}