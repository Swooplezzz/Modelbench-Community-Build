/// view_control_move(view)
/// @arg view

function view_control_scale_free(view)
{
		var axisvec, start3D, end3D, start2D, end2D, ang, axis, length;
		
			var len, mat;
	// Arrow length
	len = point3D_distance(cam_from, el_edit.world_pos) * view_3d_control_size * view_control_ratio * (tool_selected != e_tool.TRANSFORM ? .6 : 0.4)
    
	length = len
	// Create matrix
	with (el_edit)
	{
		if (element_type = TYPE_PART)
			mat = array_copy_1d(matrix_edit)
		else
			mat = array_copy_1d(matrix_parent)
		
		mat = matrix_multiply(matrix_create(vec3(0), rotation, vec3(1)), mat)
		
		matrix_remove_scale(mat)
	}
	
	if (view_control_matrix != null && view_control_edit != null)
		mat = view_control_matrix
		
	if(keyboard_check(ord("X")) || keyboard_check(ord("Y")) || keyboard_check(ord("Z"))){
		if(keyboard_check(ord("X"))){
			view_control_edit = e_control.SCA_X
			view_control_value = el_edit.value[e_value.SCA_X]
			axis = X
			keybind_sca_axis = "X"
			el_value_set_start(action_el_sca_xyz, true)
			el_value_set(e_value.SCA_Y, keybind_free_scale_origin[Y], false)
			el_value_set(e_value.SCA_Z, keybind_free_scale_origin[Z], false)
			el_value_set_done()
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Y") : ord("Z"))){
			view_control_edit = e_control.SCA_Y
			view_control_value = el_edit.value[e_value.SCA_Y]
			axis = Y
			keybind_sca_axis = "Y"
			el_value_set_start(action_el_sca_xyz, true)
			el_value_set(e_value.SCA_X, keybind_free_scale_origin[X], false)
			el_value_set(e_value.SCA_Z, keybind_free_scale_origin[Z], false)
			el_value_set_done()
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Z") : ord("Y"))){
		    view_control_edit = e_control.SCA_Z
			view_control_value = el_edit.value[e_value.SCA_Z]
			axis = Z
			keybind_sca_axis = "Z"
			el_value_set_start(action_el_sca_xyz, true)
			el_value_set(e_value.SCA_X, keybind_free_scale_origin[X], false)
			el_value_set(e_value.SCA_Y, keybind_free_scale_origin[Y], false)
			el_value_set_done()
		}
		axisvec = vec3(axis = X, axis = Y, axis = Z)
		if (view_control_length != null)
		   length = view_control_length

	start3D = point3D_mul_matrix(vec3(0), mat)
	end3D = point3D_mul_matrix(vec3_mul(axisvec, length), mat)

	// Convert to screen
	start2D = view_shape_project(start3D)
	if (point3D_project_error)
		return 0

	end2D = view_shape_project(end3D)
	if (point3D_project_error)
		return 0
		
			view_control_edit_view = view
			view_control_vec = point2D_sub(end2D, start2D)
			view_control_matrix = mat
			view_control_length = length
			view_control_move_distance = 0

	}

		var coord;
	if (window_busy = "rendercontrol")
	{
		start3D = point3D_mul_matrix(vec3(0), mat)

	// Convert to screen
	start2D = view_shape_project(start3D)
		coord = view_control_scale_coords
     view_control_scale_amount = (point_distance((mouse_wrap_x * content_width) + mouse_x -content_x, (mouse_wrap_y * content_height) + mouse_y -content_y, start2D[X] , start2D[Y] ) / point_distance(mouse_origin_x  -content_x, mouse_origin_y  -content_y, start2D[X] , start2D[Y]))
	}
			
	if(keybind_free_sca && keybind_sca_axis = ""){

			

		if (!mouse_still)
		{
			var snapval, scaleval;
			snapval = (dragger_snap ? setting_snap_size_scale : snap_min)
			scaleval = vec3(view_control_scale_amount)
			
			for (var i = X; i <= Z; i++)
			{
				if (!setting_snap_absolute && dragger_snap)
					scaleval[i] = snap(scaleval[i], snapval)
				
				scaleval[i] = view_control_value_scale[i] * scaleval[i]
				scaleval[i] = el_value_clamp(e_value.SCA_X + i, scaleval[i])
				
				if (setting_snap_absolute || !dragger_snap)
					scaleval[i] = snap(scaleval[i], snapval)
			}
			
			// Update
			axis_edit = X
			el_value_set_start(action_el_sca, true)
			el_value_set(e_value.SCA_X, scaleval[X], false)
			el_value_set(e_value.SCA_Y, scaleval[Y], false)
			el_value_set(e_value.SCA_Z, scaleval[Z], false)
			el_value_set_done()
		}
		// Release
		if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_sca = false
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_sca = false
			
			el_value_set_start(action_el_sca_xyz, true)
			el_value_set(e_value.SCA_X, keybind_free_scale_origin[X], false)
			el_value_set(e_value.SCA_Y, keybind_free_scale_origin[Y], false)
			el_value_set(e_value.SCA_Z, keybind_free_scale_origin[Z], false)
			el_value_set_done()
		}
	}
	else if(keybind_free_sca && keybind_sca_axis != ""){
			mouse_cursor = cr_handpoint
		
		// Move
		var veclen = vec2_length(view_control_vec)
		if (veclen > 0 && !mouse_still)
		{
			var vecmouse, vecdot, move, snapval, newval;
			axis_edit = view_control_edit - e_control.SCA_X
			
			// Find move factor
			vecmouse = vec2(mouse_dx, mouse_dy)
			vecdot = vec2_dot(vec2_normalize(view_control_vec), vec2_normalize(vecmouse))
			view_control_move_distance += ((vec2_length(vecmouse) / veclen) * len * vecdot) * .125 * dragger_multiplier
			
			snapval = (dragger_snap ? setting_snap_size_scale : snap_min)
			move = view_control_move_distance
			
			if (!setting_snap_absolute && dragger_snap)
				move = snap(move, snapval)
			
			newval = view_control_value + move
			newval = el_value_clamp(e_value.SCA_X + axis_edit, newval)
			
			if (setting_snap_absolute || !dragger_snap)
				newval = snap(newval, snapval)
			
			newval -= el_edit.value[e_value.SCA_X + axis_edit]
			
			// Update
			el_value_set_start(action_el_sca, true)
			el_value_set(e_value.SCA_X + axis_edit, newval, true)
			el_value_set_done()
		}
		
		if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_sca = false
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_sca = false
			
			el_value_set_start(action_el_sca_xyz, true)
			el_value_set(e_value.SCA_X, keybind_free_scale_origin[X], false)
			el_value_set(e_value.SCA_Y, keybind_free_scale_origin[Y], false)
			el_value_set(e_value.SCA_Z, keybind_free_scale_origin[Z], false)
			el_value_set_done()
		}
	}

}

