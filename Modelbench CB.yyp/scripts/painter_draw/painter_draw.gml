/// painter_draw(x, y, inbounds)
/// @arg x
/// @arg y
/// @arg inbounds

function painter_draw(xx, yy, inbounds)
{
	var boxx, boxy, boxw, boxh;
	var texx, texy, texw, texh;
	
	// Calculate box
	boxx = floor(view_area_x)
	boxy = floor(view_area_y)
	boxw = floor(view_area_width)
	boxh = floor(view_area_height)
	
	texx = scale_offset_x
	texy = scale_offset_y
	texw = paint_texture_width * zoom
	texh = paint_texture_height * zoom
	
	var tex, texscale;
	tex = tex_spr
	texscale = 1
	
	if (adjusting_hue)
        painter_adjust_huesat()
	else if (adjusting_brightness_contrast)
		  painter_adjust_brightness_contrast()
    else
         draw_sprite_ext(final_spr, 0, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 1)

	draw_surface_ext(draw_surf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, paint_opacity)
	draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 0.25)
	
	// Add shortcuts
	if (inbounds)
	{
		window_focus = "painter"
		shortcut_bar_state = "painterviewport"
	}
		
	if (selection_active && paint_tool_selected != e_paint.TRANSFORM_SELECTION && !adjusting_hue)
	{
		draw_painter_selection_outline(c_accent, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0.35, false);
	}

	if (paint_tool_selected = e_paint.TRANSFORM_SELECTION && !adjusting_hue)
		painter_transform(xx, yy)

	//if (adjusting_hue)
	//{
	//	render_shader_obj = shader_map[?shader_huesat]

	//	shader_set(shader_huesat)
	//	render_set_uniform("u_Position", 2 * pi - degtorad(hue))
	//	render_set_uniform("u_Position_s", sat/100)
	//	alphafix
	//	draw_surface_ext(transform_surf, scale_offset_x, scale_offset_y, zoom, zoom, 0, c_white, 1);
	//	gpu_set_blendmode(bm_normal);
	//	shader_reset();
	//	gpu_set_texrepeat(false)
	//	render_shader_obj = shader_map[?shader_selection_outline]
	//	with (render_shader_obj)
	//		shader_use()
				
	//	shader_border_set(c_white, 1, paint_texture_width * zoom, paint_texture_height * zoom, 0.0, 0)
			
	//	draw_surface_ext(selection_surf, scale_offset_x, scale_offset_y, zoom, zoom,0, c_white, 1)

	//	with (render_shader_obj)
	//		shader_clear()
	//	gpu_set_texrepeat(true)
	//}
	
	if(inbounds)
	{
		//Draw Cursor
		if (paint_tool_selected = e_paint.BRUSH || paint_tool_selected = e_paint.ERASE)
		{
			draw_set_alpha(0.875)
			draw_circle_color(((xx + 1) * zoom) + scale_offset_x, ((yy + 1) * zoom) + scale_offset_y, ((paint_width + 0.1) / 2 * zoom) + 1, c_white, c_white, true)
			draw_circle_color(((xx + 1) * zoom) + scale_offset_x, ((yy + 1) * zoom) + scale_offset_y, ((paint_width + 0.1) / 2 * zoom) - 1, c_white, c_white, true)
			draw_circle_color(((xx + 1) * zoom) + scale_offset_x, ((yy + 1) * zoom) + scale_offset_y, (paint_width + 0.1) / 2 * zoom, c_black, c_black, true)
			draw_set_alpha(1)
		}
		else if (paint_tool_selected = e_paint.PICK || paint_tool_selected = e_paint.FILL)
		{
			draw_set_alpha(0.875)
		    draw_box_hover((xx + .5) * zoom + scale_offset_x, (yy + .5)* zoom + scale_offset_y, zoom, zoom, 1, c_white);
		    draw_box_hover((xx + .5) * zoom + scale_offset_x, (yy + .5)* zoom + scale_offset_y, zoom, zoom, 1, c_black);
		    draw_set_alpha(1)
		}
	}

	//draw_rectangle_color( ((xx + .5)* zoom) + scale_offset_x, ((yy + .5) *zoom) + scale_offset_y,((xx + 1.5)* zoom) + scale_offset_x, ((yy + 1.5) *zoom) + scale_offset_y,  c_white, c_white,c_white, c_white, true);
	if (inbounds)
	{
		var iconoffset = [0, 0]
		switch (paint_tool_selected)
		{
			case e_paint.BRUSH:
				mouse_cursor = cr_none
				iconoffset = [-3, 3]
				draw_sprite_ext(spr_icons,icons.BRUSH, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, 0, c_black, .75)
				draw_sprite_ext(spr_icons,icons.BRUSH, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, 0, c_white, .75)
			break
			case e_paint.ERASE:
				mouse_cursor = cr_none
				iconoffset = [-3, 3]
				draw_sprite_ext(spr_icons,icons.ERASER, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, 0, c_black, .75)
				draw_sprite_ext(spr_icons,icons.ERASER, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, 0, c_white, .75)
			break
			case e_paint.PICK:
				mouse_cursor = cr_none
				iconoffset = [-5, 5]
				draw_sprite_ext(spr_icons,icons.PICKER, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, 0, c_black, .75)
				draw_sprite_ext(spr_icons,icons.PICKER, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, 0, c_white, .75)
			break
			case e_paint.FILL:
				mouse_cursor = cr_none
				if !filling
				{
					draw_sprite_ext(spr_icons,icons.FILL_TOOL, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, 0, c_black, .75)
					draw_sprite_ext(spr_icons,icons.FILL_TOOL, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, 0, c_white, .75)
				}
				else
					mouse_cursor = cr_hourglass
			break
			case e_paint.BOX_SELECT:
				mouse_cursor = cr_none
				draw_sprite_ext(spr_icons,icons.BOX_SELECT, window_mouse_get_x() - iconoffset[0], window_mouse_get_y() - iconoffset[1], 1, 1, 0, c_black, .75)
				draw_sprite_ext(spr_icons,icons.BOX_SELECT, window_mouse_get_x() - iconoffset[0] - 1, window_mouse_get_y() - iconoffset[1] - 1, 1, 1, 0, c_white, .75)
			break
		}


	}

	//SELECTION DEBUG, ONLY IN DEV MODE.
	if (dev_mode && debug_info )
	{
	
	}


	// Texture outline
	draw_line_ext(texx, boxy, texx, boxy + boxh, c_border, a_border)
	draw_line_ext(texx + texw + 1, boxy, texx + texw + 1, boxy + boxh, c_border, a_border)
	
	draw_line_ext(boxx, texy, boxx + boxw, texy, c_border, a_border)
	draw_line_ext(boxx, texy + texh + 1, boxx + boxw, texy + texh + 1, c_border, a_border)
	
	gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_color)
	
	// Pixel outline(zoom required multiplied by texscale for bigger textures)
	var snapval = 1;
	if (zoom * texscale > 5 && paint_view_grid)
	{
		var alpha = percent(zoom * texscale, 5, 7);
		
		// Highlight pixels seperately if snap value is not 1
		if (snapval != 1)
		{
			for (var i = texscale; i < paint_texture_width; i += texscale)
			{
				if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
					draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
			
			for (var i = texscale; i < paint_texture_height; i += texscale)
			{
				if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
					draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.03 * alpha), 1)
			}
		}
		
		for (var i = (texscale * snapval); i < paint_texture_width; i += (texscale * snapval))
		{
			if (texx + floor(i * zoom) > boxx && texx + floor(i * zoom) < boxx + boxw)
				draw_line_ext(texx + floor(i * zoom) + 1, texy, texx + floor(i * zoom) + 1, texy + texh, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
		
		for (var i = (texscale * snapval); i < paint_texture_height; i += (texscale * snapval))
		{
			if (texy + floor(i * zoom) > boxy && texy + floor(i * zoom) < boxy + boxh)
				draw_line_ext(texx, texy + floor(i * zoom) + 1, texx + texw, texy + floor(i * zoom) + 1, merge_color(c_black, c_white, 0.15 * alpha), 1)
		}
	}
		
	// Text
	gpu_set_blendmode(bm_normal)
	if(paint_view_brush_guides)
	{
		draw_line_ext((xx + .5) * zoom + scale_offset_x, boxy, (xx + .5) * zoom + scale_offset_x, boxy + boxh,merge_color(c_black,c_accent_pressed, 0.75), .5)
		draw_line_ext((xx + 1.5) * zoom + scale_offset_x, boxy, (xx + 1.5) * zoom + scale_offset_x, boxy + boxh,merge_color(c_black,c_accent_pressed, 0.75), .5)
	    draw_line_ext(boxx, (yy + .5) * zoom + scale_offset_y, boxx + boxw, (yy + .5) * zoom + scale_offset_y,merge_color(c_black,c_accent_pressed, 0.75), .5)
	    draw_line_ext(boxx, (yy + 1.5) * zoom + scale_offset_y, boxx + boxw, (yy + 1.5) * zoom + scale_offset_y,merge_color(c_black,c_accent_pressed, 0.75), .5)
	}
	draw_label("[ 0, 0 ]", texx - 8, texy - 8, fa_right, fa_bottom, c_text_main, 0.5, font_label)
	draw_label("[ " + string(paint_texture_width) + ", 0 ]", texx + texw + 8, texy - 8, fa_left, fa_bottom, c_text_main, 0.5, font_label)
	draw_label("[ 0, " + string(paint_texture_height) + " ]", texx - 8, texy + texh + 8, fa_right, fa_top, c_text_main, 0.5, font_label)
	draw_label("[ " + string(paint_texture_width) + ", " + string(paint_texture_height) + " ]", texx + texw + 8, texy + texh + 8, fa_left, fa_top, c_text_main, 0.5, font_label)
	
	// Info box
	var str = "";
	
	var mxsnap = snap((window_mouse_get_x() - scale_offset_x) / zoom - .5, 1)
	var mysnap = snap((window_mouse_get_y() - scale_offset_y) / zoom - .5, 1)
	
	if (selection_active)
	{
		str += text_get("painterinfoselectionsize") + ": [" + string(selection_size[0]) + ", " + string(selection_size[1]) + "]\n"
		str += text_get("painterinfoselectionangle") + ": " + string(selection_rot) + "°\n"
	}
	str += text_get("painterinfomousepos") + ": [" + string(mxsnap) + ", " + string(mysnap) + "]\n"
	var ww = string_width_font(str, font_label) + 16;
	var hh = string_height_font(str, font_label) + 16;
	
	draw_box(boxx + boxw - ww - 16,  boxy + boxh - hh - 16, string_width_font(str, font_label) + 16, hh, false, c_black, .75)
	draw_label(str, boxx + boxw - ww - 8, boxy + boxh - hh - 8, fa_left, fa_top, c_white, 1, font_label)
}