/// model_startup()

function model_startup()
{
	globalvar load_format, load_folder, save_folder, el_edit, el_edit_amount, res_edit,
			  axis_edit, save_id_seed, el_edit_list, save_name_count_map;
	
	el_edit = null
	el_edit_amount = 0
	el_edit_list = ds_list_create()
	res_edit = null
	axis_edit = null
	save_name_count_map = ds_map_create()
	
	save_id = "root"
	save_id_seed = random_get_seed()
	extend = false
	
	part_list = ds_list_create()
	shape_list = null
	res = null
	
	model_file = ""
	model_folder = ""
	model_create_wait = false
	
	model_name = ""
	//model_author = ""
	player_skin = true
	floor_box_uvs = false
	model_color = c_white
	root_scale = 1
	model_temporary = false
	model_changed = false
	
	model_shapes = 0
	model_planes = 0
	model_planes3d = 0
	model_blocks = 0
	model_parts = 0
	model_elements = 0
		
	warning_empty_part_names = false
	warning_same_part_names = false
	
	
	update_vbuffer_list = ds_list_create()
	
	model_recover_show = file_exists_lib(temp_model_backup)

}
