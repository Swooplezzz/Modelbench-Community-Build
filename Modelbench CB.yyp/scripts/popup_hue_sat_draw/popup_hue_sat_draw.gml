/// popup_hue_sat_draw()

function popup_hue_sat_draw()
{
	if (draw_button_icon("huesatclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	dx += 24
	
	draw_label(text_get("painteradjustmentshuesat"), dx, dy + 24, fa_left, fa_middle, c_accent, a_accent, font_heading_big)
	tab_next()
	
	tab_control_meter()
	draw_meter("painteradjustmentshue", dx, dy, dw - 48, hue, 1, -180, 180, 0, 1, popup_huesat.tbx_hue, action_painter_adjust_hue)
	tab_next()
	
	tab_control_meter()
	draw_meter("painteradjustmentssat", dx, dy, dw - 48, sat, 1, 0, 200, 100, 1, popup_huesat.tbx_sat, action_painter_adjust_sat)
	tab_next()
	
	tab_control_meter()
	draw_meter("painteradjustmentsval", dx, dy, dw - 48, val, 1, -100, 100, 0, 1, popup_huesat.tbx_val, action_painter_adjust_val)
	tab_next()
	
	tab_control_button_label()
	draw_button_label("painteradjustmentsok", dx, dy, 64, null, e_button.PRIMARY, painter_apply_huesat)
	tab_next()
}