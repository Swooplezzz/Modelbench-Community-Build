// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cam_snap_view_y(){
/// camera_reset()
var dir;
dir = ""
if(argument_count > 0)
dir = argument[0]

var cam = id;

if (object_index = app)
	cam = view_cam
	

with (cam)
{
if(snap_triggered_y = true){ exit }
	snap_triggered_y = true

		snapped_z = false
	snapped_x = false
	
	x_snap_positive = false;
z_snap_positive = false;



			if(!snapped_y){
	
		//zoom_goal = 100
		y_snap_positive = false

	}

	snapped_y = true

render_proj_mode = 1;

	if(!y_snap_positive && dir != "N"){
		
				done_snapping = false;
	target_Focus =  point3D(0, 0 , 25)


	target_angle_xy = angle_xy + (270-angle_xy+540)mod 360-180
	if(target_angle_xy < angle_xy && angle_xy - target_angle_xy >180)
	target_angle_xy += 360
	
	target_angle_z =  89.9
	
			y_snap_positive = true;

	}
	else{
				done_snapping = false;
	target_Focus =  point3D(0, 0 , 25)


	target_angle_xy = angle_xy + (270-angle_xy+540)mod 360-180
	if(target_angle_xy < angle_xy && angle_xy - target_angle_xy >180)
	target_angle_xy += 360
	
	target_angle_z =  -89.9
	roll = 0
		y_snap_positive = false;
	}
}

camera_set_from()
}