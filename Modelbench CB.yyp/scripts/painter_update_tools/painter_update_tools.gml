// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_update_tools(){
if(keyboard_check(ord("F"))){
	if(mouse_wheel_up())
	paint_width += 1;
	if(mouse_wheel_down())
	paint_width -= 1;
	paint_width = max(paint_width, 0)
}
}