/// pallettes_save()

function pallettes_save()
{
	log("Saving pallette list", pallette_file)
	
	json_save_start(pallette_file)
	json_save_object_start()
	
	json_save_array_start("list")
	
	for (var i = 0; i < ds_list_size(pallette_list); i++)
	{
		var pallette = pallette_list[|i];
		
		json_save_object_start()
		
		json_save_var("name", json_string_encode(pallette.name))
		

		json_save_array_start("colorlist")
	    for (var j = 0; j < array_length(pallette.color_list); j++)
	    {
			json_save_array_value(json_string_encode(color_to_hex(pallette.color_list[j])))
		}
		
		json_save_array_done()
		json_save_object_done()
	}
	
	json_save_array_done()
	json_save_object_done()
	
	json_save_done()
	
	debug("Saved recent list")
}
