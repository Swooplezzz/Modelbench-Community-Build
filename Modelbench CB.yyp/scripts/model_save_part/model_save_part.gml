/// model_save_part()

function model_save_part()
{
	purename = string_get_name(name)

	if (ds_map_exists(save_name_count_map, purename) || purename = "")
	{
		var count, savename, purename;
		
		count = save_name_count_map[?purename]
		savename = ""
		
		if (purename = "")
		{
			if (count = undefined)
			{
				save_name_count_map[?""] = 1
				count = 1
			}
			else
			{
				save_name_count_map[?""] += 1
				count += 1
			}
			
			repeat (count)
				savename += " "
			
			json_save_var("name", json_string_encode(savename))
		}
		else
		{
			json_save_var("name", json_string_encode(purename + " (" + string(count) + ")"))
			save_name_count_map[?purename] += 1
		}
		
		json_save_var("mb_name", json_string_encode(name))
	}
	else
	{
		json_save_var("name", json_string_encode(purename))
		save_name_count_map[?purename] = 1
	}
	
	if (value[e_value.DEPTH] != 0)
		json_save_var("depth", value[e_value.DEPTH])
	
	if (value[e_value.SHOW_BACKFACES])
		json_save_var("backfaces", value[e_value.SHOW_BACKFACES])
	
	model_save_texture()
	
	model_save_colors()
	
	json_save_var_point3D("position", point3D(value[e_value.POS_X], value[e_value.POS_Y], value[e_value.POS_Z]))
	
	var rot, sca;
	rot = point3D(value[e_value.ROT_X], value[e_value.ROT_Y], value[e_value.ROT_Z])
	sca = point3D(value[e_value.SCA_X], value[e_value.SCA_Y], value[e_value.SCA_Z])
	
	if (!vec3_equals(rot, vec3(0)))
		json_save_var_point3D("rotation", rot)
		
	if (!vec3_equals(sca, vec3(1)))
		json_save_var_point3D("scale", sca)
	
	if (!value[e_value.BEND_LOCK])
		json_save_var("lock_bend", value[e_value.BEND_LOCK])
	
	if (value[e_value.OPEN_POSITION_TAB])
		json_save_var("show_position", true)
		
	//if (value[e_value.IK_TARGET] != null)
	//    json_save_var("ik_target", save_id_get(value[e_value.IK_TARGET]))
	//if (value[e_value.IK_ANGLE_TARGET] != null)
	//    json_save_var("ik_angle_target", save_id_get(value[e_value.IK_ANGLE_TARGET]))
	if (locked)
		json_save_var_bool("locked", true)
	
	if (hidden)
		json_save_var_bool("visible", false)
	
	model_save_bend()
	
	if (!ds_list_empty(shape_list))
	{
		json_save_array_start("shapes")
		
		for (var i = 0; i < ds_list_size(shape_list); i++)
		{
			with (shape_list[|i])
			{
				json_save_object_start()
				model_save_shape()
				json_save_object_done()
			}
		}
		
		json_save_array_done()
	}
	
	model_save_children()
}
