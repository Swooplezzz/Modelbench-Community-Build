/// action_el_start_free_scale(view)
/// @arg view

function action_el_start_free_scale(view)
{
	var mat;

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

	var coord = point3D_project(matrix_position(mat), view_proj_matrix, content_width, content_height);
	var	start3D = point3D_mul_matrix(vec3(0), mat)

	// Convert to screen
	var start2D = view_shape_project(start3D)
	window_busy = "rendercontrol"
	view_control_value_scale[X] = el_edit.value[e_value.SCA_X]
	view_control_value_scale[Y] = el_edit.value[e_value.SCA_Y]
	view_control_value_scale[Z] = el_edit.value[e_value.SCA_Z]
	view_control_edit = e_control.SCA_XYZ
	view_control_edit_view = view
	mouse_origin_x = mouse_x
	mouse_origin_y = mouse_y
	view_control_scale_amount = (point_distance((mouse_wrap_x * content_width) + mouse_x -content_x, (mouse_wrap_y * content_height) + mouse_y -content_y, start2D[X] , start2D[Y] ) / point_distance(mouse_origin_x  -content_x, mouse_origin_y  -content_y, start2D[X] , start2D[Y]))
	view_control_scale_coords[X] = coord[X]
	view_control_scale_coords[Y] = coord[Y]
	keybind_free_sca = true
	keybind_sca_axis = ""
	keybind_free_scale_origin = el_edit.scale
}