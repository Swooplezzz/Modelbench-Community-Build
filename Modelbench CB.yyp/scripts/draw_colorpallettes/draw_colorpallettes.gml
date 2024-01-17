// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_colorpallettes(){
		for(var c = 0; c < ds_list_size(pallette_list); c++){
					var	itemw = dw - ((setting_compact_elements ? 20 : 24))
	if (tab.color_editor.name_edit_element != pallette_list[|c])
	{


		var labelshort = string_limit_font(pallette_list[|c].name, itemw, font_heading)
		draw_label(labelshort, dx, dy, fa_left, fa_middle, c_accent, 1, font_heading)
			var boxwid = min(string_width(labelshort) + 32, itemw);
			
			if (app_mouse_box(dx, dy, boxwid, 24))
			{
				if (mouse_left_double_pressed)
				{
					window_busy = string(tab.color_editor.tbx_name)
					window_focus = string(tab.color_editor.tbx_name)
					tab.color_editor.tbx_name.text = pallette_list[|c].name
					tab.color_editor.name_edit_element = pallette_list[|c]
				}
			}
	}
	// Edit name
	if (tab.color_editor.name_edit_element = pallette_list[|c])
	{
		draw_set_font(font_heading)
		if (textbox_draw(tab.color_editor.tbx_name, dx, dy-8, itemw, 32))
		{
				pallette_list[|c].name = tab.color_editor.tbx_name.text
		}
		
		if (window_focus != string(tab.color_editor.tbx_name))
		{
			tab.color_editor.name_edit_element = null
			pallettes_save()
		}
	}
		dy += 16

			var xx = dx;
		for(var i = 0; i < array_length(pallette_list[|c].color_list); i++){
		if(xx >= (dx + content_width - 64 - 28 - 28)){
		xx = dx	
		dy += 28
		}
		
		draw_button_colorpallette("col" + string(c) + string(i), xx+16, dy, pallette_list[|c].color_list[i], action_painter_pallette_pick_color, action_edit_pallette_color, action_delete_pallette_color, c, i)
		xx += 28
		}
		if(xx >= (dx + content_width - 64 - 28 - 28)){
		xx = dx	
		dy += 28
		}
		draw_button_icon_value("deletepallette" + string(c), dx+8 + content_width - 48, dy, 24,24,c, icons.DELETE, action_painter_pallette_remove)
		draw_button_icon_value("exportpallette" + string(c), dx + content_width - 48 - 24,  dy, 24,24,c, icons.FILE_EXPORT, action_painter_pallette_export)
		draw_button_icon_value("addcolor" + string(c), xx+16,  dy, 24,24, c, icons.PLUS, action_painter_add_pallette_color)
		dy += 38
		}
}