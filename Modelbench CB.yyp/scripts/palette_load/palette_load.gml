/// palette_load()

function palette_load()
{
	var fn
	if(argument_count > 0)
	    fn = argument[0]
	else
	    fn = file_dialog_open_palette();
	if (!file_exists_lib(fn))
		return 0
	
	var palettemap = json_load(fn);
	
	if (palettemap = undefined)
		return 0
	
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