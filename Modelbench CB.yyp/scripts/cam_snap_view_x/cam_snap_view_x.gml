// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cam_snap_view_x(){
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
	var z_positive = z_snap_positive	
if(snap_triggered_x = true){ exit }
	snap_triggered_x = true

	show_debug_message("X")

	
		snapped_z = false
	snapped_y = false

y_snap_positive = false;
z_snap_positive = false;



		if(!snapped_x){
		//zoom_goal = 100
		x_snap_positive = false

	}
		snapped_x = true

	render_proj_mode = 1;

	if(!x_snap_positive && dir != "N"){
					done_snapping = false;

	
	target_Focus =  point3D(0, 0 , 25)
	
	var notClockwise = z_positive
	
	target_angle_xy = angle_xy + (0 - angle_xy+540)mod 360 - 180
	if(target_angle_xy < angle_xy && angle_xy - target_angle_xy >180)
	target_angle_xy += 360

			x_snap_positive = true;
	target_angle_z = 0;
	}
	else{
				done_snapping = false;
	target_Focus =  point3D(0, 0 , 25)
	
		var notClockwise = !z_positive

	target_angle_xy = angle_xy +(180-angle_xy+540)mod 360 - 180
	if(target_angle_xy < angle_xy && angle_xy - target_angle_xy >180)
	target_angle_xy += 360

	target_angle_z = 0;
	roll = 0
		x_snap_positive = false;
	}
}

camera_set_from()

}

