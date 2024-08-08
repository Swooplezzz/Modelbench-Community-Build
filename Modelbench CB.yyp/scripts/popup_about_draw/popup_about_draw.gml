/// popup_about_draw()

function popup_about_draw()
{
	// Header
	draw_box(dx, dy, dw, 144, false, c_overlay, a_overlay)
	
	// Close
	if (draw_button_icon("aboutclose", dx + dw - 12 - 26, dy + 10, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	// Logo
	gpu_set_tex_filter(true)
	draw_image_accent(spr_logo, 0, dx + dw / 2, dy + 54, .75, .75, c_white, draw_get_alpha(), 0)
	gpu_set_tex_filter(false)
	
	// Program info
	var text, width, textx;
	text = text_get("aboutversion", modelbench_version_full) + text_get("aboutreleasedate", modelbench_version_date)
	width = string_width_font(text, font_value)
	textx = floor(dx + dw/2 - width/2)
	
	draw_button_text(text_get("aboutversion", modelbench_version_full), textx, dy + 114, open_url, "https://www.communitybuild.netlify.app", "https://www.communitybuild.netlify.app")
	textx += string_width_font(text_get("aboutversion", modelbench_version_full), font_value)
	
	draw_label(text_get("aboutreleasedate", modelbench_version_date), textx, dy + 114, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_value)
	draw_label(text_get("aboutforversion", "Mine-imator 2.0.2 Community Build 1.0.0+"), content_x + dw/2, dy + 114 + 19, fa_middle, fa_bottom, c_text_secondary, a_text_secondary, font_value)
	
	dy += 128 + 48
	dx = content_x + 64
	
	// Mod development
	dy += 12
	draw_label(text_get("aboutmoddevelopment"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_button_text("Swooplezz", dx, dy, popup_open_url, "https://x.com/@swooplezz", "https://x.com/@swooplezz", font_label)
	dy += 19
	draw_button_text("mbanders", dx, dy, popup_open_url, "https://x.com/@mbandersmc", "https://x.com/@mbandersmc", font_label)
	
	// Created by
	dy += 34
	draw_label(text_get("aboutmodelbenchcreator"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_label("Nimi", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	
	// UI/Branding
	dy += 34
	draw_label(text_get("aboutuibranding"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	draw_label("Voxy", dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
	
	dx += 130 + 24
	dy = content_y + 176
	//dx -= 130 + 24
	//dy += 34
	
	// Beta testing
	dy += 12
	draw_label(text_get("aboutbetatesting"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	
	var btlist = [
		"03Aaron_",
		"AhmedAAK",
		"Alpha Toostrr",
		"AnimaCryses",
		"beenabun",
		"BeinBian",
		"Binky214",
		"BNMBrandonMI",
		"Cade [CaZaKoJa]",
		"CharloJane",
		"Chrisation",
		"DarthLilo",
		"Elkav",
		"ExoticBuilder",
		"FrostyIzHere",
		"Hexical Brine",
		"JacksieBoi",
		"Jnick",
		"Jossamations",
		"KaylaGT3R",
		"KJMineImator",
		"Mello",
		"myradoesstuff",
		"Nugcon",
		"Rollo",
		"ScarletCassette",
		"SoundsDotZip",
		"StarWeevil",
		"Supah.exe",
		"TahoeBeatz",
		"Thaliaphobia",
		"TME",
		"__Mine__"
	]
	
	for (var i = 0; i < array_length(btlist); i++)
	{
		draw_label(btlist[i], dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		
		if (i % 3 = 2)
		{
			dx -= (130 + 24) * 2
			dy += 19
		}
		else
			dx += 130 + 24
	}
	
	//dx += 130 + 24
	//dy = content_y + 176
	
	// Beta testing
	dy += 12
	draw_label(text_get("aboutspecialthanks"), dx, dy, fa_left, fa_bottom, c_text_tertiary, a_text_tertiary, font_subheading)
	dy += 26
	
	var stlist = [
		"9redwoods",
		"AnxiousCynic",
		"David",
		"Hozq",
		"KeepOnChucking",
		"Marvin",
		"Nimi",
		"SKIBBZ",
		"UpgradedMoon",
		"Vash"
	]
	
	for (var i = 0; i < array_length(stlist); i++)
	{
		draw_label(stlist[i], dx, dy, fa_left, fa_bottom, c_text_secondary, a_text_secondary, font_label)
		
		if (i % 3 = 2)
		{
			dx -= (130 + 24) * 2
			dy += 19
		}
		else
			dx += 130 + 24
	}
	
	dy += (12 + 32)
}