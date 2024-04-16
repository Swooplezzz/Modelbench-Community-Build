// model_get_max_y()

function model_get_max_y()
{
	var max_y = 0;
	
	with(obj_model_element)
	{
		if (shape_list != null && ds_list_size(shape_list) > 0)
		{
			for (var i = 0; i < ds_list_size(shape_list); i++)
			{
				with (shape_list[|i])
				{
					if ((world_pos[@ Z] + ((value[e_value.HEIGHT] + value[e_value.OFFSET_Z]) * value[e_value.SCA_Z] * app.root_scale)) > max_y)
						max_y = (world_pos[@ Z] + ((value[e_value.HEIGHT] + value[e_value.OFFSET_Z]) * value[e_value.SCA_Z] * app.root_scale));
				}
			}
		}
	}
	return max_y
}