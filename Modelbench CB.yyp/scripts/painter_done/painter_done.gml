// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_done(inbounds){
surface_set_target(color_surf){
	draw_clear_alpha(c_black,0)
	draw_sprite(colorspr,0,0,0)
	
	if(selection_moved && paint_tool_selected != e_paint.TRANSFORM){
	alphafix
	shader_set(shader_colormask)
	draw_surface(transform_surf,0,0)	
	shader_reset()
	gpu_set_blendmode(bm_normal)
	}
}
surface_reset_target()
//Update the alpha mask.
surface_set_target(alpha_surf){
	draw_clear(c_black)

    draw_sprite(alphaspr,0,0,0)
	if(selection_moved && paint_tool_selected != e_paint.TRANSFORM){
	alphafix
	shader_set(shader_alphamask)
	draw_surface(transform_surf,0,0)	
	shader_reset()
}
gpu_set_blendmode(bm_normal);
}
surface_reset_target()

if(selection_moved && paint_tool_selected != e_paint.TRANSFORM){
	if(sprite_exists(alphaspr))
sprite_delete(alphaspr)
alphaspr = sprite_create_from_surface(alpha_surf, 0,0,surface_get_width(alpha_surf), surface_get_height(alpha_surf), false, false, 0, 0)

if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(color_surf, 0,0,surface_get_width(color_surf), surface_get_height(color_surf), false, false, 0, 0)
}

//if(!filling)
painter_create_finalspr();

if(painter_update_spr){

if(paint_tool_selected != e_paint.TRANSFORM){
painter_update_transform_sprite()
}
}
if(mouse_check_button_released(mb_right) || mouse_check_button_released(mb_left)){
	if(paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE){
painter_history_set("painting", finalspr, selectionspr, transformspr)

	}
}
if(keyboard_check_pressed(vk_delete)&&selection_active){
painter_history_set("painting", finalspr, selectionspr, transformspr)

}

}