// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_select(mousexsnap,mouseysnap,inbounds){
	
if(!content_mouseon) return;

if(mouse_check_button_pressed(mb_left)  && paint_tool_selected = e_paint.BOX_SELECT){
	selection_pos = vec2(mousexsnap + 0.5, mouseysnap + 0.5)

	
	//selection_btmright[1]  = mouseysnap + 1.5 
	selection_topleft[0] = clamp(selection_topleft[0], 0, paint_texture_width)
	selection_topleft[1] = clamp(selection_topleft[1], 0, paint_texture_height)
	selection_topleft_prev = vec2(selection_topleft[0], selection_topleft[1]);


	if(selection_topleft[0] > selection_pos[0] )
	    selection_topleft[0]  = selection_pos[0]	
	if(selection_topleft[1] > selection_pos[1])
	    selection_topleft[1]  = selection_pos[1]
	
	//if(selection_btmright[0] < mousexsnap  + 1.5)
	//selection_btmright[0]  = mousexsnap + 1.5
	//if(selection_btmright[1] < mouseysnap + 1.5)
	//selection_btmright[1]  = mouseysnap + 1.5 
	
	selection_topleft[0] = clamp(selection_topleft[0], 0, paint_texture_width)
	selection_topleft[1] = clamp(selection_topleft[1], 0, paint_texture_height)
	selection_btmright[0] = clamp(selection_btmright[0], 0, paint_texture_width)
	selection_btmright[1] = clamp(selection_btmright[1], 0, paint_texture_height)
	selection_btmright_prev = vec2(selection_btmright[0], selection_btmright[1]);
	if(!selection_active){
		selection_topleft = vec2(selection_pos[0], selection_pos[1])	
		selection_topleft_prev = vec2(selection_topleft[0], selection_topleft[1]);
		selection_btmright_prev = vec2(selection_topleft[0], selection_topleft[1]);
	}
}

if(mouse_check_button_pressed(mb_right)  && paint_tool_selected = e_paint.BOX_SELECT || selection_active && !mouse_left && selection_size[X] = 0 || selection_active && !mouse_left && selection_size[Y] = 0){
	surface_set_target(selection_surf){
		draw_clear_alpha(c_black,0)
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(0,0)
		selection_active = false
	}
	surface_reset_target()
}

if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.BOX_SELECT){

    if(mousexsnap + 1.5 > selection_topleft_prev[0] - 1)
	    selection_btmright[0]  = mousexsnap + 1.5

    if(mouseysnap + 1.5 > selection_topleft_prev[1] - 1)
	    selection_btmright[1]  = mouseysnap + 1.5
	
	if(selection_btmright[0] < selection_btmright_prev[0])
	    selection_btmright[0]  = selection_btmright_prev[0]
		
	if(selection_btmright[1] < selection_btmright_prev[1])
	    selection_btmright[1]  = selection_btmright_prev[1]
		
	if(mousexsnap + 0.5 < selection_topleft_prev[0])
	    selection_topleft[0]  = mousexsnap + 1.5
	if(mouseysnap + 0.5 < selection_topleft_prev[1])
	
	    selection_topleft[1]  = mouseysnap + 1.5
	
	if(selection_topleft[0] > selection_topleft_prev[0])
	    selection_topleft[0]  = selection_topleft_prev[0]
		
	if(selection_topleft[1] > selection_topleft_prev[1])
	    selection_topleft[1]  = selection_topleft_prev[1]
		
		
	selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	
	draw_inbounds = 
	(selection_pos[0] <= paint_texture_width && selection_pos[0] >= 0 && selection_pos[1] <= paint_texture_height && selection_pos[1] >= 0) ||
	(mousexsnap + 1.5 <= paint_texture_width && mousexsnap + 1.5 >= 0 && mouseysnap + 1.5 <= paint_texture_height && mouseysnap + 1.5 >= 0) 

	
	drawsize = vec2(mousexsnap + 1.5-selection_pos[0],mouseysnap + 1.5-selection_pos[1]);

	surface_set_target(selection_surf){
		if(selection_active = false){
			
		    draw_clear_alpha(c_black,1)
			
			if(sprite_exists(selectionspr))
	            sprite_delete(selectionspr)
				
	        selectionspr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)

		    selection_active = true
		}

		draw_sprite_ext(selectionspr, 0,0,0,1,1,0,c_black,1);
		
		gpu_set_blendmode(bm_subtract);
		
        draw_rectangle_color(selection_pos[X], selection_pos[Y],  mousexsnap + .5, mouseysnap + .5, c_white, c_white, c_white, c_white, false)
		
        gpu_set_blendmode(bm_normal);
	}
	
	surface_reset_target()
}

if((mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right))  && paint_tool_selected = e_paint.BOX_SELECT){
	if(mouse_check_button_released(mb_left)){

	

		if((draw_inbounds) && !(drawsize[0] = 0 || drawsize[1] = 0)){
	    if(selection_topleft[0] > selection_pos[0] )
	        selection_topleft[0]  = selection_pos[0]	
			
	    if(selection_topleft[1] > selection_pos[1])
	        selection_topleft[1]  = selection_pos[1]
			
		}
	    else
	    {	
			show_debug_message("not drawing inbounds");
	        selection_topleft = vec2(selection_topleft_prev[0], selection_topleft_prev[1])
	        selection_btmright = vec2(selection_btmright_prev[0], selection_btmright_prev[1])
	    }
		selection_topleft[X] = clamp(selection_topleft[X],0, paint_texture_width)
	    selection_topleft[Y]= clamp(selection_topleft[Y],0, paint_texture_height)
		selection_btmright[0] = clamp(selection_btmright[0], 0, paint_texture_width)
	    selection_btmright[1] = clamp(selection_btmright[1], 0, paint_texture_height)
	}
	if(sprite_exists(selectionspr))
	    sprite_delete(selectionspr)
		
	selectionspr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)
	
	selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	
 	if(selection_active)
	{
	    painter_update_transform_sprite()
	}
	
	selection_btmright[X] = clamp(selection_btmright[X],0, paint_texture_width)
	selection_btmright[Y]= clamp(selection_btmright[Y],0, paint_texture_height)
	selection_topleft[X] = clamp(selection_topleft[X],0, paint_texture_width)
	selection_topleft[Y]= clamp(selection_topleft[Y],0, paint_texture_height)
	
	selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	
	painter_history_set("selection", finalspr, selectionspr, transformspr);
}

if(keybinds[e_keybind.SELECT_ALL].pressed && content_mouseon){
	selection_topleft = vec2(0,0)
	selection_btmright = vec2(paint_texture_width,paint_texture_height)
	selection_size = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	surface_set_target(selection_surf){
	    draw_clear_alpha(c_white,0)
		selection_active = true
		
		if(sprite_exists(selectionspr))
	        sprite_delete(selectionspr)	
	    
		selectionspr = sprite_create_from_surface(selection_surf, 0,0, surface_get_width(selection_surf), surface_get_height(selection_surf), false, false, 0,0)
	}
			surface_reset_target()
	
	if(sprite_exists(transformspr))
	    sprite_delete(transformspr)
		
	transformspr = sprite_duplicate(finalspr)

	surface_set_target(draw_surf){
        draw_clear(c_black)
        gpu_set_blendmode(bm_subtract)
        draw_set_color(c_black)
        draw_surface(selection_surf,0,0)
        gpu_set_blendmode(bm_normal)
    }
    surface_reset_target()
	
    if(sprite_exists(seltrnspr))
        sprite_delete(seltrnspr)
		
    seltrnspr = sprite_create_from_surface(draw_surf,selection_topleft[X],selection_topleft[Y],selection_size[X],selection_size[Y],false,false,0,0)
	
	surface_set_target(draw_surf){
		draw_clear_alpha(c_black,0)
	}
	surface_reset_target()
	
	painter_history_set("selection", finalspr, selectionspr, transformspr);

}

}