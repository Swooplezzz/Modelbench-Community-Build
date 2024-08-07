/// model_save_painter_palettes()

function model_save_painter_palettes()
{
	if (ds_list_size(palette_list) = 0)
		return 0
	
	json_save_array_start("palettes")
	
	for (var i = 0; i < ds_list_size(palette_list); i++)
	{
		var palette = palette_list[|i];
		
		json_save_object_start()
		
		json_save_var("name", json_string_encode(palette.name))
		
		json_save_array_start("colors")
	    for (var j = 0; j < array_length(palette.color_list); j++)
	    {
			json_save_array_value(json_string_encode(color_to_hex(palette.color_list[j])))
		}
	
		json_save_array_done()
		json_save_object_done()
	}
	
	json_save_array_done()
}