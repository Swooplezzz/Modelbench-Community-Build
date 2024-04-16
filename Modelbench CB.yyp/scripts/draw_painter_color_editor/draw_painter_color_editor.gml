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
			window_busy = "paintercolorpickersatbripick"
	}
	
	if (window_busy = "paintercolorpickersatbripick")
	{
		if (!mouse_left && !mouse_right)
		{
			window_busy = ""
			window_focus = ""
			app_mouse_clear()
		}
		
		mouse_cursor = cr_handpoint
		paintercolorpicker.saturation = floor((clamp((mouse_x - bx) / bw, 0, 1)) * 255)
		paintercolorpicker.brightness = floor((clamp(1 - (mouse_y - by) / bh, 0, 1)) * 255)
		paintercolorpicker_update(null, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
	}
	paintercolorpicker.value_name = name
	paintercolorpicker.value_script = script
	
	draw_sprite_general(spr_colorpicker, 0, 0, 0, 192, 192, bx, by, 1, 1, 0, c_white, make_color_hsv(paintercolorpicker.hue, 255, 255), make_color_hsv(paintercolorpicker.hue, 255, 255), c_white, draw_get_alpha())
	draw_image(spr_colorpicker_cursor, 0, bx + (bw * (paintercolorpicker.saturation/255)), by + (bh * (1 - (paintercolorpicker.brightness/255))), 1, 1, c_white, 1)
	
	dy = by + 192 + 8
	dx += 20
	dw = 176
	
	bx = dx+ 8
	by = dy 
	bw = 176 - 16
	bh = 16
	
	// Hue picker
	if (app_mouse_box(bx - 8, by, bw + 16, bh))
	{
		mouse_cursor = cr_handpoint
		if (mouse_left || mouse_right)
			window_busy = "paintercolorpickerhuepick"
	}
	
	if (window_busy = "paintercolorpickerhuepick")
	{
		if (!mouse_left && !mouse_right)
		{
			window_busy = ""
			app_mouse_clear()
		}
		
		mouse_cursor = cr_handpoint
		paintercolorpicker.hue = floor(clamp((mouse_x - bx) / bw, 0, 1) * 255)
		paintercolorpicker_update(null, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
	}
	
	draw_image(spr_colorpicker_hue, 0, dx, by, 1, 1, c_white, 1)
	draw_outline(dx, by, 176, 16, 1, c_border, a_border, true)
	draw_image(spr_colorpicker_cursor, 1, bx + ((paintercolorpicker.hue/255) * bw), by + 8, 1, 1)
	dy += 16 + 8

	if (stack)
	{
		dy = ddy;
		dx = panel_area_width - 176 - 12;
	}
	else
	{
		tab_control_button_label()
		togglebutton_add("colorpickerrgb", null, "rgb", paintercolorpicker.mode = "rgb", paintercolorpicker_set_mode)
		togglebutton_add("colorpickerhsv", null, "hsv", paintercolorpicker.mode = "hsv", paintercolorpicker_set_mode)
		togglebutton_add("colorpickerhex", null, "hex", paintercolorpicker.mode = "hex", paintercolorpicker_set_mode)
		draw_togglebutton("colorpickermode", dx, dy, true, false)
		tab_next()
	}
	
	if (paintercolorpicker.mode = "rgb" || stack)
	{
		// RGB
		textfield_group_add("colorpickerr", color_get_red(paintercolorpicker.color), color_get_red(paintercolorpicker.def), paintercolorpicker_red, X, paintercolorpicker.tbx_red)
		textfield_group_add("colorpickerg", color_get_green(paintercolorpicker.color), color_get_green(paintercolorpicker.def), paintercolorpicker_green, Y, paintercolorpicker.tbx_green)
		textfield_group_add("colorpickerb", color_get_blue(paintercolorpicker.color), color_get_blue(paintercolorpicker.def), paintercolorpicker_blue, Z, paintercolorpicker.tbx_blue)
		if (draw_textfield_group("colorpickerrgb", dx, dy, 176, 1, 0, 255, 1, false, stack, 3, true, false))
		{
			paintercolorpicker.red = min(255, string_get_real(paintercolorpicker.tbx_red.text, 0))
			paintercolorpicker.green = min(255, string_get_real(paintercolorpicker.tbx_green.text, 0))
			paintercolorpicker.blue = min(255, string_get_real(paintercolorpicker.tbx_blue.text, 0))
			paintercolorpicker_update(null, make_color_rgb(paintercolorpicker.red, paintercolorpicker.green, paintercolorpicker.blue), true)
		}
		if (stack)
			dy += 24 * 3 + 12;
	}
	if (paintercolorpicker.mode = "hsv" || stack)
	{
		// HSV
		textfield_group_add("colorpickerh", floor(color_get_hue(paintercolorpicker.color)), floor(color_get_hue(paintercolorpicker.def)), paintercolorpicker_hue, X, paintercolorpicker.tbx_hue)
		textfield_group_add("colorpickers", floor(color_get_saturation(paintercolorpicker.color)), floor(color_get_saturation(paintercolorpicker.def)), paintercolorpicker_saturation, X, paintercolorpicker.tbx_saturation)
		textfield_group_add("colorpickerv", floor(color_get_value(paintercolorpicker.color)), floor(color_get_value(paintercolorpicker.def)), paintercolorpicker_brightness, X, paintercolorpicker.tbx_brightness)
		var update = draw_textfield_group("colorpickerhsv", dx, dy, 176, 1, 0, 255, 1, false, stack, 0, true, false);
		if (update = paintercolorpicker.tbx_hue)
		{
			paintercolorpicker.hue = min(255, string_get_real(paintercolorpicker.tbx_hue.text, 0))
			paintercolorpicker_update(paintercolorpicker.tbx_hue, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
		}
		if (update = paintercolorpicker.tbx_saturation)
		{
			paintercolorpicker.saturation = min(255, string_get_real(paintercolorpicker.tbx_saturation.text, 0))
			paintercolorpicker_update(paintercolorpicker.tbx_saturation, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
		}
		if (update = paintercolorpicker.tbx_brightness)
		{
			paintercolorpicker.brightness = min(255, string_get_real(paintercolorpicker.tbx_brightness.text, 0))
			paintercolorpicker_update(paintercolorpicker.tbx_brightness, make_color_hsv(paintercolorpicker.hue, paintercolorpicker.saturation, paintercolorpicker.brightness), false)
		}
		if (stack)
			dy += 24 * 3 + 12;
	}
	if (paintercolorpicker.mode = "hex" || stack)
	{
		if (draw_inputbox("colorpickerhex", dx, dy, 176, 24, color_to_hex(paintercolorpicker.def), paintercolorpicker.tbx_hexadecimal, null))
			paintercolorpicker_update(paintercolorpicker.tbx_hexadecimal, paintercolorpicker.tbx_hexadecimal.text = "" ? paintercolorpicker.def : hex_to_color(paintercolorpicker.tbx_hexadecimal.text), true)
	
		if (paintercolorpicker.tbx_hexadecimal.text = "" && window_focus = "")
			paintercolorpicker.tbx_hexadecimal.text = "000000"
	}
	if (stack)
		dy = by
	dy += 24 + 4
	
	settings_menu_w = 192
}