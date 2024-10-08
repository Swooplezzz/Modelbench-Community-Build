/// tab_settings_general()

function tab_settings_general()
{
	// FPS
	tab_control_togglebutton()
	togglebutton_add("settingsfps30", null, 30, room_speed = 30, action_setting_fps)
	togglebutton_add("settingsfps60", null, 60, room_speed = 60, action_setting_fps)
	//togglebutton_add("settingsfpsmax", null, 570, room_speed = 570, action_setting_fps)
	draw_togglebutton("settingsfps", dx, dy)
	tab_next()
	
	// Feature set
	var text = (setting_feature_set = e_features.MIMODEL ? "settingsfeaturesetmimodel" : "settingsfeaturesetobj");
	var caption = (setting_feature_set = e_features.MIMODEL ? ".mimodel" : ".obj");
	
	tab_control_menu()
	draw_button_menu("settingsfeatureset", e_menu.LIST, dx, dy, dw, 24, setting_feature_set, text_get(text), action_setting_feature_set, false, null, null, caption)
	tab_next()
	
	// Backup models
	tab_control_switch()
	draw_button_collapse("backup", collapse_map[?"backup"], action_setting_backup, setting_backup, "settingsbackupmodels")
	tab_next()
	

	
	if (setting_backup && collapse_map[?"backup"])
	{
		tab_collapse_start()
		
		tab_control_meter()
		draw_meter("settingsbackupmodelsminutes", dx, dy, dw, setting_backup_time, 48, 1, 10, 2, 1, tab.general.tbx_backup_time, action_setting_backup_time)
		tab_next()
		
		tab_control_meter()
		draw_meter("settingsbackupmodelsamount", dx, dy, dw, setting_backup_amount, 48, 1, 10, 3, 1, tab.general.tbx_backup_amount, action_setting_backup_amount)
		tab_next()
		
		tab_collapse_end(true)
	}
	
	// Slow shape generation
	tab_control_switch()
	draw_switch("settingsslowgeneration", dx, dy, setting_slow_generation, action_setting_slow_generation, "settingsslowgenerationhelp")
	tab_next()
	
	// Refresh textures on focus
	tab_control_switch()
	draw_switch("settingsrefreshtextures", dx, dy, setting_refresh_textures, action_setting_refresh_textures, "settingsrefreshtextureshelp")
	tab_next()
	
	// Adjust pivot on resizing
	tab_control_switch()
	draw_switch("settingsadjustpivotresize", dx, dy, setting_adjust_pivot_resize, action_setting_adjust_pivot_resize, "settingsadjustpivotresizehelp")
	tab_next()
	
	tab_control_meter()
	draw_meter("settingsadjustfov", dx, dy, dw, setting_camera_fov, 48, 1, 170, 35, 1, tab.general.tbx_fov, action_setting_adjust_camera_fov)
	tab_next()
	
}
