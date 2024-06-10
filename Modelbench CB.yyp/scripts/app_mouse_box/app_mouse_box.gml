/// app_mouse_box(x, y, width, height, [angle, center])
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg [angle
/// @arg center]

function app_mouse_box(boxx, boxy, boxw, boxh, angle = 0, center = [0,0])
{
	var rm, mx, my;
	rm = vec2_rotate([mouse_x, mouse_y], angle, center)
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
