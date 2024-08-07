/// palettes_load()

function palettes_load()
{
	if (!file_exists_lib(palette_file))
		return 0
	
	var palettesmap = json_load(palette_file);
	
	if (palettesmap = undefined)
		return 0
	
	with (obj_palette)
		instance_destroy()

	ds_list_clear(palette_list)
	
	var palettes = palettesmap[?"list"];
	
	for (var i = 0; i < ds_list_size(palettes); i++)
	{
		var palettemap = palettes[|i];
		
		if (ds_map_valid(palettemap))
		{
			var paletteobj = new_obj(obj_palette);
			paletteobj.name = value_get_string(palettemap[?"name"], "")
	
			var colorlist = palettemap[?"colors"];
			paletteobj.color_list = value_get_array(colorlist)
			for(var c = 0; c < array_length(paletteobj.color_list); c++)
			{
				paletteobj.color_list[c] = hex_to_color(paletteobj.color_list[c])
			}
			ds_list_add(palette_list, paletteobj)
		}
	}
}