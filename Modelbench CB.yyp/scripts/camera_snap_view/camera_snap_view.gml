/// camera_snap_view()

function camera_snap_view()
{
	var cam = id;

	if (object_index = app)
		cam = view_cam
	
	with (cam)
	{
		target_Focus =  point3D_copy(saved_focus)
		target_angle_xy = saved_angle_xy
		target_angle_z = saved_angle_z
		zoom = zoom_goal
		zoom_goal = saved_zoom;
		done_snapping = false
	}
}