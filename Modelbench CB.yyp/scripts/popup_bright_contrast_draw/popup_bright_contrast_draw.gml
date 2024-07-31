/// popup_bright_contrast_draw()

function popup_bright_contrast_draw()
{
	if (draw_button_icon("brightcontrastclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	dx += 24
	
	draw_label(text_get("painteradjustmentsbrightnesscontrast"), dx, dy + 24, fa_left, fa_middle, c_accent, a_accent, font_heading_big)
	tab_next()
	
	tab_control_meter()
	draw_meter("painteradjustmentsbrightness", dx, dy, dw - 48, painter_adjust_brightness, 1, -100, 100, 0, 1, popup_brightcontrast.tbx_brightness, action_painter_adjust_brightness)
	tab_next()
	
	tab_control_meter()
	draw_meter("painteradjustmentscontrast", dx, dy, dw - 48, painter_adjust_contrast, 1, -100, 100, 0, 1, popup_brightcontrast.tbx_contrast, action_painter_adjust_contrast)
	tab_next()
	
	tab_control_button_label()
	draw_button_label("painteradjustmentsok", dx, dy, 64, null, e_button.PRIMARY, painter_apply_brightness_contrast)
	tab_next()
}