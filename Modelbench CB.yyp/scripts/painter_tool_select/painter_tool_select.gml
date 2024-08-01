/// painter_tool_select(x, y)
/// @arg x
/// @arg y

function painter_tool_select(xx, yy)
{
	if (paint_tool_selected = e_paint.BOX_SELECT)
	{
		if (mouse_left_pressed || mouse_right_pressed  && keyboard_check(vk_control)  && selection_active)
		{
			selection_pos = vec2(xx + 0.5, yy + 0.5)
			selection_rot = 0;
			//selection_btmright[1]  = yy + 1.5 
			selection_topleft[0] = clamp(selection_topleft[0], 0, paint_texture_width)
			selection_topleft[1] = clamp(selection_topleft[1], 0, paint_texture_height)
			selection_topleft_prev = vec2(selection_topleft[0], selection_topleft[1]);
		
			if (selection_topleft[0] > selection_pos[0])
			    selection_topleft[0] = selection_pos[0]	
			if (selection_topleft[1] > selection_pos[1])
			    selection_topleft[1] = selection_pos[1]
	
			//if (selection_btmright[0] < xx  + 1.5)
			//	selection_btmright[0] = xx + 1.5
			//if (selection_btmright[1] < yy + 1.5)
			//	selection_btmright[1] = yy + 1.5 
	
			selection_topleft[0] = clamp(selection_topleft[0], 0, paint_texture_width)
			selection_topleft[1] = clamp(selection_topleft[1], 0, paint_texture_height)
			selection_btmright[0] = clamp(selection_btmright[0], 0, paint_texture_width)
			selection_btmright[1] = clamp(selection_btmright[1], 0, paint_texture_height)
			selection_btmright_prev = vec2(selection_btmright[0], selection_btmright[1]);
			if(!keyboard_check(vk_control)){
			surface_set_target(selection_surf)
			{
				draw_clear_alpha(c_black,0)
				selection_topleft = vec2(0,0)
				selection_btmright = vec2(0,0)
				selection_active = false
			}
			
			surface_reset_target()
			}
			if (!selection_active)
			{
				selection_topleft = vec2(selection_pos[0], selection_pos[1])	
				selection_topleft_prev = vec2(selection_topleft[0], selection_topleft[1]);
				selection_btmright_prev = vec2(selection_topleft[0], selection_topleft[1]);
			}
		}

		if (mouse_right_pressed  && !keyboard_check(vk_control) || (selection_active && !mouse_left && (selection_size[X] = 0 || selection_size[Y] = 0)))
		{
			    selection_rot = 0;
			    surface_set_target(selection_surf)
			    {
			    	draw_clear_alpha(c_black,0)
			    	selection_topleft = vec2(0,0)
			    	selection_btmright = vec2(0,0)
			    	selection_active = false
			    }
			    surface_reset_target()
			    if(sprite_exists(selection_spr))
			        sprite_delete(selection_spr)
			    selection_spr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)
		}

		if (mouse_left || mouse_right)
		{
		    if(xx + 0.5 > selection_topleft_prev[0])
			    selection_btmright[0] = xx + 0.5

		    if(yy + 0.5 > selection_topleft_prev[1])
			    selection_btmright[1] = yy + 0.5
	
			if(selection_btmright[0] < selection_btmright_prev[0])
			    selection_btmright[0] = selection_btmright_prev[0]
		
			if(selection_btmright[1] < selection_btmright_prev[1])
			    selection_btmright[1] = selection_btmright_prev[1]
		
			if(xx + 0.5 < selection_topleft_prev[0])
			    selection_topleft[0] = xx + 0.5
			
			if(yy + 0.5 < selection_topleft_prev[1])
			    selection_topleft[1] = yy + 0.5
	
			if(selection_topleft[0] > selection_topleft_prev[0])
			    selection_topleft[0] = selection_topleft_prev[0]
		
			if(selection_topleft[1] > selection_topleft_prev[1])
			    selection_topleft[1] = selection_topleft_prev[1]
		
			selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
		
			draw_size = vec2(selection_topleft[0] - selection_btmright[0],selection_topleft[1] - selection_btmright[1]);

			surface_set_target(selection_surf)
			{
				if(mouse_left){
				if (!selection_active)
				{
				    draw_clear_alpha(c_black,1)
			
					if(sprite_exists(selection_spr))
			            sprite_delete(selection_spr)
			        selection_spr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)

				    selection_active = true
				}
				}
				
				draw_sprite_ext(selection_spr, 0, 0, 0, 1, 1, 0, c_black, 1)
				if(mouse_left){
				gpu_set_blendmode(bm_subtract)
		        draw_rectangle_color(selection_pos[X], selection_pos[Y], xx, yy, c_white, c_white, c_white, c_white, false)
		        gpu_set_blendmode(bm_normal)
				} 
				else if(mouse_right && selection_active){
	            gpu_set_blendmode(bm_normal)
		        draw_rectangle_color(selection_pos[X], selection_pos[Y], xx, yy, c_black, c_black, c_black, c_black, false)
				}
			}
			surface_reset_target()
		}

		if (mouse_left_released || mouse_right_released)
		{
			show_debug_message("bounds")
				painter_update_selection_bounds();
				
				if (!(draw_size[0] = 0 || draw_size[1] = 0))
				{
				    if(selection_topleft[0] > selection_pos[0] )
				        selection_topleft[0]  = selection_pos[0]	
			
				    if(selection_topleft[1] > selection_pos[1])
				        selection_topleft[1]  = selection_pos[1]
									
				selection_topleft[X] = clamp(selection_topleft[X],0, paint_texture_width)
			    selection_topleft[Y]= clamp(selection_topleft[Y],0, paint_texture_height)
				selection_btmright[0] = clamp(selection_btmright[0], 0, paint_texture_width)
			    selection_btmright[1] = clamp(selection_btmright[1], 0, paint_texture_height)
			
				}
			    else
			    {	
					show_debug_message("Not drawing inbounds");
			        selection_topleft = vec2(0)
			        selection_btmright = vec2(0)
			    }
	
			
			if(sprite_exists(selection_spr))
			    sprite_delete(selection_spr)
			selection_spr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)
	
			selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
		 	if (selection_active)
			    painter_update_transform_sprite()
	
			selection_btmright[X] = clamp(selection_btmright[X],0, paint_texture_width)
			selection_btmright[Y] = clamp(selection_btmright[Y],0, paint_texture_height)
			selection_topleft[X] = clamp(selection_topleft[X],0, paint_texture_width)
			selection_topleft[Y] = clamp(selection_topleft[Y],0, paint_texture_height)
	
			selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	
			painter_history_set("selection", final_spr, selection_spr, transform_spr);
		}
	}

	if (keybinds[e_keybind.SELECT_ALL].pressed)
	{
		selection_rot = 0;
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(paint_texture_width,paint_texture_height)
		selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
		
		surface_set_target(selection_surf)
		{
		    draw_clear_alpha(c_white, 0)
			selection_active = true
		
			if (sprite_exists(selection_spr))
		        sprite_delete(selection_spr)	
			selection_spr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)
		}
		surface_reset_target()
	
		if(sprite_exists(transform_spr))
		    sprite_delete(transform_spr)
		
		transform_spr = sprite_duplicate(final_spr)

		surface_set_target(draw_surf)
		{
	        draw_clear(c_black)
	        gpu_set_blendmode(bm_subtract)
	        draw_set_color(c_black)
	        draw_surface(selection_surf,0,0)
	        gpu_set_blendmode(bm_normal)
	    }
	    surface_reset_target()
	
	    if (sprite_exists(sel_trn_spr))
	        sprite_delete(sel_trn_spr)
	    sel_trn_spr = sprite_create_from_surface(draw_surf,selection_topleft[X],selection_topleft[Y],selection_size[X],selection_size[Y],false,false,0,0)
	
		surface_set_target(draw_surf)
		{
			draw_clear_alpha(c_black,0)
		}
		surface_reset_target()
	
		painter_history_set("selection", final_spr, selection_spr, transform_spr);
	}
}