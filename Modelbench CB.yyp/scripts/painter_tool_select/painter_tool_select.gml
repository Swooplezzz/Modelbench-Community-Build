// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_select(mousexsnap,mouseysnap,inbounds){
	if(inbounds){
if(mouse_check_button_pressed(mb_left)  && paint_tool_selected = e_paint.BOX_SELECT){
	select_pos_one = vec2(mousexsnap + .5, mouseysnap + .5)
}
if(mouse_check_button_pressed(mb_right)  && paint_tool_selected = e_paint.BOX_SELECT){
	surface_set_target(selectionsurf){
		draw_clear_alpha(c_black,0)
		selection_active = false
	}
	surface_reset_target()
}
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.BOX_SELECT){	
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

        draw_rectangle_color(select_pos_one[X], select_pos_one[Y],  mousexsnap + .5, mouseysnap + .5, c_white, c_white, c_white, c_white, false)
gpu_set_blendmode(bm_normal);

	}
	surface_reset_target()
}
if((mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right))  && paint_tool_selected = e_paint.BOX_SELECT){
	if(sprite_exists(selectionspr))
	sprite_delete(selectionspr)
	selectionspr = sprite_create_from_surface(selectionsurf, 0,0, surface_get_width(selectionsurf), surface_get_height(selectionsurf), false, false, 0,0)


}
	}
	if(keyboard_check(vk_control) && keyboard_check_pressed(ord("A")) && content_mouseon){
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