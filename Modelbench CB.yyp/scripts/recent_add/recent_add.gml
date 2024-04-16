/// recent_add()
/// @desc Adds the opened model to the top of the recent list.

function recent_add()
{
	recent_add_wait = false
	
	if (model_temporary)
		return false
	
	// Find model in list
	var obj = null;
	for (var i = 0; i < ds_list_size(recent_list); i++)
	{
		with (recent_list[|i])
		{
			if (filename != app.model_file)
				break
			
			obj = id
			ds_list_delete_value(app.recent_list, id)
		}
		
		if (obj != null)
			break
	}
	// Create thumbnail
	
#region THUMBNAIL IMAGE
	var thumbnailfn, surf;
	var mn = filename_change_ext(app.model_file, "");
	thumbnailfn = mn + "_thumbnail" + ".png"
	surf = null
	var proj_mode = render_proj_mode
	render_proj_mode = 1
	var dps = setting_preview_scenery;
	var dplrot = setting_preview_light_rotation;
	var dplrange = setting_preview_light_range;
	var bgvisable = setting_preview_background;
	var pmode = program_mode;
	var vcam = view_cam;
	program_mode = e_mode.PREVIEW
	setting_preview_background = false;
	view_cam = view_cam_preview

	action_preview_scenery(scenery_list[|0])
	setting_preview_light_rotation = 221
	setting_preview_light_range = 100
	camera_center_model()
	render_start(surf, view_cam, recent_thumbnail_width, recent_thumbnail_height)
	render_high()
	surf = render_done()
	setting_preview_background = bgvisable;
	render_proj_mode = proj_mode
	camera_restore_thumb()
	view_cam = vcam;
	program_mode = pmode
	surface_save_lib(surf, thumbnailfn)
	surface_free(surf)
	action_preview_scenery(dps)
    setting_preview_light_rotation = dplrot;
    setting_preview_light_range = dplrange;
#endregion

	// Model not added, create new object
	if (obj = null)
		obj = new_obj(obj_recent)
	
	// Store data
	with (obj)
	{
		filename = app.model_file
		name = app.model_name
		last_opened = date_current_datetime()
		pinned = false
		thumbnail = texture_create(thumbnailfn)
		ds_list_insert(app.recent_list, 0, id)
	}

	recent_update()
	recent_save()
	

}
