/// window_draw()

function window_draw()
{
	draw_clear(c_level_middle)
	
	if (window_state = "startup")
	{
		window_draw_startup()
	}
	else
	{
		panel_area_draw()
		shortcut_bar_draw()
		toolbar_draw()
	}
	
	window_draw_element_move()
	popup_draw()
	menu_draw()
	menu_settings_draw()
	window_draw_toasts()
	tip_draw()
	context_menu_draw()
	debug_info_draw()
}
