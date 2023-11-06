/// tab_element_editor_position()

function tab_camera_editor_position()
{
	
		var cam = id;
	
	if (object_index = app)
		cam = view_cam
		
	context_menu_group_temp = e_context_group.POSITION
	tab_element_editor_buttons()
	draw_label(text_get("elementeditorposition"), dx, dy + 12, fa_left, fa_middle, c_text_secondary, a_text_secondary, font_label)
	dy += 26
	
	textfield_group_add("elementeditorpositionx", cam.value[e_value.POS_X], 0, action_el_pos, X, tab.camera.tbx_pos_x)
	
	axis_edit = (setting_z_is_up ? Y : Z)
	textfield_group_add("elementeditorpositiony", cam.value[e_value.POS_X + axis_edit], 0, action_el_pos, axis_edit, tab.camera.tbx_pos_y)
	
	axis_edit = (setting_z_is_up ? Z : Y)
	textfield_group_add("elementeditorpositionz", cam.value[e_value.POS_X + axis_edit], 0, action_el_pos, axis_edit, tab.camera.tbx_pos_z)
	
	tab_control_textfield_group(false)
	draw_textfield_group("elementeditorposition", dx, dy, dw, 0.1, -no_limit, no_limit, dragger_snap ? setting_snap_size_position : snap_min, false, true, 1)
	tab_next()
}
