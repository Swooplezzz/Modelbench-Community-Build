/// popup_about_draw()

function popup_about_draw()
{
	// Header
	draw_box(dx, dy, dw, 156, false, c_overlay, a_overlay)
	
	// Close
	if (draw_button_icon("aboutclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	// Logo
	gpu_set_tex_filter(true)
	draw_image_accent(spr_logo, 0, dx + dw / 2, dy + 54, .75, .75, c_white, draw_get_alpha(), 0)
	gpu_set_tex_filter(false)
	
	// Program info
	var text, width, textx;
	text = text_get("aboutversion", modelbench_version_full) + text_get("aboutreleasedate", modelbench_version_date)
	width = string_width_font(text, font_value)
	textx = dx + dw/2 - width/2
	
	draw_button_text(text_get("aboutversion", modelbench_version_full), textx, dy + 120, open_url, "https://www.communitybuild.netlify.app", "https://www.communitybuild.netlify.app")
	textx += string_width_font(text_get("aboutversion", modelbench_version_full), font_value)
	
	draw_label(text_get("aboutreleasedate", modelbench_version_date), textx, dy + 120, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_value)
	draw_label(text_get("aboutforversion", "Mine-imator 2.0+"), content_x + dw/2, dy + 120 + 19, fa_middle, fa_bottom, c_text_secondary, a_text_secondary, font_value)
	
	dy += 128 + 48
	dx = content_x + 64
	
	// Development
	dy += 12
	draw_label(text_get("aboutmoddevelopment"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_button_text("Swooplezz", dx, dy,  open_url, "https://www.twitter.com/@swooplezz", "https://www.twitter.com/@swooplezz", a_text_secondary, font_label)
	
	dy += 34
	draw_label(text_get("aboutdevelopment"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_label("Nimi", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	
	// UI/Branding
	dy += 34
	draw_label(text_get("aboutuibranding"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_label("Voxy", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	
		dx += 130 + 24
	dy = content_y + 176
	dy += 12
	
	// Beta testing

	draw_label(text_get("aboutbetatesting"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_label("mbanders", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("SoundsDotZip", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	
	dy += 19
	
	draw_label("Jossamations", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("BNMBrandonMI", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("TME", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("03Aaron", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("Chrisation", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("AlphaToostrr", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("Jnick", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	dy += 19
	draw_label("AnimaCryses", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		dy += 19
	draw_label("DarthLilo", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		dy += 19
	draw_label("ExoticBuilder", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	// Special thanks
		dy += 19
	
	draw_label("JacksieBoi", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		dy += 19
	
	draw_label("_Mine_", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		dy = content_y + 176
	dy += 12
	dx += 130 + 24
	

	draw_label(text_get("aboutspecialthanks"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_button_text("David", dx, dy, open_url, "https://www.stuffbydavid.com", "https://www.stuffbydavid.com", font_label)
	dy += 19
	for (var i = 0; i < ds_list_size(special_thanks_list); i++)
	{
		draw_label(special_thanks_list[|i], dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		dy += 19
		
		// Next row
		if (i = 10)
		{
			dx += 130 + 24
			dy = content_y + 176 + 38
		}
	}
}
