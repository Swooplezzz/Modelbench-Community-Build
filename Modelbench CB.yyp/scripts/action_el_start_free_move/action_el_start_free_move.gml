/// action_el_start_free_move(view)
/// @arg view

function action_el_start_free_move(view)
{
	var normal;
	
	window_busy = "rendercontrol"
	view_control_edit = e_control.POS_PAN
	
	normal = vec3_normalize(point3D_sub(cam_from, el_edit.world_pos))
	
	view_control_edit_view = view
			
	view_control_plane_start(el_edit.world_pos, normal)

	view_control_value = point3D(el_edit.value[e_value.POS_X], el_edit.value[e_value.POS_Y], el_edit.value[e_value.POS_Z])

    keybind_free_move = true
			
	keybind_free_pos_origin = point3D(el_edit.value[e_value.POS_X], el_edit.value[e_value.POS_Y], el_edit.value[e_value.POS_Z])
	keybind_move_axis = ""
}