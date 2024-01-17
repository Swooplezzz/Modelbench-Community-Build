// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function action_floor_box_uvs(val){
	if (history_undo)
	{
		with (history_data) 
			other.floor_box_uvs = save_var_old_value[0]
	}
	else if (history_redo)
	{
		with (history_data) 
			other.floor_box_uvs = save_var_new_value[0]
	}
	else
	{
		var hobj = history_save_var_start(action_floor_box_uvs, true);
		
		with (hobj)
			history_save_var(other.id, other.floor_box_uvs, val)
		
		floor_box_uvs = val
		with (obj_model_element)
		{
				if (element_type = TYPE_SHAPE && value[e_value.EXTRUDE] = false)
					update_vbuffer = true
		}
	}
}