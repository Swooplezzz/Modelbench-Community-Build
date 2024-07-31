/// popup_whatsnew_draw()

function popup_whatsnew_draw()
{
	// Header
	//draw_box(dx, dy, dw, 156, false, c_overlay, a_overlay)
	
	// Close
	if (draw_button_icon("whatsnewclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	//// Logo
	//gpu_set_tex_filter(true)
	//draw_image_accent(spr_logo, 0, dx + dw / 2, dy + 54, .75, .75, c_white, draw_get_alpha(), 0)
	//gpu_set_tex_filter(false)
	
	// Program info
	var text, width, textx;
	text = text_get("aboutversion", modelbench_version_full) + text_get("aboutreleasedate", modelbench_version_date)
	width = string_width_font(text, font_value)
	textx = dx + dw/2 - width/2
	
	draw_label("What's new ?", dx + 24, dy + 42, fa_left, fa_middle, c_accent, a_accent, font_heading_huge)
	
	dy += 128 + 48
	dx = content_x + 64
}