// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function model_get_min_y(){
	var min_y;
	min_y = 0;
	with(obj_model_element){
		if (shape_list != null && ds_list_size(shape_list) > 0)
		{
			for (var i = 0; i < ds_list_size(shape_list); i++)
			{
				with (shape_list[|i]){
					if((world_pos[@ Z]  - ((value[e_value.HEIGHT] + value[e_value.OFFSET_Z])*value[e_value.SCA_Z]*app.root_scale/2)) < min_y){
						min_y = (world_pos[@ Z] - ((value[e_value.HEIGHT] + value[e_value.OFFSET_Z])*value[e_value.SCA_Z]*app.root_scale/2));
					}
				}
					
			}
		} 
	}
		return min_y
}