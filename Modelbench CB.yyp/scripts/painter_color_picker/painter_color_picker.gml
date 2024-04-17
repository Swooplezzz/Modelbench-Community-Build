// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_tool_color_picker(mousexsnap, mouseysnap){
if(paint_tool_selected = e_paint.PICK){
	if(mouse_check_button(mb_left)){
		paint_primary_color = surface_getpixel(color_surf, mousexsnap + 1, mouseysnap + 1);
	}
	if(mouse_check_button(mb_right)){
		paint_secondary_color = surface_getpixel(color_surf, mousexsnap + 1, mouseysnap + 1);
	}
	if(mouse_left_released || mouse_right_released){
		//add_recent_color(surface_getpixel(color_surf, mousexsnap + 1, mouseysnap + 1));
		paintercolorpicker_update(null, (painter_main_color? paint_secondary_color : paint_primary_color), true)
	}
}
}