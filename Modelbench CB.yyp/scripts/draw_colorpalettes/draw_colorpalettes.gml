/// draw_colorpalettes()

function draw_colorpalettes()
{
	for (var c = 0; c < ds_list_size(palette_list); c++)
	{
		var	itemw = dw - ((setting_compact_elements ? 20 : 24))
		if (tab.color_editor.name_edit_element != palette_list[|c])
		{
			var labelshort = string_limit_font(palette_list[|c].name, itemw, font_heading)
			draw_label(labelshort, dx, dy+12, fa_left, fa_middle, c_accent, 1, font_heading)
			var boxwid = min(string_width(labelshort) + 32, itemw);
			
			if (app_mouse_box(dx, dy, boxwid, 24))
			{
				if (mouse_left_double_pressed)
				{
					window_busy = string(tab.color_editor.tbx_name)
					window_focus = string(tab.color_editor.tbx_name)
					tab.color_editor.tbx_name.text = palette_list[|c].name
					tab.color_editor.name_edit_element = palette_list[|c]
				}
			}
		}
		// Edit name
		if (tab.color_editor.name_edit_element = palette_list[|c])
		{
			draw_set_font(font_heading)
			if (textbox_draw(tab.color_editor.tbx_name, dx, dy+4, itemw, 32))
			{
				palette_list[|c].name = tab.color_editor.tbx_name.text
			}
		
			if (window_focus != string(tab.color_editor.tbx_name))
			{
				tab.color_editor.name_edit_element = null
				palettes_save()
			}
		}
		var yy = dy;
		dy += 30
		var xx = dx;
		for(var i = 0; i < array_length(palette_list[|c].color_list); i++)
		{
			if (xx >= (dx + content_width - 28 - 33))
			{
				xx = dx	
				dy += 28
			}
			draw_button_colorpalette("col" + string(c) + string(i), xx+6, dy, palette_list[|c].color_list[i], action_painter_palette_pick_color, action_edit_palette_color, action_delete_palette_color, c, i)
			xx += 28
		}
		
		if (xx >= (dx + content_width - 28 - 33))
		{
			xx = dx	
			dy += 28
		}
		draw_button_icon_value("deletepalette" + string(c), dx + content_width - 28 - 24, yy, 24, 24,c, icons.DELETE, action_painter_palette_remove)
		draw_button_icon_value("exportpalette" + string(c), dx + content_width - 28 - 52, yy, 24, 24,c, icons.ASSET_EXPORT, action_painter_palette_export)
		draw_button_icon_value("addcolor" + string(c), xx+6, dy, 24,24, c, icons.PLUS, action_painter_add_palette_color)
		dy += 32
		
		draw_divide(dx + 1, dy - 3, content_width - 28)
	}
}