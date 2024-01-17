// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tab_painter_textures(){
// Preview selected texture
	var itemhover = null;
	
	tab_control(ds_list_size(textures_list.item) * 32)
	for (var i = 0; i < ds_list_size(textures_list.item); i++)
	{
		var tex = textures_list.item[|i];

		list_item_draw(tex, dx, dy + i * 32, dw, 32, tex.value = res_edit, 4)
		
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
	
	// Add texture
	tab_control_button_label()
	if (draw_button_label("assetsaddtexture", floor(dx + dw/2), dy, null, icons.PLUS, e_button.PRIMARY, null, e_anchor.CENTER))
	{
		var fn = file_dialog_open_image();
		
		if (fn != "")
			action_texture_add(fn)
	}
	
	tab_next()
}