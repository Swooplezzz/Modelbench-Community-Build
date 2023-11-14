// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_erase(mousexsnap,mouseysnap,prevmousexsnap,prevmouseysnap, inbounds){
	surface_set_target(drawsurf){
//Erase Alpha.
if(mouse_check_button(mb_left) && paint_tool_selected = e_paint.ERASE && inbounds){		

draw_circle_color( mousexsnap, mouseysnap, paint_width*.6 ,  c_black, c_black, false);

draw_line_width_color(prevmousexsnap, prevmouseysnap, mousexsnap, mouseysnap , paint_width*1.2, c_black, c_black);
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}

if(keyboard_check_pressed(vk_delete)&&selection_active){
draw_clear(c_black)
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)	
}

}
surface_reset_target();
if((mouse_check_button(mb_left) && paint_tool_selected = e_paint.ERASE&& inbounds) || (keyboard_check_pressed(vk_delete)&&selection_active)){
surface_set_target(alphasurf){

draw_clear_alpha(c_black, 1)
draw_sprite_ext(alphaspr, 0,0,0,1,1,0, c_white, 1)
draw_surface_ext(drawsurf,0,0,1,1,0, c_black, 1)

}
surface_reset_target();
if(sprite_exists(alphaspr))
sprite_delete(alphaspr)

alphaspr = sprite_create_from_surface(alphasurf, 0,0,surface_get_width(alphasurf), surface_get_height(alphasurf), false, false, 0, 0)
surface_set_target(colorsurf){

	draw_clear_alpha(c_black, 0)

draw_sprite(colorspr,0,0,0)
gpu_set_blendmode(bm_subtract);
draw_surface_ext(drawsurf,0,0,1,1,0,c_black, 1)

gpu_set_blendmode(bm_normal);


}
surface_reset_target()
if(sprite_exists(colorspr))
sprite_delete(colorspr)
colorspr = sprite_create_from_surface(colorsurf, 0,0,surface_get_width(colorsurf), surface_get_height(colorsurf), false, false, 0, 0)
surface_set_target(drawsurf){
	draw_clear_alpha(c_black, 0)
	}
surface_reset_target();
}
}