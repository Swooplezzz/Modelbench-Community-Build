/// window_draw_startup()

function window_draw_startup()
{
	
	content_x = 0
	content_y = 0
	content_width = window_width
	content_height = window_height
	content_mouseon = app_mouse_box(content_x, content_y, content_width, content_height) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon
	
	// Draw background
	var headersize = 144;
	draw_clear_alpha(c_level_middle, 1)
	draw_pattern(0, headersize, window_width, window_height - headersize)
	
	//draw_gradient(window_width-1000, headersize, 1000, window_height, c_accent,0,0.1,0.1,0)
	//draw_gradient(0, headersize, 1000, window_height, c_accent,0.1,0,0,0.1)

	// Header
	
	draw_box(0, 0, window_width, headersize, false, merge_color(c_level_top, c_level_bottom, .5), 1)
	draw_divide(0, headersize, window_width)
	
	// Logo
			var accent = 0;
				if (setting_accent = 9)
		    accent = setting_accent_custom
	          else
		    accent = setting_theme.accent_list[setting_accent]
			

            // radians: pi - half a hue circle, 2 * pi - full circle
			if(accent != c_white || accent != c_black){
            pos =  2 * pi - degtorad(color_to_hue(accent)) 
			}
			
			
			pos_s =  (1-color_get_sat(accent))
			if(accent == c_black || accent == c_white){
				pos = 0;
				pos_s = 0;
			}
			
			
			u_position = shader_get_uniform(shader_hue, "u_Position"); // control shader
			u_position_s = shader_get_uniform(shader_hue, "u_Position_s"); // control shader
			
			shader_set(shader_hue);
            shader_set_uniform_f(u_position, pos);
            shader_set_uniform_f(u_position_s, pos_s);
		
	       draw_sprite(spr_logo, 0, window_width / 2, headersize/2)
		   
				shader_reset();
		draw_gradient(0, 0, window_width, headersize, c_accent,0,0,0.07,0.07)

	// Version
	draw_button_text(text_get("startupversion", modelbench_version_full), (window_width / 2) + 259, floor((headersize/2) + (sprite_get_height(spr_logo)/2)) + 3, popup_switch, popup_about)
	
	dy = headersize
	dw = min(window_width - 48, 1008)
	
	
	// Recover model
	if (model_recover_show)
	{

		dy += 8
		
		dx = (window_width/2) - (dw/2)
		draw_outline(dx, dy, dw, 128, 1, c_accent, a_accent)
		draw_dropshadow(dx, dy, dw, 128, c_black, 1)
		
		draw_label(text_get("startupmodeldetected"), dx + 16, dy + 16, fa_left, fa_top, c_accent, a_accent, font_heading_big)
		
		draw_label(text_get("startupmodeldetecteddesc"), dx + 16, dy + 64, fa_left, fa_top, c_text_main, a_text_main, font_value)
		
		draw_button_label("startuprecovermodel", dx + dw - 16, (dy + 128) - (32 + 16), null, null, e_button.PRIMARY, model_recover, fa_right)
		
		draw_button_secondary("", dx + dw - 32 - 12, (dy + 12), 0, model_not_recover, icons.CLOSE)
	
		dy += 128 + 8
	
	}
	
	dy += 48
	
	// No recent projects text
	if (ds_list_size(recent_list) = 0)
	{
		draw_label(text_get("recentnone"), window_width / 2, dy, fa_center, fa_middle, c_dkgray, 1, font_heading_big)
		dy += 48
	}
			
	if(recent_list_amount_search = 0 && recent_list_amount > 0){
		draw_label(text_get("recentsearchnone"), window_width / 2, dy, fa_center, fa_middle, c_dkgray, 1, font_heading_big)
	}
	
	// Draw buttons
	var newmodelwidth, browsewidth, centerx;
	newmodelwidth = string_width_font(text_get("startupnewmodel"), font_button) + 52
	browsewidth = string_width_font(text_get("startupbrowse"), font_button) + 52
	centerx = round((window_width / 2) - ((browsewidth + 24 + newmodelwidth + 24) / 2))
	
	if (recent_list_amount > 0)
    dx = (window_width / 2) - (dw / 2)
		else
	dx = (window_width / 2) - 256/2
	// Element search
	if (recent_list_amount > 0){
	tab_control(24)
	draw_textfield("searchmodels",dx, dy, 256, 24, tbx_recent_search, action_recent_search, text_get("recentsearchcaption"), "none")
	tab_next()
	}
	
	if (recent_list_amount > 0)
		dx = (window_width / 2) + (dw / 2) - 24
	else
		dx = centerx + (browsewidth + 24 + newmodelwidth)

	// New model

	draw_settings_button("startupnewmodeloptions", dx, dy, 24, 32, true)
	dx -= newmodelwidth
	draw_button_label("startupnewmodel", dx, dy, null, icons.FILE, e_button.PRIMARY, model_create)
	
	if (recent_list_amount > 0)
		dx -= 12 + browsewidth
	else
		dx = centerx 
	
	// Browse
	draw_button_label("startupbrowse", dx, dy, browsewidth, icons.FOLDER, e_button.SECONDARY, model_load)
	if (recent_list_amount > 0)
	{
		if (draw_button_icon("startuprecentdisplay", dx - 24 - 8, dy + 4, 24, 24, false, recent_display_mode = "grid" ? icons.VIEW_LIST : icons.VIEW_GRID, null, false, recent_display_mode = "grid" ? "tooltipviewlist" : "tooltipviewgrid"))
		{
			if (recent_display_mode = "list")
				recent_display_mode = "grid"
			else
				recent_display_mode = "list"
		}
	}
	//if(keyboard_check_pressed(vk_space)){
	//popup_show(popup_whatsnew)
	//}
	// Show recent models
	if (recent_list_amount > 0)
	{
					draw_gradient(0, headersize, window_width, window_height+100, c_accent,0,0,0.1,0.1)
		// Recent model grid/list button
		dx -= (12 + 28)
		
		dx = (window_width / 2) - (dw / 2)
		
		// Recent models label
		draw_label(text_get("startuprecentmodels"), dx, dy + 16, fa_left, fa_top, c_accent, 1, font_heading)
		dy += 72
		
		var listheight; 
		

		if (recent_display_mode = "list")
			listheight = 28 + min(window_height - dy, (min(ds_list_size(recent_list), 8) * 44))
		else
			listheight = min(window_height - dy, ceil(recent_list_amount_search / 4) * 256)
		tab_control(listheight)
		draw_recent(dx, dy, dw, listheight, recent_display_mode)
		tab_next()
	}
	else
	{
		// Ashley splash
		var midx, midy;
		midx = snap(window_width / 2, 2)
		midy = snap(192 + ((window_height - 192) / 1.75), 2)
		
		// Only draw splash if it fits well on screen
		if ((midy + (sprite_get_height(spr_ashley_splash) / 1.75)) < (window_height - 50)){
			

			draw_image(spr_ashley_splash, 1, midx, midy, 1,1, c_white, 255, 0)
			shader_set(shader_hue);
            shader_set_uniform_f(u_position, pos);
            shader_set_uniform_f(u_position_s, pos_s +.2);
			draw_image(spr_ashley_splash, 2, midx, midy, 1,1, c_white, 255, 0)
			shader_reset();
			shader_clear();
			draw_image(spr_ashley_splash, 0, midx, midy, 1,1, c_white, 255, 0)
			draw_gradient(0, headersize, window_width, window_height+100, c_accent,0,0,0.1,0.1)


		}
	}

}
