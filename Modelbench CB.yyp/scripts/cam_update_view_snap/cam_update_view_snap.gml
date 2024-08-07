/// cam_update_view_snap()

function cam_update_view_snap()
{
	//var maxtime = 8;
	//var t = 0;

	if (!done_snapping)
	{
		if (snap_triggered_x)
			snap_triggered_x = false
		if (snap_triggered_y)
			snap_triggered_y = false
		if (snap_triggered_z)
			snap_triggered_z = false
		
		if (point3D_distance(target_Focus, focus) >= 0.05)
			focus = point3D_lerp(focus, target_Focus,1 / max(1, 3 / delta));
					
		if (abs(angle_xy != target_angle_xy) >= 0.05)
		{	
			angle_xy = angle_xy + (target_angle_xy - angle_xy) / max(1, 3 / delta)
			angle_look_xy = angle_xy
			angle_off_xy = 0
		}
	
		if (abs(angle_z != target_angle_z) >= 0.05)
		{
			angle_z = angle_z + (target_angle_z - angle_z) / max(1, 3 / delta)
			angle_look_z = -angle_z
			angle_off_z = 0
		}
	
		camera_set_from()

		done_snapping = false;
	
		if (abs(angle_z != target_angle_z) <= 0.05 && abs(angle_xy - target_angle_xy) <= 0.05 && point3D_distance(focus, target_Focus) <= 0.05)
			done_snapping = true
	}
}