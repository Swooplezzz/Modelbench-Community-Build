/// header_element_editor()

function header_element_editor()
{
	dy += 8
	
	// Name
	var text, placeholder;
	text = (el_edit.element_type = TYPE_PART ? "elementeditorpartname" : "elementeditorshapename")
	placeholder = (el_edit.element_type = TYPE_SHAPE ? text_get("elementeditornewshape") : text_get("elementeditornewpart"))
	
	tab_control_textfield()
	element_editor.tbx_name.text = el_edit.name
	if (draw_textfield(text, dx, dy, dw, 24, element_editor.tbx_name, action_el_name, placeholder, "top", (el_edit.name_duplicate || el_edit.name_empty) && setting_show_name_warnings) && setting_show_name_warnings)
		el_edit.name = element_editor.tbx_name.text
	tab_next()

	if ((el_edit.name_duplicate || el_edit.name_empty) && setting_show_name_warnings)
	{
		var text = "";
	
		if (el_edit.name_empty)
			text = text_get("elementeditoremptypartname")
		else
			text = text_get("elementeditorsamepartname")
	
		tab_control(8)
		draw_label(text, dx, dy + 8, fa_left, fa_bottom, c_error, 1, font_caption)
		tab_next()
	}

	dy += 8
}
