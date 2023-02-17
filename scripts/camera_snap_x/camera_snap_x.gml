/// camera_reset()

var cam = id;

if (object_index = app)
	cam = view_cam




with (cam)
{
		snapped_z = false
	snapped_y = false

y_snap_positive = false;
z_snap_positive = false;

		if(!snapped_x){
	zoom = 25
	zoom_goal = zoom
	
		x_snap_positive = false

	}
		snapped_x = true

	render_proj_mode = 1;

	if(!x_snap_positive){
	focus = point3D(150, 0, 25)
	focus_last = point3D(0, 0, 6)

	angle_xy = 0
	angle_z = 0
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
	x_snap_positive = true;
	}
	else{
			focus = point3D(-150, 0, 25)
	focus_last = point3D(0, 0, 6)

	angle_xy = 180
	angle_z = 0
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
		x_snap_positive = false;

	}
}

camera_set_from()