// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function popup_lospec_draw(){
if (draw_button_icon("lospecclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	dx += 24
	
	draw_label(text_get("painterlospec"), dx, dy + 24, fa_left, fa_middle, c_accent, a_accent, font_heading_big)
	tab_next()
	
	tab_control_textfield()
	draw_inputbox("lospecname", dx, dy, dw, 24, "Palette name", popup_lospec.tbx_name, null);
	tab_next()
	tab_control_button_label()
	draw_button_label("painterlospecsok", dx, dy, 64, null, e_button.PRIMARY, palette_lospec_import)
	tab_next()
}