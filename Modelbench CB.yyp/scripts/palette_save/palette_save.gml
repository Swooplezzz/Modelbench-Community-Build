/// palette_save(index)
/// @arg index

function palette_save(index)
{
	var fn = file_dialog_save_palette();
	log("Saving palette list", fn)
	
	json_save_start(fn)
	
	var palette = palette_list[|index];
		
	json_save_object_start()
		
	json_save_var("name", json_string_encode(palette.name))
		

	json_save_array_start("colors")
	for (var j = 0; j < array_length(palette.color_list); j++)
	{
		json_save_array_value(json_string_encode(color_to_hex(palette.color_list[j])))
	}
		
	json_save_array_done()
	json_save_object_done()

	
	json_save_done()
	
	debug("Saved recent list")
}