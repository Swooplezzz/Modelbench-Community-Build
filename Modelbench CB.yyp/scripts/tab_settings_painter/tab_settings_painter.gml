/// tab_settings_painter()

function tab_settings_painter()
{
	tab_control(20)
	draw_label(text_get("settingspainterkeybinds") + ":", dx, dy + 10, fa_left, fa_middle, c_text_tertiary, a_text_tertiary, font_label) 
	tab_next()
	
	tab_control_switch()
	draw_button_collapse("paintertools", collapse_map[?"paintertools"], null, true, "settingspaintertools")
	tab_next()
	
	if (collapse_map[?"paintertools"])
	{
		tab_collapse_start()
		
		draw_keybind(e_keybind.BRUSH, dx, dy)
		draw_keybind(e_keybind.ERASE, dx, dy)
		draw_keybind(e_keybind.PICK, dx, dy)
		draw_keybind(e_keybind.FILL, dx, dy)
		draw_keybind(e_keybind.BOX_SELECT, dx, dy)
		draw_keybind(e_keybind.TRANSFORM_SELECTION, dx, dy)
		draw_keybind(e_keybind.BRUSH_WIDTH, dx, dy)
		draw_keybind(e_keybind.VIEW_PTR_GRID, dx, dy)
		draw_keybind(e_keybind.VIEW_PTR_GUIDES, dx, dy)
		dy += 8
		
		tab_collapse_end(true)
	}

}