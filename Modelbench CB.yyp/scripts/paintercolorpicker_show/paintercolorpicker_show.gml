/// painter_colorpicker_show(name, color, default, script, x, y, width, height)
/// @arg name
/// @arg color
/// @arg default
/// @arg script
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function painter_colorpicker_show(name, color, def, script, xx, yy, width, height)
{
	var istexedit, c, i;
	if(argument_count > 8){
		istexedit = argument[8]
	}
	if (settings_menu_name = "painter_colorpicker" && painter_colorpicker.value_script = script){
		popup_close()

	}
	else
	{
		settings_menu_busy_prev = window_busy
		window_busy = "settingsmenu"
		window_focus = ""
		app_mouse_clear()
		
		//settings_menu_window = window_get_current()
		settings_menu_name = "painter_colorpicker"
		settings_menu_ani = 0
		settings_menu_ani_type = "show"
		
		settings_menu_primary = false
		settings_menu_x = xx
		settings_menu_y = yy
		
		if (settings_menu_x < 0)
			settings_menu_x = xx + width + 8
		
		if (settings_menu_x + 192 > window_width)
			settings_menu_x = window_width - 192
		
		settings_menu_h_max = null
		settings_menu_button_h = height
		settings_menu_above = false
		settings_menu_steps = 0
		settings_menu_script = painter_colorpicker_draw
		
		painter_colorpicker.value_name = name
		painter_colorpicker.value_script = null;
		painter_colorpicker.mode = "rgb"
		
		painter_colorpicker.def = def
		painter_colorpicker.color = color
		painter_colorpicker.red = color_get_red(color)
		painter_colorpicker.green = color_get_green(color)
		painter_colorpicker.blue = color_get_blue(color)
		
		painter_colorpicker.hue = color_get_hue(color)
		painter_colorpicker.saturation = color_get_saturation(color)
		painter_colorpicker.brightness = color_get_value(color)
		
		painter_colorpicker.tbx_red.text = string(painter_colorpicker.red)
		painter_colorpicker.tbx_green.text = string(painter_colorpicker.green)
		painter_colorpicker.tbx_blue.text = string(painter_colorpicker.blue)
		painter_colorpicker.tbx_hexadecimal.text = color_to_hex(color)
	}
}
