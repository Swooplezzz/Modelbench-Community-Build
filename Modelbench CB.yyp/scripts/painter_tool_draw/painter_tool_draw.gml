// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_draw(mousexsnap,mouseysnap,prevmousexsnap,prevmouseysnap){
//Draw.
if ((mouse_check_button(mb_left) || mouse_check_button(mb_right))&& paint_tool_selected = e_paint.BRUSH){
 
	var color = (mouse_check_button(mb_left)? paint_primary_color : paint_secondary_color)
	if(painter_main_color = 1)
	 color = (mouse_check_button(mb_left)? paint_secondary_color : paint_primary_color)

draw_circle_color( mousexsnap, mouseysnap, paint_width*.6 ,  color, color, false);

draw_line_width_color(prevmousexsnap, prevmouseysnap, mousexsnap, mouseysnap , paint_width*1.2, color, color);
gpu_set_blendmode(bm_subtract)
draw_set_color(c_black)
draw_surface(selectionsurf,0,0)
gpu_set_blendmode(bm_normal)
}
}