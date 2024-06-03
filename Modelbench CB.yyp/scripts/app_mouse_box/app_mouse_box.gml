/// app_mouse_box(x, y, width, height)
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function app_mouse_box(boxx, boxy, boxw, boxh)
{
	var angle = 0;
	var center = [0,0];
	if(argument_count > 4){
	angle = argument[4];
	}
	if(argument_count > 5){
	center = argument[5];
	}
var mx, my;
var rm = vec2_rotate([mouse_x,mouse_y], angle,center);
mx = rm[X]
my = rm[Y]
	if (sign(boxw) = 1 && sign(boxh) = 1)
		return (mx >= boxx &&
				my >= boxy &&
				mx < boxx + boxw &&
				my < boxy + boxh && window_busy = "" && popup_ani_type = "")	
	else if (sign(boxw) = -1 && sign(boxh) = 1)
		return (mx <= boxx &&
				my >= boxy &&
				mx > boxx + boxw &&
				my < boxy + boxh && window_busy = "" && popup_ani_type = "")
	else if (sign(boxw) = 1 && sign(boxh) = -1)
		return (mx >= boxx &&
				my <= boxy &&
				mx < boxx + boxw &&
				my > boxy + boxh && window_busy = "" && popup_ani_type = "")
    else
		return (mx <= boxx &&
				my <= boxy &&
				mx > boxx + boxw &&
				my > boxy + boxh && window_busy = "" && popup_ani_type = "")
}
