/// view_control_move(view)
/// @arg view

function view_control_move_free(view)
{
	var mat, len;
	
	
	
	len = point3D_distance(cam_from, el_edit.world_pos) * view_3d_control_size * view_control_ratio
	
	var axis = 0
	var start = vec3(0, 0, 0)
	with (el_edit)
	{
	if (element_type = TYPE_PART)
			mat = array_copy_1d(matrix_edit)
		else
			mat = array_copy_1d(matrix_parent)
		
		matrix_remove_scale(mat)
	}
	
	var axisvec, center3D, start3D, end3D, center2D, start2D, end2D;
	
	var lenstart = (tool_selected = e_tool.TRANSFORM ? len - len/8 : 0)


		
	view_control_plane_update()
	
	if(keyboard_check(ord("X")) || keyboard_check(ord("Y")) || keyboard_check(ord("Z"))){
		if(keyboard_check(ord("X"))){
			view_control_edit = e_value.POS_X
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_Y, keybind_free_pos_origin[Y], false)
			el_value_set(e_value.POS_Z, keybind_free_pos_origin[Z], false)
			el_value_set_done()
			start = vec3(lenstart, 0, 0)
			axis = X
			keybind_move_axis = "X"
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Y") : ord("Z"))){
			view_control_edit = e_value.POS_Y
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, keybind_free_pos_origin[X], false)
			el_value_set(e_value.POS_Z, keybind_free_pos_origin[Z], false)
			el_value_set_done()
			start = vec3(0, lenstart, 0)
			axis = Y
			keybind_move_axis = "Y"
		}
		if(keyboard_check(setting_z_is_up = true ? ord("Z") : ord("Y"))){
			view_control_edit = e_value.POS_Z
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, keybind_free_pos_origin[X], false)
			el_value_set(e_value.POS_Y, keybind_free_pos_origin[Y], false)
			el_value_set_done()
			start = vec3(0, 0, lenstart)
			axis = Z
			keybind_move_axis = "Z"
		}
			axisvec = vec3(axis = X, axis = Y, axis = Z)

	center3D = point3D_mul_matrix(vec3(0), mat)
	start3D = point3D_mul_matrix(start, mat)
	end3D = point3D_mul_matrix(vec3_mul(axisvec, len), mat)
	
		// Convert to screen
	center2D = view_shape_project(center3D)
	if (point3D_project_error)
		return 0
	
	start2D = view_shape_project(start3D)
	if (point3D_project_error)
		return 0
	
	end2D = view_shape_project(end3D)
	if (point3D_project_error)
		return 0
	
			view_control_edit_view = view
			view_control_value = point3D(el_edit.value[e_value.POS_X], el_edit.value[e_value.POS_Y], el_edit.value[e_value.POS_Z])
			view_control_vec = point2D_sub(end2D, center2D)
			view_control_move_distance = 0
	}

	
	if(keybind_free_move && keybind_move_axis = ""){

			

		if (!mouse_still)
		{
			var move, pos, snapval;
			move = point3D_plane_intersect(view_control_plane_origin, view_control_plane_normal, cam_from, view_control_ray_dir)
			move = point3D_sub(move, view_control_plane_origin)
			move = vec3_mul_matrix(move, matrix_inverse(mat))
			
			snapval = (dragger_snap ? setting_snap_size_position : snap_min)
			
			for (var i = X; i <= Z; i++)
			{
				// Snap distance? (Local snap)
				if (!setting_snap_absolute && dragger_snap)
					move[i] = snap(move[i], snapval)
				
				move[i] /= app.root_scale
				
				// Add object value
				pos[i] = view_control_value[i] + move[i]
				
				// Clamp value
				pos[i] = el_value_clamp(e_value.POS_X + i, pos[i])
				
				// Snap final value? (Absolute snap)
				if (setting_snap_absolute || !dragger_snap)
					pos[i] = snap(pos[i], snapval)
				
				// Get difference
				pos[i] -= el_edit.value[e_value.POS_X + i]
			}
			
			// Update
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, pos[X], true)
			el_value_set(e_value.POS_Y, pos[Y], true)
			el_value_set(e_value.POS_Z, pos[Z], true)
			el_value_set_done()
		}
		// Release
		if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_move = false
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_plane = false
			keybind_free_move = false
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, keybind_free_pos_origin[X], false)
			el_value_set(e_value.POS_Y, keybind_free_pos_origin[Y], false)
			el_value_set(e_value.POS_Z, keybind_free_pos_origin[Z], false)
			el_value_set_done()
		}
	}
	else if(keybind_free_move && keybind_move_axis != ""){
		// Move
		var veclen = vec2_length(view_control_vec);
		if (veclen > 0 && !mouse_still)
		{
	var vecmouse, vecdot, move, snapval, newval;
			move = vec3(0)
			axis_edit = view_control_edit - e_control.POS_X
			
			// Find move factor
			vecmouse = vec2(mouse_dx, mouse_dy)
			vecdot = vec2_dot(vec2_normalize(view_control_vec), vec2_normalize(vecmouse))
			view_control_move_distance += (vec2_length(vecmouse) / veclen) * len * vecdot * dragger_multiplier
			
			snapval = (dragger_snap ? setting_snap_size_position : snap_min)
			
			if (!setting_snap_absolute && dragger_snap)
				move[axis_edit] = snap(view_control_move_distance, snapval)
			else
				move[axis_edit] = view_control_move_distance
			
			for (var i = X; i <= Z; i++)
			{
				move[i] /= app.root_scale
				
				newval[i] = view_control_value[i] + move[i]
				
				newval[i] = el_value_clamp(e_value.POS_X + i, newval[i])
				
				if ((setting_snap_absolute && move[i] != 0) || !dragger_snap)
					newval[i] = snap(newval[i], snapval)
				
				newval[i] -= el_edit.value[e_value.POS_X + i]
			}
			
			// Update
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, newval[X], true)
			el_value_set(e_value.POS_Y, newval[Y], true)
			el_value_set(e_value.POS_Z, newval[Z], true)
			el_value_set_done()
		}
		}
		if (mouse_left)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_move = false
			
		}
		
	    if (mouse_right)
		{
			window_busy = ""
			view_control_edit = null
			view_control_value = 0
			keybind_free_move = false
			el_value_set_start(action_el_pos_xyz, true)
			el_value_set(e_value.POS_X, keybind_free_pos_origin[X], false)
			el_value_set(e_value.POS_Y, keybind_free_pos_origin[Y], false)
			el_value_set(e_value.POS_Z, keybind_free_pos_origin[Z], false)
			el_value_set_done()
		}

}
