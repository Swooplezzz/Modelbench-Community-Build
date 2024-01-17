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
		
		targetoffx = offx +((mouse_x - (boxx + boxw /2)) / zoom - (mouse_x - (boxx + boxw / 2)) / targetzoom)
		targetoffy = offy +((mouse_y - (boxy + boxh /2)) / zoom - (mouse_y - (boxy + boxh / 2)) / targetzoom)
	}
}

zoom += (targetzoom - zoom) / max(1, 8 / delta)
			offx += (targetoffx - offx) / max(1, 8 / delta)
			offy += (targetoffy - offy) / max(1, 8 / delta)

if(mouse_check_button(mb_middle) && content_mouseon){
	offx -= mouse_dx/ zoom;
	offy -= mouse_dy / zoom;
		targetoffx -= mouse_dx / zoom;
	targetoffy -= mouse_dy / zoom;
	app_mouse_wrap(content_x, content_y, content_width, content_height)
}
}