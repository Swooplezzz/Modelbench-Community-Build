/// camera_reset()

var cam = id;

if (object_index = app)
	cam = view_cam
	

with (cam)
{
		snapped_z = false
	snapped_x = false
	
	x_snap_positive = false;
z_snap_positive = false;

			if(!snapped_y){
	zoom = 25
	zoom_goal = zoom
	
		y_snap_positive = false

	}

	snapped_y = true

render_proj_mode = 1;

	if(!y_snap_positive){
	focus = point3D(0, 0, 100)


	focus_last = point3D(0, 0, 6)

	angle_xy = 180
	angle_z = 89.9
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
	y_snap_positive = true;
	}
	else{
	focus = point3D(0, 0, -100)


	focus_last = point3D(0, 0, 6)

	angle_xy = 180
	angle_z = -89.9
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
		y_snap_positive = false;

	}
}

camera_set_from()