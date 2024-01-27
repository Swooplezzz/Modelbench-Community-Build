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
painter_erase_apply();
}
}