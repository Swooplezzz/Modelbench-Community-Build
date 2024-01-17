function pallettes_load()
{
	if (!file_exists_lib(pallette_file))
		return 0
	
	var pallettesmap = json_load(pallette_file);
	
	if (pallettesmap = undefined)
		return 0
	
	with (obj_pallette)
		instance_destroy()

	ds_list_clear(pallette_list)
	
	var pallettelist = pallettesmap[?"list"];

	
	for (var i = 0; i < ds_list_size(pallettelist); i++)
	{
		var pallettemap = pallettelist[|i];
		
		if (ds_map_valid(pallettemap))
		{
			var palletteobj = new_obj(obj_pallette);
			palletteobj.name = value_get_string(pallettemap[?"name"], "")
	
			var colorlist = pallettemap[?"colorlist"];
			palletteobj.color_list = value_get_array(colorlist)
			for(var c = 0; c < array_length(palletteobj.color_list); c++)
			{
				palletteobj.color_list[c] = hex_to_color(palletteobj.color_list[c])
			}
			ds_list_add(pallette_list, palletteobj)
		}
	}
}