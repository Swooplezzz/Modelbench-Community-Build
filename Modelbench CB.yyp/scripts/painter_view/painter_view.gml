// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_view(){
		var boxx, boxy, boxw, boxh;
	boxx = view_area_x
	boxy = view_area_y
	boxw = view_area_width
	boxh = view_area_height
	
	boxx = floor(boxx)
	boxy = floor(boxy)
	boxw = floor(boxw)
	boxh = floor(boxh)
if(keyboard_check(vk_control)){
	var m;
	m = (1 - 0.25 * mouse_wheel)
	if (m != 1)
	{
		targetzoom = clamp(targetzoom * m,  0.1, 100)
		
		target_view_offset_x = view_offset_x +((mouse_x - (boxx + boxw /2)) / zoom - (mouse_x - (boxx + boxw / 2)) / targetzoom)
		target_view_offset_y = view_offset_y +((mouse_y - (boxy + boxh /2)) / zoom - (mouse_y - (boxy + boxh / 2)) / targetzoom)
	}
}

            zoom += (targetzoom - zoom) / max(1, 8 / delta)
			view_offset_x += (target_view_offset_x - view_offset_x) / max(1, 8 / delta)
			view_offset_y += (target_view_offset_y - view_offset_y) / max(1, 8 / delta)

if(mouse_check_button(mb_middle) && content_mouseon){
	view_offset_x -= mouse_dx/ zoom;
	view_offset_y -= mouse_dy / zoom;
		target_view_offset_x -= mouse_dx / zoom;
	target_view_offset_y -= mouse_dy / zoom;
	app_mouse_wrap(content_x, content_y, content_width, content_height)
}
}