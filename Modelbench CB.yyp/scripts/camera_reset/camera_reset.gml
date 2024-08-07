/// camera_reset()

function camera_reset()
{
	var cam = id;
	
	if (object_index = app)
		cam = view_cam
		
	snapped_x = false;

	cam_focus_el = null

	x_snap_positive = false;



	snapped_y = false;

	render_proj_mode = 0;

	y_snap_positive = false;

	snapped_z = false;

	z_snap_positive = false;

	app.target_camera_fov = app.setting_camera_fov


	target_Focus = point3D(0,0,0);
	target_angle_xy = 0;
	target_angle_z = 0;

	done_snapping = true
	snap_triggered_x = false
	snap_triggered_y = false
	snap_triggered_z = false
	with (cam)
	{
		focus = point3D(0, 0, 16)
		focus_last = point3D(0, 0, 6)
		focus_el = null

		angle_xy = 315
		angle_z = 0
		roll = 0
		zoom = 100
		zoom_goal = zoom
		
		angle_look_xy = angle_xy
		angle_look_z = -angle_z
		
		cam_jump = false
	}
	
	camera_set_from()
}
