/// camera_set_snap_view()

function camera_set_snap_view()
{
	var cam = id;
	if (object_index = app)
		cam = view_cam

	with (cam)
	{
		saved_focus =  point3D_copy(focus)
		saved_angle_xy = angle_xy
		saved_angle_z = angle_z
		saved_zoom = zoom
	}
}