// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function popup_whatsnew_draw(){
	// Header
	//draw_box(dx, dy, dw, 156, false, c_overlay, a_overlay)
	
	// Close
	if (draw_button_icon("whatsnewclose", dx + dw - 12 - 28, dy + 8, 28, 28, false, icons.CLOSE, null, false))
		popup_close()
	
	
	//// Logo
	//			var accent = 0;
	//			if (setting_accent = 9)
	//	    accent = setting_accent_custom
	//          else
	//	    accent = setting_theme.accent_list[setting_accent]
			

    //        // radians: pi - half a hue circle, 2 * pi - full circle
	//		if(accent != c_white || accent != c_black){
    //        pos =  2 * pi - degtorad(color_to_hue(accent))
	//		}
			
			
	//		pos_s =  1-color_get_sat(accent)

	//		if(accent == c_black || accent == c_white){
	//			pos = 0;
	//			pos_s = 0;
	//		}
			
			
	//		u_position = shader_get_uniform(shader_hue, "u_Position"); // control shader
	//		u_position_s = shader_get_uniform(shader_hue, "u_Position_s"); // control shader
			
	//		shader_set(shader_hue);
    //        shader_set_uniform_f(u_position, pos);
    //        shader_set_uniform_f(u_position_s, pos_s);
	//gpu_set_tex_filter(true)
	//draw_sprite_ext(spr_logo, 0, dx + dw / 2, dy + 54, .75, .75, 0, c_white, draw_get_alpha())
	//gpu_set_tex_filter(false)
	//shader_clear()
	
	// Program info
	var text, width, textx;
	text = text_get("aboutversion", modelbench_version_full) + text_get("aboutreleasedate", modelbench_version_date)
	width = string_width_font(text, font_value)
	textx = dx + dw/2 - width/2
	
	draw_label("What's new ?", dx + 24, dy + 42, fa_left, fa_middle, c_accent, a_accent, font_heading_huge);


	
	dy += 128 + 48
	dx = content_x + 64
	
}