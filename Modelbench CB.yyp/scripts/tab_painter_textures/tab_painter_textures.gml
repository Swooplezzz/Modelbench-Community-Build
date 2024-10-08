/// tab_painter_textures()

function tab_painter_textures()
{
	// Preview selected texture
	var itemhover = null;
	dw = content_width - 24
	
	tab_control(ds_list_size(textures_list.item) * 32)
	for (var i = 0; i < ds_list_size(textures_list.item); i++)
	{
		var tex = textures_list.item[|i];

		list_item_draw(tex, dx, dy + i * 32, dw, 32, tex.value = res_edit, 4, 0, true, true)
		
		if (!itemhover && app_mouse_box(dx, dy + i * 32, dw, 32))
			itemhover = tex
		
		context_menu_area(dx, dy + i * 32, dw, 32, "contextmenutexture", tex.value, null, null, null)
	}
	tab_next()
	
	// Add shortcuts
	if (itemhover != null)
	{
		if (itemhover.value = res_edit)
			shortcut_bar_state = "contextmenutexturedeselect"
		else
			shortcut_bar_state = "contextmenutextureselect"
	}
	textfield_group_add("paintertexsizex", paint_texture_width, 16, action_painter_size_width, X, tab.textures.tbx_width)
	textfield_group_add("paintertexsizey", paint_texture_height, 16, action_painter_size_height, Y, tab.textures.tbx_height)
	
	tab_control_textfield_group(false, false)
	draw_textfield_group("paintertexsize", dx, dy, dw, 1, 1, 512, 1, false, false, 0, false)
	tab_next()
	
	// Add texture
	tab_control(24)
	
	if (program_mode = e_mode.TEXTURING)
		if (draw_button_icon("assetscreatetexture", dx, dy, 24, 24, false, icons.PLUS, null, false, "assetscreatetexture"))
			action_texture_create()
	
	if (draw_button_icon("assetsaddtexture", dx + 28, dy, 24, 24, false, icons.FOLDER_ADD, null, false, "assetsaddtexture"))
	{
		var fn = file_dialog_open_image();
		
		if (fn != "")
			action_texture_add(fn)
	}
	
	tab_next()
}