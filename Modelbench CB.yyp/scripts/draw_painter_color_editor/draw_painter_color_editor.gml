/// draw_painter_color_editor(name, script, color)
/// @arg name
/// @arg script
/// @arg color

function draw_painter_color_editor(name, script, color)
{
	var bx, by, bw, bh;
	var stack = (content_width > 230 + 176)
	if (!stack)
		dx = content_x + 12 + content_width /2 - 230/2;
				
	bx = dx + 12
	by = dy
	ddy = dy;
	bw = 192
	bh = 192
	
	if (window_busy = "" && painter_editing_color)
	{
		add_recent_color(color)
		painter_editing_color = false;
	}
	if ((window_busy = "colorpickersatbripick" || window_busy = "colorpickerhuepick") && !painter_editing_color)
	{
		painter_editing_color = true;
	}
	// Saturation/brightness picker
	if (app_mouse_box(bx, by, bw, bh))
	{
		mouse_cursor = cr_handpoint
		if (mouse_left || mouse_right)
			window_busy = "painter_colorpickersatbripick"
	}
	
	if (window_busy = "painter_colorpickersatbripick")
	{
		if (!mouse_left && !mouse_right)
		{
			window_busy = ""
			window_focus = ""
			app_mouse_clear()
		}
		
		mouse_cursor = cr_handpoint
		painter_colorpicker.saturation = floor((clamp((mouse_x - bx) / bw, 0, 1)) * 255)
		painter_colorpicker.brightness = floor((clamp(1 - (mouse_y - by) / bh, 0, 1)) * 255)
		painter_colorpicker_update(null, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
	}
	painter_colorpicker.value_name = name
	painter_colorpicker.value_script = script
	
	draw_sprite_general(spr_colorpicker, 0, 0, 0, 192, 192, bx, by, 1, 1, 0, c_white, make_color_hsv(painter_colorpicker.hue, 255, 255), make_color_hsv(painter_colorpicker.hue, 255, 255), c_white, draw_get_alpha())
	draw_image(spr_colorpicker_cursor, 0, bx + (bw * (painter_colorpicker.saturation/255)), by + (bh * (1 - (painter_colorpicker.brightness/255))), 1, 1, c_white, 1)
	
	dy = by + 192 + 8
	dx += 20
	
	bx = dx+ 8
	by = dy 
	bw = 176 - 16
	bh = 16
	
	// Hue picker
	if (app_mouse_box(bx - 8, by, bw + 16, bh))
	{
		mouse_cursor = cr_handpoint
		if (mouse_left || mouse_right)
			window_busy = "painter_colorpickerhuepick"
	}
	
	if (window_busy = "painter_colorpickerhuepick")
	{
		if (!mouse_left && !mouse_right)
		{
			window_busy = ""
			app_mouse_clear()
		}
		
		mouse_cursor = cr_handpoint
		painter_colorpicker.hue = floor(clamp((mouse_x - bx) / bw, 0, 1) * 255)
		painter_colorpicker_update(null, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
	}
	
	draw_image(spr_colorpicker_hue, 0, dx, by, 1, 1, c_white, 1)
	draw_outline(dx, by, 176, 16, 1, c_border, a_border, true)
	draw_image(spr_colorpicker_cursor, 1, bx + ((painter_colorpicker.hue/255) * bw), by + 8, 1, 1)
	dy += 16 + 8

	if (stack)
	{
		dy = ddy;
		dx = panel_area_width - 176 - 12;
	}
	else
	{
		tab_control_button_label()
		togglebutton_add("colorpickerrgb", null, "rgb", painter_colorpicker.mode = "rgb", painter_colorpicker_set_mode)
		togglebutton_add("colorpickerhsv", null, "hsv", painter_colorpicker.mode = "hsv", painter_colorpicker_set_mode)
		togglebutton_add("colorpickerhex", null, "hex", painter_colorpicker.mode = "hex", painter_colorpicker_set_mode)
		draw_togglebutton("colorpickermode", dx, dy, 176, true, false)
		tab_next()
	}
	
	if (painter_colorpicker.mode = "rgb" || stack)
	{
		// RGB
		textfield_group_add("colorpickerr", color_get_red(painter_colorpicker.color), color_get_red(painter_colorpicker.def), painter_colorpicker_red, X, painter_colorpicker.tbx_red)
		textfield_group_add("colorpickerg", color_get_green(painter_colorpicker.color), color_get_green(painter_colorpicker.def), painter_colorpicker_green, Y, painter_colorpicker.tbx_green)
		textfield_group_add("colorpickerb", color_get_blue(painter_colorpicker.color), color_get_blue(painter_colorpicker.def), painter_colorpicker_blue, Z, painter_colorpicker.tbx_blue)
		if (draw_textfield_group("colorpickerrgb", dx, dy, 176, 1, 0, 255, 1, false, stack, 3, true, false))
		{
			painter_colorpicker.red = min(255, string_get_real(painter_colorpicker.tbx_red.text, 0))
			painter_colorpicker.green = min(255, string_get_real(painter_colorpicker.tbx_green.text, 0))
			painter_colorpicker.blue = min(255, string_get_real(painter_colorpicker.tbx_blue.text, 0))
			painter_colorpicker_update(null, make_color_rgb(painter_colorpicker.red, painter_colorpicker.green, painter_colorpicker.blue), true)
		}
		if (stack)
			dy += 24 * 3 + 12;
	}
	if (painter_colorpicker.mode = "hsv" || stack)
	{
		// HSV
		textfield_group_add("colorpickerh", floor(color_get_hue(painter_colorpicker.color)), floor(color_get_hue(painter_colorpicker.def)), painter_colorpicker_hue, X, painter_colorpicker.tbx_hue)
		textfield_group_add("colorpickers", floor(color_get_saturation(painter_colorpicker.color)), floor(color_get_saturation(painter_colorpicker.def)), painter_colorpicker_saturation, X, painter_colorpicker.tbx_saturation)
		textfield_group_add("colorpickerv", floor(color_get_value(painter_colorpicker.color)), floor(color_get_value(painter_colorpicker.def)), painter_colorpicker_brightness, X, painter_colorpicker.tbx_brightness)
		var update = draw_textfield_group("colorpickerhsv", dx, dy, 176, 1, 0, 255, 1, false, stack, 0, true, false);
		if (update = painter_colorpicker.tbx_hue)
		{
			painter_colorpicker.hue = min(255, string_get_real(painter_colorpicker.tbx_hue.text, 0))
			painter_colorpicker_update(painter_colorpicker.tbx_hue, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
		}
		if (update = painter_colorpicker.tbx_saturation)
		{
			painter_colorpicker.saturation = min(255, string_get_real(painter_colorpicker.tbx_saturation.text, 0))
			painter_colorpicker_update(painter_colorpicker.tbx_saturation, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
		}
		if (update = painter_colorpicker.tbx_brightness)
		{
			painter_colorpicker.brightness = min(255, string_get_real(painter_colorpicker.tbx_brightness.text, 0))
			painter_colorpicker_update(painter_colorpicker.tbx_brightness, make_color_hsv(painter_colorpicker.hue, painter_colorpicker.saturation, painter_colorpicker.brightness), false)
		}
		if (stack)
			dy += 24 * 3 + 12;
	}
	if (painter_colorpicker.mode = "hex" || stack)
	{
		if (draw_inputbox("colorpickerhex", dx, dy, 176, 24, color_to_hex(painter_colorpicker.def), painter_colorpicker.tbx_hexadecimal, null))
			painter_colorpicker_update(painter_colorpicker.tbx_hexadecimal, painter_colorpicker.tbx_hexadecimal.text = "" ? painter_colorpicker.def : hex_to_color(painter_colorpicker.tbx_hexadecimal.text), true)
	
		if (painter_colorpicker.tbx_hexadecimal.text = "" && window_focus = "")
			painter_colorpicker.tbx_hexadecimal.text = "000000"
	}
	if (stack)
		dy = by
	dy += 24 + 4
	
	settings_menu_w = 192
}