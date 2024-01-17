// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pallette_load(){
	var fn = file_dialog_open_pallette();
	if (!file_exists_lib(fn))
		return 0
	
	var pallettemap = json_load(fn);
	
	if (pallettemap = undefined)
		return 0
	
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