/// tab_element_editor_wind()

function tab_element_editor_wind()
{
	context_menu_group_temp = e_context_group.WIND
	
	var axistext, text;
	axistext = (setting_z_is_up ? "z" : "y")
	
	if (el_edit.value[e_value.WIND_AXIS] = e_vertex_wave.ALL)
		text = "elementeditorwindaxisall"
	else if (el_edit.value[e_value.WIND_AXIS] = e_vertex_wave.Z_ONLY)
		text = "elementeditorwindaxis" + axistext
	else
		text = "elementeditorwindaxisnone"
	
	// Wind axis
	tab_control_menu()
	draw_button_menu("elementeditorwindaxis", e_menu.LIST, dx, dy, dw, 24, el_edit.value[e_value.WIND_AXIS], text_get(text), action_el_wind_axis)
	tab_next()
	
	if (el_edit.value[e_value.WIND_AXIS] = e_vertex_wave.NONE)
		return 0
	
	// Minimum Z
	tab_control_switch()
	draw_switch("elementeditorwindminimum" + axistext, dx, dy, el_edit.value[e_value.WIND_ZMIN_ENABLE], action_el_wind_zmin_enable)
	tab_next()
	
	if (el_edit.value[e_value.WIND_ZMIN_ENABLE])
	{
		tab_control_dragger()
		draw_dragger("elementeditorwindminimum", dx, dy, dragger_width, el_edit.value[e_value.WIND_ZMIN], 0.1, -no_limit, no_limit, 0, snap_min, tab.wind.tbx_zmin, action_el_wind_zmin)
		tab_next()
	}
	
	// Maximum Z
	tab_control_switch()
	draw_switch("elementeditorwindmaximum" + axistext, dx, dy, el_edit.value[e_value.WIND_ZMAX_ENABLE], action_el_wind_zmax_enable)
	tab_next()
	
	if (el_edit.value[e_value.WIND_ZMAX_ENABLE])
	{
		tab_control_dragger()
		draw_dragger("elementeditorwindmaximum", dx, dy, dragger_width, el_edit.value[e_value.WIND_ZMAX], 0.1, -no_limit, no_limit, 0, snap_min, tab.wind.tbx_zmax, action_el_wind_zmax)
		tab_next()
	}
}
