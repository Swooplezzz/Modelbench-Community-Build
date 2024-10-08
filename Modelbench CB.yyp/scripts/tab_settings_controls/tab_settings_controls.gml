/// tab_settings_controls()

function tab_settings_controls()
{
	tab_control(20)
	draw_label(text_get("settingscontrolskeybinds") + ":", dx, dy + 10, fa_left, fa_middle, c_text_tertiary, a_text_tertiary, font_label) 
	tab_next()
	
	tab_control_switch()
	draw_button_collapse("file", collapse_map[?"file"], null, true, "settingscontrolsfile")
	tab_next()
	
	if (collapse_map[?"file"])
	{
		tab_collapse_start()
		
		draw_keybind(e_keybind.MODEL_NEW, dx, dy)
		draw_keybind(e_keybind.MODEL_NEW_TEMPLATE, dx, dy)
		draw_keybind(e_keybind.MODEL_OPEN, dx, dy)
		draw_keybind(e_keybind.MODEL_SAVE, dx, dy)
		draw_keybind(e_keybind.MODEL_SAVE_AS, dx, dy)
		draw_keybind(e_keybind.MODEL_IMPORT, dx, dy)
		dy += 8
		
		tab_collapse_end(true)
	}
	
	tab_control_switch()
	draw_button_collapse("edit", collapse_map[?"edit"], null, true, "settingscontrolsediting")
	tab_next()
	
	if (collapse_map[?"edit"])
	{
		tab_collapse_start()
		
		draw_keybind(e_keybind.UNDO, dx, dy)
		draw_keybind(e_keybind.REDO, dx, dy)
		draw_keybind(e_keybind.RENAME, dx, dy)
		draw_keybind(e_keybind.ELEMENT_ADD, dx, dy)
		draw_keybind(e_keybind.ELEMENT_DELETE, dx, dy)
		draw_keybind(e_keybind.ELEMENT_DUPLICATE, dx, dy)
		draw_keybind(e_keybind.SELECT_ALL, dx, dy)
		draw_keybind(e_keybind.UV_EDITOR, dx, dy)
		draw_keybind(e_keybind.ELEMENT_MIRROR, dx, dy)
		draw_keybind(e_keybind.ELEMENT_MIRROR_X, dx, dy)
		draw_keybind(e_keybind.ELEMENT_MIRROR_Z, dx, dy)
		dy += 8
		
		tab_collapse_end(true)
	}
	
	tab_control_switch()
	draw_button_collapse("tools", collapse_map[?"tools"], null, true, "settingscontrolstools")
	tab_next()
	
	if (collapse_map[?"tools"])
	{
		tab_collapse_start()
		
		draw_keybind(e_keybind.TOOL_SELECT, dx, dy)
		draw_keybind(e_keybind.TOOL_MOVE, dx, dy)
		draw_keybind(e_keybind.TOOL_PIVOT, dx, dy)
		draw_keybind(e_keybind.TOOL_ROTATE, dx, dy)
		draw_keybind(e_keybind.TOOL_RESIZE, dx, dy)
		draw_keybind(e_keybind.TOOL_SCALE, dx, dy)
		draw_keybind(e_keybind.TOOL_BEND, dx, dy)
		draw_keybind(e_keybind.TOOL_TRANSFORM, dx, dy)
		draw_keybind(e_keybind.FREE_POS, dx, dy)
		draw_keybind(e_keybind.FREE_ROT, dx, dy)
		draw_keybind(e_keybind.FREE_SCA, dx, dy)
		draw_keybind(e_keybind.SNAP, dx, dy)
		
		dy += 8
		draw_divide(dx, dy, dw)
		dy += 8
		
		draw_keybind(e_keybind.BRUSH, dx, dy)
		draw_keybind(e_keybind.ERASE, dx, dy)
		draw_keybind(e_keybind.PICK, dx, dy)
		draw_keybind(e_keybind.FILL, dx, dy)
		draw_keybind(e_keybind.SHAPE, dx, dy)
		draw_keybind(e_keybind.BOX_SELECT, dx, dy)
		draw_keybind(e_keybind.TRANSFORM_SELECTION, dx, dy)
		draw_keybind(e_keybind.BRUSH_WIDTH, dx, dy)
		draw_keybind(e_keybind.PAINTER_GRID, dx, dy)
		draw_keybind(e_keybind.PAINTER_GUIDES, dx, dy)
		dy += 8
		
		tab_collapse_end(true)
	}
	
	tab_control_switch()
	draw_button_collapse("camera", collapse_map[?"camera"], null, true, "settingscontrolscamera")
	tab_next()
	
	if (collapse_map[?"camera"])
	{
		tab_collapse_start()
		
		draw_keybind(e_keybind.CAM_WALK, dx, dy)
		draw_keybind(e_keybind.CAM_FORWARD, dx, dy)
		draw_keybind(e_keybind.CAM_BACK, dx, dy)
		draw_keybind(e_keybind.CAM_LEFT, dx, dy)
		draw_keybind(e_keybind.CAM_RIGHT, dx, dy)
		draw_keybind(e_keybind.CAM_ASCEND, dx, dy)
		draw_keybind(e_keybind.CAM_DESCEND, dx, dy)
		draw_keybind(e_keybind.CAM_RESET, dx, dy)
		draw_keybind(e_keybind.CAM_FAST, dx, dy)
		draw_keybind(e_keybind.CAM_SLOW, dx, dy)
		draw_keybind(e_keybind.TOGGLE_PROJ, dx, dy)
		draw_keybind(e_keybind.CAM_SNAP_VIEW_X, dx, dy)
		draw_keybind(e_keybind.CAM_SNAP_VIEW_Y, dx, dy)
		draw_keybind(e_keybind.CAM_SNAP_VIEW_Z, dx, dy)
		
		//draw_keybind(e_keybind.CAM_SNAP_VIEW, dx, dy)
		//draw_keybind(e_keybind.CAM_SET_SNAP_VIEW, dx, dy)
		
		draw_keybind(e_keybind.CAM_VIEW_ELEMENT, dx, dy)

		
		dy += 8
		
		tab_collapse_end(true)
	}
	
	// Look sensitivity


	tab_control_dragger()
	draw_dragger("settingsmovespeed", dx, dy, dragger_width, setting_move_speed, 0.01, 0, no_limit, 1, 0, tab.controls.tbx_move_speed, action_setting_move_speed)
	tab_next()
	
	tab_control_dragger()
	draw_dragger("settingslooksensitivity", dx, dy, dragger_width, setting_look_sensitivity, 0.01, 0, no_limit, 1, 0, tab.controls.tbx_look_sensitivity, action_setting_look_sensitivity)
	tab_next()
	
	tab_control_dragger()
	draw_dragger("settingsfastmodifier", dx, dy, dragger_width, setting_fast_modifier, 0.01, 0, no_limit, 3, 0, tab.controls.tbx_fast_modifier, action_setting_fast_modifier)
	tab_next()
	
	tab_control_dragger()
	draw_dragger("settingsslowmodifier", dx, dy, dragger_width, setting_slow_modifier, 0.01, 0, no_limit, 3, 0, tab.controls.tbx_slow_modifier, action_setting_slow_modifier)
	tab_next()
	
	
	// Restore controls
	tab_control_button_label()
	if (draw_button_label("settingsrestoredefaults", floor(dx + dw/2), dy, null, icons.RESET, e_button.PRIMARY, null, e_anchor.CENTER))
	{
		if (question(text_get("questionrestoredefaults")))
			action_controls_reset()
	}
	tab_next()
	
	tab_control_togglebutton()
	togglebutton_add("settingsviewportmousecontrolsleft", null, false, setting_viewport_controls_middle = false, action_setting_viewport_controls_middle)
	togglebutton_add("settingsviewportmousecontrolsmiddle", null, true, setting_viewport_controls_middle = true, action_setting_viewport_controls_middle)
	draw_togglebutton("settingsviewportmousecontrols", dx, dy)
	tab_next()

}
