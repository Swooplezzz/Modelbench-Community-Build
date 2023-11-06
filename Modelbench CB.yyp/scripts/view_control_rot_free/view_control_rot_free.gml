/// view_control_move(view)
/// @arg view

function view_control_rot_free(view)
{
	var len, xrot, yrot, zrot;
	len = point3D_distance(cam_from, el_edit.world_pos) * view_3d_control_size * view_control_ratio * (tool_selected != e_tool.TRANSFORM ? 0.8 : 0.7)


	// Create matrix
	with (el_edit)
	{
		if (element_type = TYPE_PART)
			zrot = array_copy_1d(matrix_edit)
		else
			zrot = array_copy_1d(matrix_parent)
		
		matrix_remove_scale(zrot)
	}
	
    var axis = 0
	var start = vec3(0, 0, 0)
	
	xrot = matrix_multiply(matrix_build(0, 0, 0, 0, -90, el_edit.value[e_value.ROT_Z], 1, 1, 1), zrot)
	yrot = matrix_multiply(matrix_build(0, 0, 0, el_edit.value[e_value.ROT_X] + 90, 0, el_edit.value[e_value.ROT_Z], 1, 1, 1), zrot)
		
	
	if (view_control_matrix != null && view_control_edit != null)
	{
		xrot = view_control_matrix
		yrot = view_control_matrix
		zrot = view_control_matrix
	}
	
	
	var axisvec, center3D, start3D, end3D, center2D, start2D, end2D;
	
	var lenstart = (tool_selected = e_tool.TRANSFORM ? len - len/8 : 0)

	
    var pos3D = point3D(0, 0, 0)
	var pos2D = 0
	var mat
		
	view_control_plane_update()
	
	if(keyboard_check(ord("X")) || keyboard_check(ord("Y")) || keyboard_check(ord("Z"))){
		if(keyboard_check(ord("X"))){
			view_control_edit = e_control.ROT_X
			el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_Y, keybind_free_rot_origin[Y], false)
			el_value_set(e_value.ROT_Z, keybind_free_rot_origin[Z], false)
			el_value_set_done()
			start = vec3(lenstart, 0, 0)
			mat = xrot
			axis = X
			keybind_rot_axis = "X"
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Y") : ord("Z"))){
			view_control_edit = e_control.ROT_Y
			el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_X, keybind_free_rot_origin[X], false)
			el_value_set(e_value.ROT_Z, keybind_free_rot_origin[Z], false)
			el_value_set_done()
			start = vec3(0, lenstart, 0)
			mat = yrot
			axis = Y
			keybind_rot_axis = "Y"
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Z") : ord("Y"))){
			view_control_edit = e_control.ROT_Z
			el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_X, keybind_free_rot_origin[X], false)
			el_value_set(e_value.ROT_Y, keybind_free_rot_origin[Y], false)
			el_value_set_done()
			start = vec3(0, 0, lenstart)
			mat = zrot
			axis = Z
			keybind_rot_axis = "Z"
		}
			pos3D = point3D_mul_matrix(point3D(0, 0, 0), mat)
			pos2D = view_shape_project(pos3D)
			
			
			view_control_edit_view = view
			view_control_value = el_edit.value[view_control_edit]
			view_control_pos = pos2D
			view_control_matrix = mat
			view_control_length = len
			
	}

	
	if(keybind_free_rot && keybind_rot_axis = ""){


	

		if (!mouse_still)
		{
			
			var right = vec3_cross(cam_up, point3D_sub( cam_from, el_edit.world_pos));
			var up = vec3_cross(point3D_sub(cam_from, el_edit.world_pos), right); 
			
			//keybind one
			el_edit.quat_rot = quat_mul(angle_axis(mouse_dy - mouse_dx, point3D_sub( cam_from, el_edit.world_pos)), el_edit.quat_rot);
			
			//tool one
			//el_edit.quat_rot = quat_mul(angle_axis(-mouse_dx, up), el_edit.quat_rot);
			//el_edit.quat_rot = quat_mul(angle_axis(mouse_dy, right), el_edit.quat_rot);
			
			var mat = to_euler(el_edit.quat_rot);
			var rot = matrix_rotation(el_edit.matrix);
			var rendermat = array_copy_1d(el_edit.matrix);
			matrix_remove_scale(rendermat);
			rendermat[MAT_X] = 0
			rendermat[MAT_Y] = 0
			rendermat[MAT_Z] = 0
			
			var mat2 = matrix_multiply(rendermat, matrix_create(vec3(0), [mat,0, 5], vec3(1)));
			var rot2 = matrix_rotation(mat2);
			var dif = vec3_normalize(point3D_sub(rot2, rot));
			
			//tool one
			//el_edit.quat_rot = quat_mul(angle_axis(-mouse_dx, up), el_edit.quat_rot);
			//el_edit.quat_rot = quat_mul(angle_axis(mouse_dy, right), el_edit.quat_rot);
			
			var rot = to_euler(el_edit.quat_rot);
	//show_debug_message(el_edit.quat_rot);

		    el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_X, rot[X], false)
			el_value_set(e_value.ROT_Y, rot[Y], false)
			el_value_set(e_value.ROT_Z, rot[Z], false)
			el_value_set_done()
		}
		
	    if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_rot = false
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_rot = false
			el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_X, keybind_free_rot_origin[X], false)
			el_value_set(e_value.ROT_Y, keybind_free_rot_origin[Y], false)
			el_value_set(e_value.ROT_Z, keybind_free_rot_origin[Z], false)
			el_value_set_done()
		}
	}
	else if(keybind_free_rot && keybind_rot_axis != "")
	{
		
		if (!mouse_still)
		{
			var ang, prevang, rot, snapval, axesang, newval;
			axis_edit = view_control_edit - e_control.ROT_X
			
			// Find rotate amount
			ang = point_direction(mouse_x - content_x, mouse_y - content_y, view_control_pos[X], view_control_pos[Y])
			prevang = point_direction(mouse_previous_x - content_x, mouse_previous_y - content_y, view_control_pos[X], view_control_pos[Y])
			rot = angle_difference_fix(ang, prevang) * negate(view_control_flip)
			view_control_move_distance += rot * dragger_multiplier
			
			snapval = (dragger_snap ? setting_snap_size_rotation : snap_min)
			axesang = view_control_move_distance
			
			if (!setting_snap_absolute && dragger_snap)
				axesang = snap(axesang, snapval)
			
			newval = view_control_value + axesang
			newval = el_value_clamp(e_value.ROT_X + axis_edit, newval)
			
			if (setting_snap_absolute || !dragger_snap)
				newval = snap(newval, snapval)
			
			newval -= el_edit.value[e_value.ROT_X + axis_edit]
			
			// Update
			el_value_set_start(action_el_rot, true)
			el_value_set(e_value.ROT_X + axis_edit, newval, true)
			el_value_set_done()
		}
		
	    if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_rot = false
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_rot = false
			el_value_set_start(action_el_rot_xyz, true)
			el_value_set(e_value.ROT_X, keybind_free_rot_origin[X], false)
			el_value_set(e_value.ROT_Y, keybind_free_rot_origin[Y], false)
			el_value_set(e_value.ROT_Z, keybind_free_rot_origin[Z], false)
			el_value_set_done()
		}
	}
	

}
