/// draw_button_color(name, x, y, value, script)
/// @arg name
/// @arg x
/// @arg y
/// @arg value
/// @arg script

function draw_button_colorpalette(name, xx, yy, value, script, script2, script3, c, i)
{
	var h, w, mouseon, mouseclick, active;
	h = 24
	w = h;
	//yy += (label_height + 8)
	
	//active = (settings_menu_name = "colorpicker" && colorpicker.value_name = name)
	mouseon = app_mouse_box(xx, yy, w, h) && content_mouseon
	mouseclick = mouseon && mouse_left
	
	if (mouseon)
		mouse_cursor = cr_handpoint
	
	microani_set(name, script, mouseon, mouseclick, false, false, 1, true)
	
	// Draw button
	var col, alpha, labelcolor, labelalpha;
	
	// Fill
	col = merge_color(0, c_overlay, microani_arr[e_microani.HOVER])
	col = merge_color(col, c_accent_overlay, microani_arr[e_microani.ACTIVE])
	alpha = lerp(0, a_overlay, microani_arr[e_microani.HOVER])
	alpha = lerp(alpha, a_accent_overlay, microani_arr[e_microani.ACTIVE])
	draw_box(xx, yy, w, h, false, c_level_top, 1)
	draw_box(xx, yy, w, h, false, col, alpha)
	
	// Fill border
	col = merge_color(c_border, c_text_tertiary, microani_arr[e_microani.HOVER])
	col = merge_color(col, c_accent, microani_arr[e_microani.ACTIVE])
	alpha = lerp(a_border, a_text_tertiary, microani_arr[e_microani.HOVER])
	alpha = lerp(alpha, a_accent, microani_arr[e_microani.ACTIVE])
	draw_outline(xx, yy, w, h, 1, col, alpha, true)
	
	// Color
	draw_box(xx + 4, yy + 4, w - 8, h - 8, false, value, 1)

	
	//// Hover
	//draw_box_hover(xx, yy, w, h, microani_arr[e_microani.PRESS])
	
	//// Label
	//labelcolor = merge_color(c_text_secondary, c_text_main, microani_arr[e_microani.HOVER])
	//labelcolor = merge_color(labelcolor, c_accent, microani_arr[e_microani.ACTIVE])
	//labelcolor = merge_color(labelcolor, c_text_tertiary, microani_arr[e_microani.DISABLED])
	
	//labelalpha = lerp(a_text_secondary, a_text_main, microani_arr[e_microani.HOVER])
	//labelalpha = lerp(labelalpha, a_accent, microani_arr[e_microani.ACTIVE])
	//labelalpha = lerp(labelalpha, a_text_tertiary, microani_arr[e_microani.DISABLED])
	
	//draw_set_font(font_label)
	//draw_label(string_limit(text_get(name), w - 8), xx, yy - (label_height + 8), fa_left, fa_top, labelcolor, labelalpha)
	
	microani_update(mouseon, mouseclick, (mouseon && (mouse_left || mouse_right || mouse_middle)), false)
	
	if (mouseon)
	{
		if (mouse_left_released)
		{
			if (script != null)
				script_execute(script, value)
		}
		if (mouse_right_released)
		{
			if (script2 != null)
			{
				painter_palette_id = c;
				painter_palette_col = i;
				colorpicker_show(name, palette_list[|c].color_list[i], c_black, action_edit_palette_color, xx, yy, w, h)
				colorpicker.mode = "hsv"
			}
		}
		if (mouse_middle_released)
		{
			if (script3 != null)
				script_execute(script3, c, i)
		}
	}
}
