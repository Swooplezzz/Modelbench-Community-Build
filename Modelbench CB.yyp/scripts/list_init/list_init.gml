/// list_init(name)
/// @arg name
/// @desc Makes a list and returns it based on name

function list_init(name)
{
	var list;
	list = list_new()
	list_edit = list
	
	switch (name)
	{
		case "startupnewmodeloptions":
		{
			list_item_add(text_get("startupstartfromscratch"), e_part.FRONT, "", null, icons.FILE, null, model_create)
			list_item_add(text_get("startuploadatemplate"), false, "", null, icons.FILE_TEMPLATE, null, model_create_template)
			break
		}
		
		case "elementeditorbendpart":
		{
			list_item_add(text_get("elementeditorbendpartright"), e_part.RIGHT, "")
			list_item_add(text_get("elementeditorbendpartleft"), e_part.LEFT, "")
			list_item_add(text_get("elementeditorbendpartfront"), e_part.FRONT, "")
			list_item_add(text_get("elementeditorbendpartback"), e_part.BACK, "")
			list_item_add(text_get("elementeditorbendpartupper"), e_part.UPPER, "")
			list_item_add(text_get("elementeditorbendpartlower"), e_part.LOWER, "")
			
			break
		}
		
		case "elementeditortexture":
		{
			// Inherit texture
			list_item_add(text_get("elementeditorinherittexture"), null, "")
			
			// Add all loaded textures in model
			with (obj_texture)
				list_item_add(id.filename, id, "", sprite, null, null, null)
			
			break
		}
		case "elementeditoriktarget":
		{
			// Inherit texture
			list_item_add(text_get("elementeditornopart"), null, "")
			
			// Add all loaded textures in model
			with (obj_model_element)
			if(element_type = TYPE_PART && id != el_edit)
				list_item_add(id.name, id, "", null, null, null, null)
			
			break
		}
		case "elementeditorikangle":
		{
			// Inherit texture
			list_item_add(text_get("elementeditornopart"), null, "")
			
			// Add all loaded textures in model
			with (obj_model_element)
			if(element_type = TYPE_PART && id != el_edit)
				list_item_add(id.name, id, "", null, null, null, null)
			
			break
		}
		case "elementeditorwindaxis":
		{
			list_item_add(text_get("elementeditorwindaxisnone"), e_vertex_wave.NONE, "")
			list_item_add(text_get("elementeditorwindaxisall"), e_vertex_wave.ALL, "")
			list_item_add(text_get("elementeditorwindaxis" + (setting_z_is_up ? "z" : "y")), e_vertex_wave.Z_ONLY, "")
			
			break
		}
		
		case "exportmode":
		{
			list_item_add(text_get("exportmodecombineall"), e_export.COMBINE_ALL, "")
			list_item_add(text_get("exportmodeseparateparts"), e_export.SEPERATE_PARTS, "")
			list_item_add(text_get("exportmodeseparateshapes"), e_export.SEPERATE_SHAPES, "")
			
			break
		}
		
		case "settingslanguage":
		{
			var file, filename, locale, err;
			file = file_find_first(languages_directory + "*.mblanguage", 0)
			mouse_cursor = cr_hourglass
			
			// Read each file's language key
			while (file != "")
			{
				// Convert unicode (external)
				var convfn = file_directory + "conv.tmp";
				json_file_convert_unicode(languages_directory + file, convfn)
				
				if (!file_exists_lib(convfn))
				{
					file = file_find_next()
					continue
				}
				
				var json = json_load(convfn);
				filename = filename_name(file)
				locale = ""
				err = false
				
				if (ds_map_valid(json))
				{
					if (!is_undefined(json[?"file/"]))
					{
						var filemap = json[? "file/"];
						filename = value_get_string(filemap[?"language"], filename)
						locale = value_get_string(filemap[?"locale"], "")
					}
					
					ds_map_destroy(json)
				}
				else
					err = true
				
				list_item_add(filename, filename_name(file), locale, null, null, err ? icons.WARNING_DIAMOND : null, null)
				file = file_find_next()
			}
			file_find_close()
			
			break
		}
		
		case "settingsfeatureset":
		{
			list_item_add(text_get("settingsfeaturesetmimodel"), e_features.MIMODEL, ".mimodel")
			list_item_add(text_get("settingsfeaturesetobj"), e_features.OBJ, ".obj")
			break
		}
		
		// Context menu
		case "contextmenuvalue":
		case "contextmenucategory":
		{	
			// Combine scale
			if (context_menu_group != null && context_menu_group = e_context_group.SCALE)
			{
				var text = (element_editor.transform.scale_all ? "contextmenuscaleseparate" : "contextmenuscalecombine");
				list_item_add(text_get(text), null, "", null, icons.SCALE, null, action_group_combine_scale, true)
			}
			
			// Offset centering
			if (context_menu_group != null && context_menu_group = e_context_group.PIVOT_OFFSET)
				list_item_add(text_get("contextmenucenteraxis"), null, "", null, icons.PIVOT, null, action_el_offset_center, true)
			
			// Single value copy-paste
			if (name = "contextmenuvalue")
			{
				list_item_add(text_get("contextmenuvaluecut"), null, "", null, icons.CUT, null, action_value_cut, true)
				list_item_add(text_get("contextmenuvaluecopy"), null, "", null, icons.COPY, null, action_value_copy, false)
				
				var caption = "";
				
				if (context_menu_copy_type = e_context_type.NUMBER)
					caption = string(context_menu_copy)
				else if (context_menu_copy_type = e_context_type.COLOR)
					caption = color_to_hex(context_menu_copy)
				else if (context_menu_copy_type = e_context_type.STRING)
					caption = context_menu_copy
				
				list_item_add(text_get("contextmenuvaluepaste"), null, caption, null, icons.PASTE, null, action_value_paste, false)
				list_item_last.disabled = (context_menu_value_type = e_context_type.NONE || (context_menu_copy_type != context_menu_value_type))
				
				list_item_add(text_get("contextmenuvaluereset"), null, "", null, icons.RESET, null, action_value_reset, false)
			}
			
			if (context_menu_group != null)
			{
				list_item_add(text_get("contextmenugroupcopy"), null, "", null, icons.COPY_ALL, null, action_group_copy, true)
				list_item_add(text_get("contextmenugrouppaste"), null, "", null, icons.PASTE_ALL, null, action_group_paste, false)
				list_item_last.disabled = (context_group_copy_list[|context_menu_group] = null)
				
				list_item_add(text_get("contextmenugroupreset"), null, "", null, icons.RESET_ALL, null, action_group_reset, false)
			}
			
			break
		}
		
		case "contextmenutextbox":
		{
			var ctrl = text_get("keycontrol") + " + ";
			list_item_add(text_get("contextmenutextboxcut"), null, ctrl + "X", null, icons.CUT, null, action_textbox_cut, true)
			list_item_last.disabled = (textbox_select_startpos = textbox_select_endpos)
			
			list_item_add(text_get("contextmenutextboxcopy"), null, ctrl + "C", null, icons.COPY, null, action_textbox_copy, false)
			list_item_last.disabled = (textbox_select_startpos = textbox_select_endpos)
			
			list_item_add(text_get("contextmenutextboxpaste"), null, ctrl + "V", null, icons.PASTE, null, action_textbox_paste, false)
			list_item_last.disabled = (clipboard_get_text() = "" || !clipboard_has_text())
			
			list_item_add(text_get("contextmenutextboxselectall"), null, ctrl + "A", null, icons.SELECT_ALL, null, action_textbox_select_all, false)
			break
		}
		
		case "contextmenutexture":
		{
			list_item_add(text_get("contextmenutexturesetmain"), context_menu_value, "", null, icons.STAR, null, action_texture_set_main, true)
			list_item_last.disabled = (context_menu_value = app.res)
			
			list_item_add(text_get("contextmenutextureremove"), context_menu_value, "", null, icons.DELETE, null, action_texture_remove, false)
			list_item_last.disabled = (context_menu_value = app.res)
			
			list_item_add(text_get("contextmenutexturereplace"), context_menu_value, "", null, icons.REPLACE, null, action_texture_replace, false)
			
			list_item_add(text_get("contextmenutexturerefresh"), context_menu_value, "", null, icons.REFRESH, null, action_texture_refresh, false)
			list_item_last.disabled = (context_menu_value.filepath = "")
			
			list_item_add(text_get("contextmenutexturesaveuvmap"), context_menu_value, "", null, icons.TEXTURE, null, action_texture_save_uv_map, false)
			break
		}
		
		case "keybind":
		{
			list_item_add(text_get("contextmenurestorekeybind"), context_menu_value, "", null, icons.RESET, null, keybind_restore, true)
			break
		}
		
		case "contextmenuelement":
		{
			list_item_add(text_get("contextmenuelementadd"), null, "", null, icons.PLUS, icons.CHEVRON_RIGHT, null, true)
			list_item_last.context_menu_name = "contextmenuaddelement"
			list_item_last.disabled = (context_menu_value.element_type = TYPE_SHAPE) || (program_mode = e_mode.PREVIEW)
			
			list_item_add(text_get("contextmenuelementrename"), null, text_control_name(keybinds[e_keybind.RENAME].keybind), null, icons.RENAME, null, action_el_rename_start, false)
			list_item_last.disabled = (el_edit = null) || (program_mode = e_mode.PREVIEW)
			
			list_item_add(text_get("contextmenuelementduplicate"), null, text_control_name(keybinds[e_keybind.ELEMENT_DUPLICATE].keybind), null, icons.DUPLICATE, null, action_el_duplicate, false)
			list_item_last.disabled = (el_edit = null) || (program_mode = e_mode.PREVIEW)
			
			list_item_add(text_get("contextmenuelementdelete"), null, text_control_name(keybinds[e_keybind.ELEMENT_DELETE].keybind), null, icons.DELETE, null, action_el_remove, false)
			list_item_last.disabled = (el_edit = null) || (program_mode = e_mode.PREVIEW)
			
			list_item_add(text_get("contextmenuviewportselectall"), null, text_control_name(keybinds[e_keybind.SELECT_ALL].keybind), null, icons.SELECT_ALL, null, action_el_select_all, true)
			list_item_last.disabled = (program_mode = e_mode.PREVIEW) 
			list_item_add(text_get("contextmenuelementexpandall"), null, "", null, icons.MINIMIZE, null, action_expand_all, false)
			list_item_add(text_get("contextmenuelementcollapseall"), null, "", null, icons.MAXIMIZE, null, action_collapse_all, false)
			break
		}
		
		case "contextmenuaddelement":
		{
			list_item_add(text_get("contextmenuaddelementpart"), e_element.PART, "", null, icons.PART_ADD, null, action_element_create_menu, true)
			list_item_add(text_get("contextmenuaddelementblock"), e_element.BLOCK, "", null, icons.CUBE_ADD, null, action_element_create_menu, false)
			list_item_add(text_get("contextmenuaddelementplane"), e_element.PLANE, "", null, icons.PLANE_ADD, null, action_element_create_menu, false)
			list_item_add(text_get("contextmenuaddelement3dplane"), e_element.PLANE_3D, "", null, icons.PLANE_3D_ADD, null, action_element_create_menu, false)
			break
		}
		

		
		
		case "contextmenuurl":
		{
			list_item_add(text_get("contextmenucopylink"), context_menu_value, "", null, icons.LINK, null, action_copy_text, true)
			break
		}

		case "contextmenuviewport":
		{
			if (context_menu_value = view_cam_viewport)
			{
				list_item_add(text_get("contextmenuelementadd"), null, "", null, icons.PLUS, icons.CHEVRON_RIGHT_TINY, null, true)
				list_item_last.context_menu_name = "contextmenuviewportaddelement"
				
				list_item_add(text_get("contextmenuelementrename"), null, text_control_name(keybinds[e_keybind.RENAME].keybind), null, icons.RENAME, null, action_el_rename_start, false)
				list_item_last.disabled = (el_edit = null)
				
				list_item_add(text_get("contextmenuelementduplicate"), null, text_control_name(keybinds[e_keybind.ELEMENT_DUPLICATE].keybind), null, icons.DUPLICATE, null, action_el_duplicate, false)
				list_item_last.disabled = (el_edit = null)
				
				list_item_add(text_get("contextmenuelementdelete"), null, text_control_name(keybinds[e_keybind.ELEMENT_DELETE].keybind), null, icons.DELETE, null, action_el_remove, false)
				list_item_last.disabled = (el_edit = null)
				
				list_item_add(text_get("contextmenuviewportselectall"), null, text_control_name(keybinds[e_keybind.SELECT_ALL].keybind), null, icons.SELECT_ALL, null, action_el_select_all, true)
								
				list_item_last.disabled = (el_edit = null)
				
				list_item_add(text_get("contextmenumirrormodel"), null, "", null, icons.MIRROR_HORIZONTAL, icons.CHEVRON_RIGHT_TINY, null, !setting_show_uv_editor)
				list_item_last.context_menu_name = "contextmenuviewportmirrorelement"
			}
			
			if (setting_show_uv_editor)
			{
				list_item_add(text_get("contextmenumove"), null, "", null, icons.ELLIPSIS_VERTICAL, icons.CHEVRON_RIGHT_TINY, null, true)
				list_item_last.context_menu_name = "contextmenuviewportmove"
			}
			
			list_item_add(text_get("contextmenuresetview"), null, "", null, icons.RESET, null, camera_reset_context_menu, !setting_show_uv_editor)
		
			break
		}
		
		case "contextmenuviewportmove":
		{
			list_item_add(text_get("contextmenuleft"), "right", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "right")
			
			list_item_add(text_get("contextmenuright"), "left", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "left")
			
			list_item_add(text_get("contextmenubottom"), "top", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "top")
			
			list_item_add(text_get("contextmenutop"), "bottom", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "bottom")
			
			break
		}
		
		case "contextmenuviewportaddelement":
		{
			list_item_add(text_get("contextmenuaddelementpart"), e_element.PART, "", null, icons.PART_ADD, null, action_element_create, true)
			list_item_add(text_get("contextmenuaddelementblock"), e_element.BLOCK, "", null, icons.CUBE_ADD, null, action_element_create, false)
			list_item_add(text_get("contextmenuaddelementplane"), e_element.PLANE, "", null, icons.PLANE_ADD, null, action_element_create, false)
			list_item_add(text_get("contextmenuaddelement3dplane"), e_element.PLANE_3D, "", null, icons.PLANE_3D_ADD, null, action_element_create, false)
			break
		}
		
		case "contextmenuviewportmirrorelement":
		{
			list_item_add(text_get("contextmenumirrorx"), "X", "", null, icons.MIRROR_VERTICAL, null, action_el_mirror_x, true)
			list_item_add(text_get("contextmenumirrorz"), "Z", "", null, icons.MIRROR_HORIZONTAL, null, action_el_mirror_z, false)
			list_item_add(text_get("contextmenumirrorxtexture"), "X Texture", "", null, icons.MIRROR_VERTICAL, null, action_el_mirror_x_textures, true)
			list_item_add(text_get("contextmenumirrorztexture"), "Z Texture", "", null, icons.MIRROR_HORIZONTAL, null, action_el_mirror_z_textures, false)
			break
		}
		
		case "toolsetsnapmode":
		{
			list_item_add(text_get("toolsetsnapmodeabsolute"), e_snap_mode.ABSOLUTE, "", null, null, null, null, true)
			list_item_add(text_get("toolsetsnapmodelocal"), e_snap_mode.LOCAL, "", null, null, null, null, false)
			break
		}
		
		case "contextmenuuveditor":
		{
			list_item_add(text_get("contextmenumove"), null, "", null, icons.ELLIPSIS_VERTICAL, icons.CHEVRON_RIGHT_TINY, null)
			list_item_last.context_menu_name = "contextmenuuveditormove"
			
			list_item_add(text_get("contextmenuresetview"), null, "", null, icons.RESET, null, uv_editor_reset_view)
			break
		}
		
		case "contextmenuuveditormove":
		{
			list_item_add(text_get("contextmenuleft"), "left", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "left")
			
			list_item_add(text_get("contextmenuright"), "right", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "right")
			
			list_item_add(text_get("contextmenubottom"), "bottom", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "bottom")
			
			list_item_add(text_get("contextmenutop"), "top", "", null, null, null, uv_editor_move)
			list_item_last.toggled = (setting_uv_editor_location = "top")
			
			break
		}
		
		// File menu
		case "toolbarfile":
		{
			list_item_add(text_get("toolbarfilenew"), undefined, text_control_name(keybinds[e_keybind.MODEL_NEW].keybind), null, icons.FILE, null, model_create)
			list_item_add(text_get("toolbarfileopen"), undefined, text_control_name(keybinds[e_keybind.MODEL_OPEN].keybind), null, icons.FOLDER, null, model_load)
			list_item_add(text_get("toolbarfilerecent"), undefined, "", null, icons.FOLDER_RECENTS, icons.CHEVRON_RIGHT_TINY, null)
			list_item_last.context_menu_name = "toolbarfilerecent"
			list_item_last.disabled = (ds_list_size(recent_list) = 0)
			
			list_item_add(text_get("toolbarfilesave"), undefined, text_control_name(keybinds[e_keybind.MODEL_SAVE].keybind), null, icons.SAVE, null, model_save, true)
			list_item_add(text_get("toolbarfilesaveas"), undefined, text_control_name(keybinds[e_keybind.MODEL_SAVE_AS].keybind), null, icons.SAVE_AS, null, model_save_as)
			
			list_item_add(text_get("toolbarfileimport"), undefined, text_control_name(keybinds[e_keybind.MODEL_IMPORT].keybind), null, icons.ASSET_IMPORT, null, action_model_import, true)
			
			list_item_add(text_get("toolbarfileexportobj"), export, "", null, icons.FILE_OBJ, null, export.show ? tab_close : tab_show, true)
			
			break
		}
		case "toolbaradjust":
		{
			list_item_add(text_get("toolbaradjusthuesat"), undefined,"", null, icons.CIRCLE, null, action_painter_adjust_huesat)
			list_item_add(text_get("toolbaradjustbrightcontrast"), undefined, "", null, icons.SUN, null, action_painter_adjust_brightness_contrast)
			break;
		}
		case "toolbarfilerecent":
		{
			var recent;
			
			for (var i = 0; i < min(ds_list_size(recent_list), 10); i++)
			{
				recent = recent_list[|i]
				list_item_add(filename_name(recent.filename), recent.filename, "", null, null, null, model_load)
			}
			
			break
		}
		
		// Edit menu
		case "toolbaredit":
		{
			list_item_add(text_get("toolbareditundo"), null, text_control_name(keybinds[e_keybind.UNDO].keybind), null, icons.UNDO, null, action_toolbar_undo)
			list_item_last.disabled = (history_pos = history_amount)
			
			list_item_add(text_get("toolbareditredo"), null, text_control_name(keybinds[e_keybind.REDO].keybind), null, icons.REDO, null, action_toolbar_redo)
			list_item_last.disabled = (history_pos = 0)
			
			list_item_add(text_get("toolbareditselectall"), null, text_control_name(keybinds[e_keybind.SELECT_ALL].keybind), null, icons.SELECT_ALL, null, action_el_select_all, true)
			list_item_last.disabled = (ds_list_size(part_list) = 0)
			
			list_item_add(text_get("toolbareditduplicate"), null, text_control_name(keybinds[e_keybind.ELEMENT_DUPLICATE].keybind), null, icons.DUPLICATE, null, action_el_duplicate, true)
			list_item_last.disabled = (el_edit = null)
			
			list_item_add(text_get("toolbareditdelete"), null, text_control_name(keybinds[e_keybind.ELEMENT_DELETE].keybind), null, icons.DELETE, null, action_el_remove)
			list_item_last.disabled = (el_edit = null)
			
			list_item_add(text_get("toolbareditpreferences"), settings, "", null, icons.SETTINGS, null, settings.show ? tab_close : tab_show, true)
			list_item_last.toggled = settings.show
			
			break
		}
		
		// View menu
		case "toolbarview":
		{
			list_item_add(text_get("toolbarviewreset"), null, "", null, icons.CAMERA, null, camera_reset)
			
			list_item_add(text_get("toolbarviewshortcutsbar"), null, "", null, icons.KEYBOARD, null, action_setting_shortcuts_bar, true)
			list_item_last.toggled = setting_show_shortcuts_bar
			
			list_item_add(text_get("toolbarviewuveditor"), !setting_show_uv_editor, text_control_name(keybinds[e_keybind.UV_EDITOR].keybind), null, icons.TEXTURE, null, action_toolbar_show_uv_editor, true)
			list_item_last.toggled = setting_show_uv_editor
			
			list_item_add(text_get("toolbarviewhome"), null, "", null, icons.HOME, null, action_setting_home_screen, true)
			break
		}
		
		// Help menu
		case "toolbarhelp":
		{
			list_item_add(text_get("toolbarhelpabout"), popup_about, "", null, icons.INFO, null, popup_show)
			
			list_item_add(text_get("toolbarhelpreport"), link_forums_bugs, "", null, icons.BUG, null, popup_open_url, true)
			list_item_add(text_get("toolbarhelpforums"), link_forums, "", null, icons.COMMENTS, null, popup_open_url)
			
			break
		}
		
		// Model sort
		case "startupsortby":
		{
			list_item_add(text_get("recentsortdatenewest"), e_recent_sort.date_newest, "", null, null, null, action_recent_sort)
			list_item_add(text_get("recentsortdateoldest"), e_recent_sort.date_oldest, "", null, null, null, action_recent_sort)
			list_item_add(text_get("recentsortnameaz"), e_recent_sort.name_az, "", null, null, null, action_recent_sort)
			list_item_add(text_get("recentsortnameza"), e_recent_sort.name_za, "", null, null, null, action_recent_sort)
			
			break
		}
	}
	
	list_update_width(list)
	
	if (ds_list_size(list.item) > 0 && list.item[|0].divider)
		list.item[|0].divider = false
	
	list_edit = null
	
	return list
}
