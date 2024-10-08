/// model_reset()

function model_reset()
{
	log("Resetting model")
	
	model_reset_backup()
	history_clear()
	
	res_edit = null
	el_edit = null
	el_edit_amount = 0
	ds_list_clear(el_edit_list)
	
	textures_list.update = true
	tex_preview.update = true
	tex_preview.reset_view = true
	
	model_file = ""
	model_folder = ""
	model_changed = false
	model_temporary = false
	model_temporary_backup = false
	
	model_name = text_get("assetsnewmodel")
	assets.model_properties.tbx_model_name.text = model_name
	res = null
	
	player_skin = false
	floor_box_uvs = false
	model_color = c_white
	root_scale = 1
	
	camera_reset()
	
	popup = null
	with (obj_popup)
	{
		offset_x = 0
		offset_y = 0
	}
	popup_ani_type = "hide"
	
	log("Destroying instances")
	
	with (obj_model_element)
		instance_destroy()
	
	with (obj_texture)
		instance_destroy()
	
	if (part_list != null)
		ds_list_empty(part_list)
	else
		part_list = ds_list_create()
	
	app_update_el_edit()
	
	for (var v = 0; v < e_value.amount; v++)
		value[v] = element_value_default(v)
	
	// Clear toasts
	var t;
	with (obj_toast) 
	{
		t = id
		with (app)
			toast_close(t)
	}
	
	log("Model reset")
}
