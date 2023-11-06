/// app_update_work_camera()

function app_update_work_camera()
{
	with (app.view_cam)
	{
			if (cam_jump)
	{
		cam_jump = false
		return 0
	}
 
	if (app.window_busy = "" && render_proj_mode != 1)
	{
		if (el_edit != null) 
		{
			focus_el = el_edit
			
			if (focus_el.world_pos_2d_error)
				focus_el = null
			
			if (focus_el)
				focus = point3D_copy(focus_el.world_pos)
		}
		else
			focus_el = null
			focus_el = null
			focus_el = null
	}
		cam_update_view_snap()
	
		
		if (app.setting_reduced_motion)
			zoom = zoom_goal
		else
			zoom += (zoom_goal - zoom) / max(1, 4 / delta)
			

	


		if (focus_last[X] != focus[X] || 
			focus_last[Y] != focus[Y] || 
			focus_last[Z] != focus[Z])
			camera_set_angle()
		
		if(app.setting_reduced_motion)
		app.target_camera_fov = app.setting_camera_fov
		else
		app.target_camera_fov += (app.setting_camera_fov - app.target_camera_fov) / max(1, 4 / delta)
		
		focus_last = point3D_copy(focus)
			
		camera_set_from()
	}
}
