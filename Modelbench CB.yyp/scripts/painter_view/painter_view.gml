/// painter_view()

function painter_view()
{
	if (content_mouseon)
	{
		if (keyboard_check(vk_control)) // Zoom
		{
			var m = (1 - (0.125 * mouse_wheel));
			if (m != 1)
			{
				var boxx, boxy, boxw, boxh;
				boxx = floor(view_area_x)
				boxy = floor(view_area_y)
				boxw = floor(view_area_width)
				boxh = floor(view_area_height)
	
				targetzoom = clamp(targetzoom * m, 0.125, 64)
		
				targetoffx = offx + ((mouse_x - (boxx + boxw /2)) / zoom - (mouse_x - (boxx + boxw / 2)) / targetzoom)
				targetoffy = offy + ((mouse_y - (boxy + boxh /2)) / zoom - (mouse_y - (boxy + boxh / 2)) / targetzoom)
			}
		}
		else if (keyboard_check(vk_shift)) // Horizontal scroll
		{
			if (mouse_wheel != 0)
				targetoffx += (80*mouse_wheel) / zoom
		}
		else if (!keybinds[e_keybind.BRUSH_WIDTH].active) // Vertical scroll
		{
			if (mouse_wheel != 0)
				targetoffy += (80*mouse_wheel) / zoom
		}
		
		if (mouse_middle) // Pan
		{
			offx -= mouse_dx / zoom;
			offy -= mouse_dy / zoom;
			targetoffx -= mouse_dx / zoom;
			targetoffy -= mouse_dy / zoom;
			app_mouse_wrap(content_x, content_y, content_width, content_height)
		}
	}
	zoom += (targetzoom - zoom) / max(1, 8 / delta)
	offx += (targetoffx - offx) / max(1, 8 / delta)
	offy += (targetoffy - offy) / max(1, 8 / delta)
}