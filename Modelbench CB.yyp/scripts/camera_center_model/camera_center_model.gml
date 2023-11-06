/// camera_reset()

function camera_center_model()
{
	var cam = id;
	
	if (object_index = app)
		cam = view_cam
		

	with (cam)
	{
				original_focus = focus;
		focus = point3D(0,0, (( model_get_max_y() + model_get_min_y() ) / 2) ) 
		focus_last = point3D(0, 0, 6)
		
		
		angle_xy = 315
		angle_z = 0
		roll = 0
		zoom = 100
		zoom_goal = zoom
		
		angle_look_xy = angle_xy
		angle_look_z = -angle_z
	}
	
	camera_set_from()
}