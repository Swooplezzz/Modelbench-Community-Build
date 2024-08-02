/// tab_element_editor_mineimator()

function tab_element_editor_mineimator()
{
	context_menu_group_temp = e_context_group.MINEIMATOR
	
	/// (Render) depth
	tab_control_dragger()
	draw_dragger("elementeditordepth", dx, dy, dragger_width, el_edit.value[e_value.DEPTH], 0.1, -no_limit, no_limit, 0, 1, element_editor.tbx_depth, action_el_depth)
	tab_next()
	
	/// Show backfaces
	tab_control_checkbox()
	draw_switch("elementeditorshowbackfaces",dx,dy, el_edit.value[e_value.SHOW_BACKFACES], action_el_show_backfaces);
	tab_next()
	
	// Open position tab
	tab_control_switch()
	draw_switch("elementeditoropenpositiontab", dx, dy, el_edit.value[e_value.OPEN_POSITION_TAB], action_el_open_position_tab, "elementeditoropenpositiontabhelp")
	tab_next()
	
	//// Texture
	//var value, text;
	
	//if (el_edit.value[e_value.IK_TARGET] != null)
	//{
	//	value = el_edit.value[e_value.IK_TARGET]
	//	text = value.name
	//}
	//else
	//{
	//	value = null
	//	text = text_get("elementeditornopart")
	//}
	
	//tab_control_menu(32)
	//draw_button_menu("elementeditoriktarget", e_menu.LIST, dx, dy, dw, 32, value, text, action_el_ik_target, false)
	//tab_next()
	//if (el_edit.value[e_value.IK_ANGLE_TARGET] != null)
	//{
	//	value = el_edit.value[e_value.IK_ANGLE_TARGET]
	//	text = value.name
	//}
	//else
	//{
	//	value = null
	//	text = text_get("elementeditornopart")
	//}

	//tab_control_menu(32)
	//draw_button_menu("elementeditorikangle", e_menu.LIST, dx, dy, dw, 32, value, text, action_el_ik_angle_target, false)
	//tab_next()
}
