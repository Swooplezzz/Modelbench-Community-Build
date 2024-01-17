// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_el_start_free_rotation(view){
		    var normal;
	
			window_busy = "rendercontrol"
			view_control_edit = e_control.ROT_PAN
	


	
			view_control_value = point3D(el_edit.value[e_value.ROT_X], el_edit.value[e_value.ROT_Y], el_edit.value[e_value.ROT_Z])
	        normal = vec3_normalize(point3D_sub(cam_from, el_edit.world_pos))
				view_control_plane_start(el_edit.world_pos, normal)

			view_control_edit_view = view
			el_edit.quat_rot = quat_euler(point3D(el_edit.value[e_value.ROT_X], el_edit.value[e_value.ROT_Y], el_edit.value[e_value.ROT_Z]))
			
			show_debug_message(el_edit.quat_rot);

			
			keybind_free_rot_origin = point3D(el_edit.value[e_value.ROT_X], el_edit.value[e_value.ROT_Y], el_edit.value[e_value.ROT_Z])
            keybind_free_rot = true
			
			mouse_origin_x = mouse_x
			mouse_origin_y = mouse_y
			
			keybind_rot_axis = ""
}