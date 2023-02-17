/// camera_reset()

var cam = id;

if (object_index = app)
	cam = view_cam
	

with (cam)
{
		snapped_x = false
	snapped_y = false
	
		x_snap_positive = false;
y_snap_positive = false;

				if(!snapped_z){
	zoom = 25
	zoom_goal = zoom
	
	z_snap_positive = false
	}
	snapped_z = true



render_proj_mode = 1;

	if(!z_snap_positive){
	focus = point3D(0, 150, 25)



	focus_last = point3D(0, 0, 6)

	angle_xy = -90
	angle_z = 0
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
	z_snap_positive = true;
	}
	else{
	focus = point3D(0, -150, 25)



	focus_last = point3D(0, 0, 6)

	angle_xy = 90
	angle_z = 0
	roll = 0


	angle_look_xy = angle_xy
	angle_look_z = -angle_z

	angle_off_xy = 0
	angle_off_z = 0
		z_snap_positive = false;

	}
}

camera_set_from()