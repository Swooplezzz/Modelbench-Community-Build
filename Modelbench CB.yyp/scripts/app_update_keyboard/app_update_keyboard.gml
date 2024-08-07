/// app_update_keyboard()
/// @desc Handle keyboard shortcuts.

function app_update_keyboard()
{
	// Refresh scenery
	if (keyboard_check_pressed(vk_f7))
	{
		preview_scenery_load()
		
		if (ds_list_size(scenery_list) > 0)
		{
			setting_preview_scenery = scenery_list[|0]
			action_preview_scenery(setting_preview_scenery)
		}
	}
	
	if (keyboard_check_pressed(vk_f8))
	{
		with (obj_model_element)
		{
			if (element_type = TYPE_SHAPE)
				shape_update_vbuffer()
		}
	}
	
	if (keyboard_check_pressed(vk_f9))
		open_url(file_directory)
	
	if (keyboard_check_pressed(vk_f10))
		open_url(working_directory)
	
	if (keyboard_check_pressed(vk_f11))
		open_url(log_file)
	
	if (keyboard_check_pressed(vk_f12))
	{
		if (keyboard_check(vk_shift))
			debug_info_corner = (debug_info_corner + 1) mod 4
		else
			debug_info = (debug_info + 1) mod 3
	}
	
	if (window_state = "startup")
	{
		if (keybinds[e_keybind.UNDO].pressed)
			action_toolbar_undo()
		
		if (keybinds[e_keybind.REDO].pressed)
			action_toolbar_redo()		
	}

	if (window_state = "" && window_busy = "" && !textbox_isediting)
	{
		if (keybinds[e_keybind.MODEL_NEW].pressed)
			model_create()
		
		if (keybinds[e_keybind.MODEL_NEW_TEMPLATE].pressed)
			model_create_template()
		
		if (keybinds[e_keybind.MODEL_OPEN].pressed)
			model_load()
		
		if (keybinds[e_keybind.MODEL_SAVE].pressed)
			model_save()
		
		if (keybinds[e_keybind.MODEL_SAVE_AS].pressed)
			model_save_as()
		
		if (keybinds[e_keybind.MODEL_IMPORT].pressed)
			action_model_import()
			
		if (program_mode != e_mode.TEXTURING)
		{
			if (keybinds[e_keybind.UNDO].pressed)
				action_toolbar_undo()
		
			if (keybinds[e_keybind.REDO].pressed)
				action_toolbar_redo()
		if (keybinds[e_keybind.CAM_WALK].pressed)
		{
			window_focus = string(content_view)
			window_busy = "viewmovecameratoggle"
			view_click_x = display_mouse_get_x()
			view_click_y = display_mouse_get_y()
		}
		
		}
		

		if (program_mode = e_mode.MODELING)
		{
			if (keybinds[e_keybind.RENAME].pressed)
				action_el_rename_start()
			
			if (keybinds[e_keybind.ELEMENT_DELETE].pressed)
				action_el_remove()
			
			if (keybinds[e_keybind.ELEMENT_DUPLICATE].pressed)
				action_el_duplicate()
			
			if (keybinds[e_keybind.SELECT_ALL].pressed)
			{
				if (el_edit)
					action_el_deselect_all()
				else
					action_el_select_all()
			}
			
			if (keybinds[e_keybind.UV_EDITOR].pressed)
				action_toolbar_show_uv_editor(!setting_show_uv_editor)
			
			// Switch tools
			if (keybinds[e_keybind.TOOL_SELECT].pressed)
				tool_selected = e_tool.SELECT
			
			if (keybinds[e_keybind.TOOL_PIVOT].pressed)
				tool_selected = e_tool.PIVOT
			
			if (keybinds[e_keybind.TOOL_MOVE].pressed)
				tool_selected = e_tool.MOVE
			
			if (keybinds[e_keybind.TOOL_ROTATE].pressed)
				tool_selected = e_tool.ROTATE
			
			if (keybinds[e_keybind.TOOL_SCALE].pressed)
				tool_selected = e_tool.SCALE
			
			if (keybinds[e_keybind.TOOL_TRANSFORM].pressed)
				tool_selected = e_tool.TRANSFORM
			
			if (keybinds[e_keybind.TOOL_BEND].pressed)
				tool_selected = e_tool.BEND
			
			if (keybinds[e_keybind.TOOL_RESIZE].pressed)
				tool_selected = e_tool.RESIZE
				
			if (keybinds[e_keybind.ELEMENT_MIRROR_Z].pressed)
				action_el_mirror_z()
				
			if (keybinds[e_keybind.ELEMENT_MIRROR_X].pressed)
				action_el_mirror_x()
			
			// Toggle snapping
			if (keybinds[e_keybind.SNAP].pressed)
				action_setting_snap(!setting_snap)
			
			// Camera snapping
			if (keybinds[e_keybind.TOGGLE_PROJ].pressed)
				toggle_projection()
		
			if (keybinds[e_keybind.CAM_SNAP_VIEW_X].pressed)
				cam_snap_view_x()
	
			if (keybinds[e_keybind.CAM_SNAP_VIEW_Y].pressed)
				cam_snap_view_y()
	
			if (keybinds[e_keybind.CAM_SNAP_VIEW_Z].pressed)
				cam_snap_view_z()
		}
		
		if (program_mode = e_mode.TEXTURING)
		{
			if (keybinds[e_keybind.BRUSH].pressed)
				paint_tool_selected = e_paint.BRUSH
		
			if (keybinds[e_keybind.ERASE].pressed)
				paint_tool_selected = e_paint.ERASE
		
			if (keybinds[e_keybind.PICK].pressed)
				paint_tool_selected = e_paint.PICK
		
			if (keybinds[e_keybind.FILL].pressed)
				paint_tool_selected = e_paint.FILL
			
			if (keybinds[e_keybind.SHAPE].pressed)
				paint_tool_selected = e_paint.SHAPE
		
			if (keybinds[e_keybind.BOX_SELECT].pressed)
				paint_tool_selected = e_paint.BOX_SELECT

			if (keybinds[e_keybind.TRANSFORM_SELECTION].pressed)
				paint_tool_selected = e_paint.TRANSFORM_SELECTION
		
			if (keybinds[e_keybind.PAINTER_GRID].pressed)
				paint_view_grid = !paint_view_grid
		
			if (keybinds[e_keybind.PAINTER_GUIDES].pressed)
				paint_view_brush_guides = !paint_view_brush_guides
		}
	}
	else if (textbox_isediting && keyboard_check_pressed(vk_tab) && textbox_lastfocus.next_tbx)
		window_focus = string(textbox_lastfocus.next_tbx)
	
	if (textbox_isediting && !textbox_isediting_respond)
	{
		textbox_isediting = false
		if (window_busy = "")
			window_focus = ""
	}
	
	textbox_isediting_respond = false
	
	// Dragger changes
	if (!textbox_isediting)
	{
		dragger_multiplier = keyboard_check(vk_shift) ? .1 : 1
		dragger_snap = setting_snap || keyboard_check(vk_control)
	}
	else
	{
		dragger_multiplier = 1
		dragger_snap = false
	}
}
