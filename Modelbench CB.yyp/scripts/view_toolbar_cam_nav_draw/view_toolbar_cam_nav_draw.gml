/// view_toolbar_cam_nav_draw(x, y, width, height)
/// @arg x
/// @arg y
/// @arg width
/// @arg height

function view_toolbar_cam_nav_draw(barx, bary, barw, barh)
{
	dx = barx
	dy = bary
	dw = barw
	dh = barh
	dy_start = dy
	dx_start = dx
	
	content_mouseon = app_mouse_box(dx, dy, dw, dh) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon
	
	
	if (dh > dw)
		tip_force_left = true
	
	var busy, buttonsize;
	busy = window_busy
	buttonsize = 28 + 6
	
	window_busy = ""
	
	if (app_mouse_box(dx - 80, dy - 80, dw + 160, dh + 160) && !popup_mouseon && !toast_mouseon && !context_menu_mouseon)
		toolbar_cam_nav_alpha_goal = 1
	else
		toolbar_cam_nav_alpha_goal = .65
	
	window_busy = busy
	
	if (window_busy = "viewrotatecamera")
		toolbar_cam_nav_alpha_goal = 1
	
	draw_set_alpha(toolbar_cam_nav_alpha_goal)
	
	// Background
	//draw_box(dx, dy, dw, dh, false, c_level_middle, 1)
	//draw_dropshadow(dx, dy, dw, dh, c_black, 1)
	//draw_outline(dx, dy, dw, dh, 1, c_border, a_border) 

	draw_image(spr_circle_84, 0,dx, dy, 1, 1, merge_color(c_level_top, c_black, .5), .5, 0);


	var _dx = sin(degtorad(-view_cam.angle_look_xy));
	var _dy = -sin(degtorad(view_cam.angle_look_z));
	var _dyc = cos(degtorad(-(view_cam.angle_look_z)));
	var _dz = sin(degtorad(-(view_cam.angle_look_xy + 90)));
	var _dzc = sin(degtorad(-(view_cam.angle_look_xy + 115)));
	
	//Y
	//draw_line_width_ext(dx + dw / 2, dy + dw / 2, dx + dw/2,dy + dw /2 - (((dw) - 6) * abs(_dyc))/2 + 10, c_axisgreen, 1)

	if(_dzc <= 0){
			
	if( _dy > 0){
	draw_button_circle(setting_z_is_up ? "-Z" : "-Y", dx + dw / 2, dy + dw /2 + (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.SECONDARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT, "N");
	}

	draw_button_circle("-X",dx + dw / 2 + (((dw / 2) - 6)* -_dx), dy + dw / 2 + (((dw / 2) - 6) * -_dy * -_dz), 10, null, e_button.SECONDARY, cam_snap_view_x, c_axisred, e_anchor.LEFT, "N");
	
	draw_button_circle(setting_z_is_up ? "-Y" : "-Z",dx + dw / 2 + (((dw / 2) - 6) * -_dz), dy + dw / 2 + (((dw / 2) - 6) * -_dy * _dx), 10, null, e_button.SECONDARY, cam_snap_view_z, setting_z_is_up ? c_axisgreen : c_axisblue, e_anchor.LEFT, "N");
	
	if(_dy <= 0){
	draw_button_circle(setting_z_is_up ? "Z" : "Y", dx + dw / 2, dy + dw /2 - (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.PRIMARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT);

	
	draw_button_circle(setting_z_is_up ? "-Z" : "-Y", dx + dw / 2, dy + dw /2 + (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.SECONDARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT, "N");
	}
	
	draw_button_circle(setting_z_is_up ? "Y" : "Z",dx + dw / 2 + (((dw / 2) - 6) * _dz), dy + dw / 2 + (((dw / 2) - 6) * _dy * _dx), 10, null, e_button.PRIMARY, cam_snap_view_z, setting_z_is_up ? c_axisgreen : c_axisblue, e_anchor.LEFT);
	draw_button_circle("X",dx + dw / 2 + (((dw / 2) - 6)* _dx), dy + dw / 2 + (((dw / 2) - 6) * _dy * -_dz), 10, null, e_button.PRIMARY, cam_snap_view_x, c_axisred, e_anchor.LEFT);

	if(_dy > 0){
	draw_button_circle(setting_z_is_up ? "Z" : "Y", dx + dw / 2, dy + dw /2 - (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.PRIMARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT);
	}
	}
	
	if(_dzc > 0){
	if(_dy <= 0){
	draw_button_circle(setting_z_is_up ? "Z" : "Y", dx + dw / 2, dy + dw /2 - (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.PRIMARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT);
	}
	draw_button_circle("X",dx + dw / 2 + (((dw / 2) - 6)* _dx), dy + dw / 2 + (((dw / 2) - 6) * _dy * -_dz), 10, null, e_button.PRIMARY, cam_snap_view_x, c_axisred, e_anchor.LEFT);

	if(_dy > 0){
	draw_button_circle(setting_z_is_up ? "-Z" : "-Y", dx + dw / 2, dy + dw /2 + (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.SECONDARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT, "N");
	}
	
	draw_button_circle(setting_z_is_up ? "Y" : "Z",dx + dw / 2 + (((dw / 2) - 6) * _dz), dy + dw / 2 + (((dw / 2) - 6) * _dy * _dx), 10, null, e_button.PRIMARY, cam_snap_view_z, setting_z_is_up ? c_axisgreen : c_axisblue, e_anchor.LEFT);
	

	draw_button_circle(setting_z_is_up ? "-Y" : "-Z",dx + dw / 2 + (((dw / 2) - 6) * -_dz), dy + dw / 2 + (((dw / 2) - 6) * -_dy * _dx), 10, null, e_button.SECONDARY, cam_snap_view_z, setting_z_is_up ? c_axisgreen : c_axisblue, e_anchor.LEFT, "N");
    if(_dy > 0){
	draw_button_circle(setting_z_is_up ? "Z" : "Y", dx + dw / 2, dy + dw /2 - (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.PRIMARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT);
	}
	
	draw_button_circle("-X",dx + dw / 2 + (((dw / 2) - 6)* -_dx), dy + dw / 2 + (((dw / 2) - 6) * -_dy * -_dz), 10, null, e_button.SECONDARY, cam_snap_view_x, c_axisred, e_anchor.LEFT, "N");
	if(_dy <= 0){
	draw_button_circle(setting_z_is_up ? "-Z" : "-Y", dx + dw / 2, dy + dw /2 + (((dw) - 12) * abs(_dyc))/2, 10, null, e_button.SECONDARY, cam_snap_view_y,  setting_z_is_up ? c_axisblue : c_axisgreen, e_anchor.LEFT, "N");
	}
	}

	//dy += 6
	//dx += 6
		
	//tip_set_keybind(e_keybind.CAM_SNAP_VIEW_X)
	//draw_button_label("navsnapx", dx, dy, 28, null, e_button.LABEL, cam_snap_view_x, null, false, "tooltipsnapcamx")
	
	//		if (dw > dh)
	//	dx += buttonsize
	//else
	//	dy += buttonsize
		
	//tip_set_keybind(e_keybind.CAM_SNAP_VIEW_Y)
	//draw_button_label("navsnapy", dx, dy, 28, null, e_button.LABEL, cam_snap_view_y, null, false, "tooltipsnapcamy")
	
	//		if (dw > dh)
	//	dx += buttonsize
	//else
	//	dy += buttonsize
	
	//tip_set_keybind(e_keybind.CAM_SNAP_VIEW_Z)
	//draw_button_label("navsnapz", dx, dy, 28, null, e_button.LABEL,cam_snap_view_z, null, false, "tooltipsnapcamz")

	draw_set_alpha(1)
	tip_force_left = false
}
