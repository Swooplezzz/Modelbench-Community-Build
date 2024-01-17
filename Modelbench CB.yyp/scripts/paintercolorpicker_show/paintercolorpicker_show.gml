/// paintercolorpicker_show(name, color, default, script, x, y, width, height)
/// @arg name
/// @arg color
/// @arg default
/// @arg script
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function paintercolorpicker_show(name, color, def, script, xx, yy, width, height)
{
	var istexedit, c, i;
	if(argument_count > 8){
		istexedit = argument[8]
	}
	if (settings_menu_name = "paintercolorpicker" && paintercolorpicker.value_script = script){
		popup_close()

	}
	else
	{
		settings_menu_busy_prev = window_busy
		window_busy = "settingsmenu"
		window_focus = ""
		app_mouse_clear()
		
		//settings_menu_window = window_get_current()
		settings_menu_name = "paintercolorpicker"
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
		settings_menu_script = paintercolorpicker_draw
		
		paintercolorpicker.value_name = name
		paintercolorpicker.value_script = null;
		paintercolorpicker.mode = "rgb"
		
		paintercolorpicker.def = def
		paintercolorpicker.color = color
		paintercolorpicker.red = color_get_red(color)
		paintercolorpicker.green = color_get_green(color)
		paintercolorpicker.blue = color_get_blue(color)
		
		paintercolorpicker.hue = color_get_hue(color)
		paintercolorpicker.saturation = color_get_saturation(color)
		paintercolorpicker.brightness = color_get_value(color)
		
		paintercolorpicker.tbx_red.text = string(paintercolorpicker.red)
		paintercolorpicker.tbx_green.text = string(paintercolorpicker.green)
		paintercolorpicker.tbx_blue.text = string(paintercolorpicker.blue)
		paintercolorpicker.tbx_hexadecimal.text = color_to_hex(color)
	}
}
