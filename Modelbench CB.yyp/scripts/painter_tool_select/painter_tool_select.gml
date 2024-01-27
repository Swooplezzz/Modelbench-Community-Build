// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_select(mousexsnap,mouseysnap,inbounds){
if(!content_mouseon) return;
if(mouse_check_button_pressed(mb_left)  && paint_tool_selected = e_paint.BOX_SELECT){
	selection_pos = vec2(mousexsnap + 0.5, mouseysnap + 0.5)
	selection_pos[0] = clamp(selection_pos[0], 0, texturewidth)
	selection_pos[1] = clamp(selection_pos[1], 0, textureheight)
	if(selection_active = false)
	selection_topleft = vec2(selection_pos[0], selection_pos[1] )
	if(selection_topleft[0] > selection_pos[0] )
	selection_topleft[0]  = selection_pos[0]	
	if(selection_topleft[1] > selection_pos[1])
	selection_topleft[1]  = selection_pos[1]
	
	selection_topleft[0] = clamp(selection_topleft[0], 0, texturewidth)
	selection_topleft[1] = clamp(selection_topleft[1], 0, textureheight)
}
if(mouse_check_button_pressed(mb_right)  && paint_tool_selected = e_paint.BOX_SELECT){
	surface_set_target(selectionsurf){
		draw_clear_alpha(c_black,0)
		selection_topleft = vec2(0,0)
		selection_btmright = vec2(0,0)
		selection_active = false
	}
	surface_reset_target()
}
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.BOX_SELECT){	
	
	//if(mousexsnap + .5 < 0 && mouseysnap + .5 > 0 && mousexsnap + .5 < texturewidth && mouseysnap + .5 > textureheight)

	surface_set_target(selectionsurf){
		if(selection_active = false){
		draw_clear_alpha(c_black,1)
			if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)

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
	if(selection_btmright[0] < mousexsnap  + 1.5)
	selection_btmright[0]  = mousexsnap + 1.5
	if(selection_btmright[1] < mouseysnap + 1.5)
	selection_btmright[1]  = mouseysnap + 1.5 
	
	selection_btmright[0] = clamp(selection_btmright[0], 0, texturewidth)
	selection_btmright[1] = clamp(selection_btmright[1], 0, textureheight)
	}
	if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)
	selectionsize = vec2(selection_btmright[0]-selection_topleft[0],selection_btmright[1]-selection_topleft[1]);
	if(selection_active){
			var tempsurf = surface_create(selectionsize[X], selectionsize[Y]);
	surface_set_target(tempsurf){
	draw_sprite(finalspr,0,-selection_topleft[X], -selection_topleft[Y]);
   gpu_set_blendmode(bm_subtract)
   draw_set_color(c_black)
   draw_surface(selectionsurf,-selection_topleft[X], -selection_topleft[Y])
   gpu_set_blendmode(bm_normal)
	}

	surface_reset_target()
	if(sprite_exists(transformspr))
	sprite_delete(transformspr)
	transformspr = sprite_create_from_surface(tempsurf,0, 0,selectionsize[X],selectionsize[Y],false,false,0,0);
	surface_free(tempsurf)
	surface_set_target(drawsurf){
draw_clear(c_black)
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}
surface_reset_target()
if(sprite_exists(seltrnspr))
sprite_delete(seltrnspr)
seltrnspr = sprite_create_from_surface(drawsurf,selection_topleft[X],selection_topleft[Y],selectionsize[X],selectionsize[Y],false,false,0,0)
	surface_set_target(drawsurf){
		draw_clear_alpha(c_black,0)
	}
	surface_reset_target()
}

}

	if(keybinds[e_keybind.SELECT_ALL].pressed && content_mouseon){
		surface_set_target(selectionsurf){
			draw_clear_alpha(c_white,0)
		selection_active = true
		if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)

		}
			surface_reset_target()
	}
}