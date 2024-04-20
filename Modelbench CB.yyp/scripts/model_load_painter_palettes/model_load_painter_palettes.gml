/// model_load_painter_palettes(map)
/// @arg map

function model_load_painter_palettes(map)
{
	with (obj_palette)
		instance_destroy()

	ds_list_clear(palette_list)
	
	if (!ds_map_valid(map))
		return 0
	show_debug_message("loading palettes")

	if (ds_map_exists(map, "palettelist"))
		var palettelist = map[?"palettelist"];
	else
		return 0
	
	for (var i = 0; i < ds_list_size(palettelist); i++)
	{
		show_debug_message("Object palette")
		var palettemap = palettelist[|i];
		
		if (ds_map_valid(palettemap))
		{
			var paletteobj = new_obj(obj_palette);
			paletteobj.name = value_get_string(palettemap[?"name"], "")
			
			var colorlist = palettemap[?"colorlist"];
			paletteobj.color_list = value_get_array(colorlist)
			for (var c = 0; c < array_length(paletteobj.color_list); c++)
			{
				paletteobj.color_list[c] = hex_to_color(paletteobj.color_list[c])
			}
			ds_list_add(palette_list, paletteobj)
		}
	}
}